; registers

DMACONR    EQU    $dff002
ADKCONR    EQU    $dff010
INTENAR    EQU    $dff01c
INTREQR    EQU    $dff01e

DMACON    EQU    $dff096
ADKCON    EQU    $dff09e
INTENA    EQU    $dff09a
INTREQ    EQU    $dff09c

BPLCON0    EQU             $dff100
BPLCON1    EQU             $dff102
BPL1MOD    EQU             $dff108
BPL2MOD    EQU             $dff10a
DIWSTRT    EQU             $dff08e
DIWSTOP    EQU             $dff090
DDFSTRT    EQU             $dff092
DDFSTOP    EQU             $dff094
VPOSR      EQU             $dff004
COP1LCH    EQU             $dff080

CIAAPRA    EQU             $bfe001

CIAASDR    EQU             $bfec01

JOY0DAT EQU $dff00a
JOY1DAT EQU $dff00c

SPR0PTH EQU $dff120 ; Sprite 0 pointer (high 5 bits)
SPR0PTL EQU $dff122 ; Sprite 0 pointer (low 15 bits)
SPR1PTH EQU $dff124 ; Sprite 1 pointer (high 5 bits)
SPR1PTL EQU $dff126 ; Sprite 1 pointer (low 15 bits)
SPR2PTH EQU $dff128 ; Sprite 2 pointer (high 5 bits)
SPR2PTL EQU $dff12A ; Sprite 2 pointer (low 15 bits)
SPR3PTH EQU $dff12C ; Sprite 3 pointer (high 5 bits)
SPR3PTL EQU $dff12E ; Sprite 3 pointer (low 15 bits)
SPR4PTH EQU $dff130 ; Sprite 4 pointer (high 5 bits)
SPR4PTL EQU $dff132 ; Sprite 4 pointer (low 15 bits)
SPR5PTH EQU $dff134 ; Sprite 5 pointer (high 5 bits)
SPR5PTL EQU $dff136 ; Sprite 5 pointer (low 15 bits)
SPR6PTH EQU $dff138 ; Sprite 6 pointer (high 5 bits)
SPR6PTL EQU $dff13A ; Sprite 6 pointer (low 15 bits)
SPR7PTH EQU $dff13C ; Sprite 7 pointer (high 5 bits)
SPR7PTL EQU $dff13E ; Sprite 7 pointer (low 15 bits)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; DMA memory is 0x0 - 0x7FFFF
SHIP_DST EQU $25000
FIREBALL_DST EQU $25000+ship_data-fireball_data
DUMMY_DST EQU $30000

init:
  ; store data in hardwareregisters ORed with $8000
  ;(bit 15 is a write-set bit when values are written back into the system)
  move.w DMACONR,d0
  or.w #$8000,d0
  move.w d0,olddmareq
  move.w INTENAR,d0
  or.w #$8000,d0
  move.w d0,oldintena
  move.w INTREQR,d0
  or.w #$8000,d0
  move.w d0,oldintreq
  move.w ADKCONR,d0
  or.w #$8000,d0
  move.w d0,oldadkcon

  move.l $4,a6
  move.l #gfxname,a1
  moveq  #0,d0
  jsr  -552(a6)
  move.l d0,gfxbase
  move.l d0,a6
  move.l 34(a6),oldview
  move.l 38(a6),oldcopper

  move.l #0,a1
  jsr -222(a6)  ; LoadView
  jsr -270(a6)  ; WaitTOF
  jsr -270(a6)  ; WaitTOF
  move.l $4,a6
  jsr -132(a6)  ; Forbid

  ; setup displayhardware to show a 320x200px 3 bitplanes playfield
  ; with zero horizontal scroll and zero modulos
  move.w #$3200,BPLCON0      ; three bitplanes
  move.w #$0000,BPLCON1      ; horizontal scroll 0
  move.w #$0050,BPL1MOD      ; odd modulo
  move.w #$0050,BPL2MOD      ; even modulo
  move.w #$2c81,DIWSTRT      ; DIWSTRT - topleft corner (2c81)
  move.w #$c8d1,DIWSTOP      ; DIWSTOP - bottomright corner (c8d1)
  ;move.w #$c8f1,DIWSTOP      ; DIWSTOP - bottomright corner (c8d1)
  move.w #$0038,DDFSTRT      ; DDFSTRT
  move.w #$00d0,DDFSTOP      ; DDFSTOP
  move.w #%1000000110100000,DMACON  ; DMA set ON
  move.w #%0000000001011111,DMACON  ; DMA set OFF
  move.w #%1100000000000000,INTENA  ; IRQ set ON
  move.w #%0011111111111111,INTENA  ; IRQ set OFF

  ; TODO(lucasw) make this general for loading any sprite
  ; the ship sprite
  move.l #SHIP_DST,a1
  move.l #ship_data,a2
  move.w #32,d0
  shiploop:
    move.l (a2)+,(a1)+
    dbra d0,shiploop

  move.l #FIREBALL_DST,a1
  move.l #fireball_data,a2
  move.w #8,d0
  fireballloop:
    move.l (a2)+,(a1)+
    dbra d0,fireballloop

  ; the dummy sprite
  move.l #$00000000,DUMMY_DST

mainloop:
  move.l frame,d1
  move.l #copper,a6
  addq.l #1,d1
  move.l d1,frame

  ; write instructions into copperlist
  ; TODO(lucasw) couldn't this be done once if they aren't changing?

  ; this scrolls vertically, but doesn't wrap(?)
  ;mulu.w 120,d1
  ; scroll slowly
  lsr #3,d1

  ; bitplane 0
  move.l #bitplanes,d0
  ; this scrolls but the when the loop happens the colors will have shifted
  add.w d1,d0  ; scroll very quickly- 8 pixels per increment
  move.w #$00e2,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e2 BPL1PTL  Bitplane pointer 1 (low 15 bits)
  swap d0
  move.w #$00e0,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e0 BPL1PTH  Bitplane pointer 1 (high 5 bits)

  ; bitplane 1
  move.l #bitplanes+40,d0
  add.l d1,d0
  move.w #$00e6,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e6 BPL2PTL  Bitplane pointer 2 (low 15 bits)
  swap d0
  move.w #$00e4,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e4 BPL2PTH  Bitplane pointer 2 (high 5 bits)

  ; bitplane 2
  move.l #bitplanes+80,d0
  add.l d1,d0
  move.w #$00ea,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0ea BPL3PTL  Bitplane pointer 3 (low 15 bits) 
  swap d0
  move.w #$00e8,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e8 BPL3PTH Bitplane pointer 3 (high 5 bits)

  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palette
  move.l #$01800000,(a6)+  ; color 0
  move.l #$01820666,(a6)+  ; color 1
  move.l #$01840890,(a6)+  ; color 2
  move.l #$01860450,(a6)+  ; color 3
  move.l #$01880e03,(a6)+  ; color 4
  move.l #$018a0ed0,(a6)+  ; color 5
  move.l #$018c0e60,(a6)+  ; color 6
  move.l #$018e0e60,(a6)+  ; color 7
  move.l #$01900e60,(a6)+  ; color 8
  move.l #$01920e60,(a6)+  ; color 9
  move.l #$01940e60,(a6)+  ; color 10
  move.l #$01960e60,(a6)+  ; color 11
  move.l #$01980e60,(a6)+  ; color 12
  move.l #$019a0e60,(a6)+  ; color 13
  move.l #$019c0e60,(a6)+  ; color 14
  move.l #$019e0e60,(a6)+  ; color 15
  ; sprite 0,1 - the ship
  move.l #$01a00000,(a6)+  ; color 16
  move.l #$01a20000,(a6)+  ; color 17
  move.l #$01a40a44,(a6)+  ; color 18
  move.l #$01a60fff,(a6)+  ; color 19
  ; sprite 2,3 the fireball
  move.l #$01a80000,(a6)+  ; color 20
  move.l #$01aa0fd0,(a6)+  ; color 21
  move.l #$01ac0ffc,(a6)+  ; color 22
  move.l #$01ae0fff,(a6)+  ; color 23
  ; sprite 4,5
  ; move.l #$01a80fd0,(a6)+  ; color 25
  ; move.l #$01aa0ffc,(a6)+  ; color 26
  ; move.l #$01ac0fff,(a6)+  ; color 27
  ; move.l #$01ac0fff,(a6)+  ; color 27
  ; TODO(lucasw) unless wanting to cycle colors, could store the address
  ; at end of static copper list and then use it below for dynamic copper list stuff?

  bra skip3
  move.l #32,d0 ; Number of iterations
  move.l #$07,d1 ; Current row wait
  move.l #sin32_15,a0 ; Sine base
  move.l frame,d2 ; Current sine
  scrollrows:
    ; Wait for correct offset row
    move.w d1,(a6)+
    move.w #$fffe,(a6)+
    ; Fetch sine from table
    move.l d2,d3
    and.l #$1f,d3
    move.b (a0,d3),d4
    ; Transform sine to horizontal offset value
    move.l d4,d5
    lsl.l #4,d4
    add.l d4,d5
    ; Add horizontal offset to copperlist - BPLCON1
    move.w #$0102,(a6)+
    move.w d5,(a6)+
    ; Proceed to next row that we want to offset
    add.l #$500,d1
    ; Move to next sine position for next offset row
    addq.w #1,d2
    subq.w #1,d0
    bne scrollrows
  skip3:

  ; scroll every row the same
  move.w #$0102,(a6)+  ; BPLCON1
  move.l frame,d2
  ; lsr #2,d2  ; slow down the scrolling
  and.w #$000f,d2
  move.w #$f,d3
  sub.w d2,d3
  ; duplicate the 4bit horiz scroll value for both playfields (we are in single pf mode)
  move.w d3,d2
  lsl.w #4,d2
  add.w d2,d3
  move.w d3,(a6)+

  ; end of copperlist
  move.l #$fffffffe,(a6)+

  ; setup sprite registers, have to be setup every vblank
  move.l #SHIP_DST,SPR0PTH     ; Sprite 0 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR1PTH     ; Sprite 1 pointer = $30000 dummy sprite
  move.l #FIREBALL_DST,SPR2PTH     ; Sprite 2 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR3PTH     ; Sprite 3 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR4PTH     ; Sprite 4 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR5PTH     ; Sprite 5 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR6PTH     ; Sprite 6 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR7PTH     ; Sprite 7 pointer = $25000 actually used sprite

  ; detect key press, use special keys for now
  ;cmp.b #$37,SKEYS  ; shift left
  ;beq move_left
  ;cmp.b #$3d,SKEYS  ; shift right
  ;beq move_right
  ;move.w #0,d1
  ;bra done_keys
  ;move_left:
  ;  move.w #-1,d1
  ;  bra done_keys
  ;move_right:
  ;  move.w #1,d1
  ;done_keys:

  ; debug command, use w 0 100 2 to set a breakpoint here
  ;clr.w $100

  ; detect joystick left/right
  ; move.w JOY1DAT,d2
  ; btst.l #9,d2
  ; bne move_left
  ; btst.l #1,d2
  ; bne move_right
  ; bra done_joy
  ; jmp done_joy_left_right

  ; http://eab.abime.net/showthread.php?t=75779&page=3
  move.l JOY0DAT,d0
  move.l d0,d1
  add.l d1,d1
  eor.l d0,d1

  ; d2 is the left/right move value
  move.w #0,d2
  ; d3 is the up/down move value
  move.w #0,d3

  test_left:
    btst.l #9,d0
    bne move_left
    bra test_right
    move_left:
      add.w #-1,d2
  test_right:
    btst.l #1,d0
    bne move_right
    bra test_up
    move_right:
      add.w #1,d2
  test_up:
    btst.l #9,d1
    bne move_up
    bra test_down
    move_up:
      add.w #-$1,d3
  test_down:
    btst.l #1,d1
    bne move_down
    bra done_joy
    move_down:
      add.w #$1,d3
  done_joy:

ship_update:
  add.b d2,SHIP_DST+1  ; HSTART The offset is relative to the .b/.w/.l size
  add.b d3,SHIP_DST    ; VSTART
  add.b d3,SHIP_DST+2  ; VSTOP

test_fireball:
  move.l #0,d0
  move.b FIREBALL_DST+1,d0
  cmp.w #250,d0  ; FIREBALL_DST+1
  bge shoot_fireball
update_fireball:
  add.b #2,FIREBALL_DST+1
  bra mouse_test

shoot_fireball:
  ; shoot the fireball at the current ship location
  ; mouse/joy button 2
  btst.b #7,CIAAPRA
  bne mouse_test
  ; copy the ship location first
  move.l (SHIP_DST),(FIREBALL_DST)
  add.b #2,FIREBALL_DST+1 ; offset the hstart to the front of the ship
  add.b #12,FIREBALL_DST  ; offset the start position to so fire from middle of ship
  ; the fireball vstop needs to be reset to vstart then the height of the fireball added
  move.b FIREBALL_DST,FIREBALL_DST+2  ; VSTOP
  add.b #8,FIREBALL_DST+2

mouse_test:
  ; if mousebutton/joystick 1 or 2 pressed then exit
  ; mouse/joy button 1
  btst.b #6,CIAAPRA
  beq exit
  ; btst.b #7,CIAAPRA
  ; beq exit

; Wait for vertical blanking before taking the copper list into use
waitVB:
  move.l VPOSR,d0
  and.l #$1ff00,d0
  cmp.l #300<<8,d0
  bne waitVB

  ; Take copper list into use
  move.l #copper,a6
  move.l a6,COP1LCH
  bra mainloop

exit:
; exit gracefully - reverse everything done in init
  move.w #$7fff,DMACON
  move.w olddmareq,DMACON
  move.w #$7fff,INTENA
  move.w oldintena,INTENA
  move.w #$7fff,INTREQ
  move.w oldintreq,INTREQ
  move.w #$7fff,ADKCON
  move.w oldadkcon,ADKCON

  move.l oldcopper,COP1LCH
  move.l gfxbase,a6
  move.l oldview,a1
  jsr -222(a6)  ; LoadView
  jsr -270(a6)  ; WaitTOF
  jsr -270(a6)  ; WaitTOF
  move.l $4,a6
  jsr -138(a6)  ; Permit

  ; end program
  rts

; *******************************************************************************
; *******************************************************************************
; DATA
; *******************************************************************************
; *******************************************************************************

; storage for 32-bit addresses and data
  CNOP 0,4
oldview: dc.l 0
oldcopper: dc.l 0
gfxbase: dc.l 0
frame:
  dc.l 0
  ; storage for 16-bit data
  CNOP 0,4
olddmareq: dc.w 0
oldintreq: dc.w 0
oldintena: dc.w 0
oldadkcon: dc.w 0

; storage for 8-bit data
  CNOP 0,4
sin32_15:
  dc.b 8,9,10,12,13,14,14,15,15,15,14,14,13,12,10,9,8,6,5,3,2,1,1,0,0,0,1,1,2,3,5,6
  CNOP 0,4
gfxname:
  dc.b 'graphics.library',0
  Section ChipRAM,Data_c
  CNOP 0,4

; TODO(lucasw) is this actually chip ram, and it should go somewhere else and only
; be copied to chip ram as needed?

; no bitplanes for sprites, just the raw data of indices to the palette
; adapted from http://amigadev.elowar.com/read/ADCD_2.1/Hardware_Manual_guide/node02D2.html
; Sprite data for spaceship sprite
; TODO(lucasw) load this from raw file
ship_data:
  dc.w    $7060,$9000             ;VSTART, HSTART, VSTOP
  incbin "gimp/ship.data.raw"
  CNOP 4,4             ; End of sprite data
fireball_data:
  dc.w    $00ff,$1000             ;VSTART, HSTART, VSTOP
  incbin "gimp/fireball.data.raw"
  CNOP 4,4             ; End of sprite data
bitplanes:
  incbin "gimp/indexed_color_amiga.data.raw"
  ; is the image 320 * 160 pixels, so filling in zeros for final 200-160=40 rows?
  blk.b 320/8*3*(200-160),0
  ; datalists aligned to 32-bit
  CNOP 0,4
copper:
  dc.l $ffffffe ; end of copper list
  blk.l 1023,0

