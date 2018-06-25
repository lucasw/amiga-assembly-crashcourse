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
BPLCON2    EQU             $dff104
BPL1MOD    EQU             $dff108
BPL2MOD    EQU             $dff10a
DIWSTRT    EQU             $dff08e
DIWSTOP    EQU             $dff090
DDFSTRT    EQU             $dff092
DDFSTOP    EQU             $dff094
VPOSR      EQU             $dff004
COP1LCH    EQU             $dff080

; the 000 is dropped for use in the copper
BPL1PTH EQU $0e0 ; Bit plane 1 pointer (high 5 bits)
BPL1PTL EQU $0e2 ; Bit plane 1 pointer (low 15 bits)
BPL2PTH EQU $0e4 ; Bit plane 2 pointer (high 5 bits)
BPL2PTL EQU $0e6 ; Bit plane 2 pointer (low 15 bits)
BPL3PTH EQU $0e8 ; Bit plane 3 pointer (high 5 bits)
BPL3PTL EQU $0ea ; Bit plane 3 pointer (low 15 bits)
BPL4PTH EQU $0ec ; Bit plane 4 pointer (high 5 bits)
BPL4PTL EQU $0ee ; Bit plane 4 pointer (low 15 bits)
BPL5PTH EQU $0f0 ; Bit plane 5 pointer (high 5 bits)
BPL5PTL EQU $0f2 ; Bit plane 5 pointer (low 15 bits)
BPL6PTH EQU $0f4 ; Bit plane 6 pointer (high 5 bits)
BPL6PTL EQU $0f6 ; Bit plane 6 pointer (low 15 bits)
BPL7PTH EQU $0f8 ; Bit plane 7 pointer (high 5 bits)
BPL7PTL EQU $0fa ; Bit plane 7 pointer (low 15 bits)
BPL8PTH EQU $0fc ; Bit plane 8 pointer (high 5 bits)
BPL8PTL EQU $0fe ; Bit plane 8 pointer (low 15 bits)

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
FIREBALL_DST EQU $25000+fireball_data-ship_data
BUG_DST EQU SHIP_DST+bug_data-ship_data
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

  ; setup displayhardware to show a 640x200px 3 bitplanes playfield
  ; with zero horizontal scroll and zero modulos
  ; move.w #$3200,BPLCON0      ; three bitplanes, single playfield
  move.w #$6600,BPLCON0      ; three bitplanes, dual playfield
  move.w #$0000,BPLCON1      ; horizontal scroll 0
  ; move.w BPLCON2,d0  ; moving BPLCON2 seems to change it
  move.b #$1f,BPLCON2      ; priority

  ; move.w #$0004,BPLCON2      ; priority
  ; horizontal arrangement- given that the 3 color channels are on one row
  ; bplmod = (width of the playfield * (num bitplanes) - width screen) / 8
  ; move.w #$00c8,BPL1MOD      ; odd modulo
  ; move.w #$00c8,BPL2MOD      ; even modulo
  ; vertical arrangement
  ; bplmod = (width of the playfield - width screen) / 8
  move.w #$0028,BPL1MOD      ; odd modulo
  move.w #$0028,BPL2MOD      ; even modulo
  move.w #$2c91,DIWSTRT      ; DIWSTRT - topleft corner (2c81)
  move.w #$f8c1,DIWSTOP      ; DIWSTOP - bottomright corner (c8d1)
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
  jsr copy_data

  move.l #FIREBALL_DST,a1
  move.l #fireball_data,a2
  move.w #8,d0
  jsr copy_data

  move.l #BUG_DST,a1
  move.l #bug_data,a2
  move.w #16,d0
  jsr copy_data

  bra skip_copy_data
copy_data:
  copy_data_loop:
    move.l (a2)+,(a1)+
    dbra d0,copy_data_loop
  rts

  ; the dummy sprite
  move.l #$00000000,DUMMY_DST
skip_copy_data:

main_loop:
  ; increment frame count
  move.l frame,d1
  addq.l #1,d1
  move.l d1,frame

  ; write instructions into copperlist
  ; TODO(lucasw) couldn't this be done once if they aren't changing?


  ; start setting up copper list
  move.l #copper_list,a6
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; mountains bitplanes

  move.l frame,d1
  lsr #7,d1 ; scroll slowly
  move.l #sky,d0
  ; this scrolls but the when the loop happens the colors will have shifted
  add.w d1,d0  ; scroll 8 pixels per increment
  move.w #BPL2PTL,d2
  move.w #BPL2PTH,d3
  jsr load_bpl

  move.l #sky+16000,d0
  add.l d1,d0
  move.w #BPL4PTL,d2
  move.w #BPL4PTH,d3
  jsr load_bpl

  move.l #sky+32000,d0
  add.l d1,d0
  move.w #BPL6PTL,d2
  move.w #BPL6PTH,d3
  jsr load_bpl

  ;;;;;;;;;;;;;;;;;;;;;;
  ; mountains bitplanes
  move.l frame,d1
  lsr #4,d1
  move.l #mountains,d0
  ; this scrolls but the when the loop happens the colors will have shifted
  add.w d1,d0  ; scroll 8 pixels when this increments
  move.w #BPL1PTL,d2
  move.w #BPL1PTH,d3
  jsr load_bpl

  move.l #mountains+16000,d0
  ; this scrolls but the when the loop happens the colors will have shifted
  add.w d1,d0
  move.w #BPL3PTL,d2
  move.w #BPL3PTH,d3
  jsr load_bpl

  move.l #mountains+32000,d0
  ; this scrolls but the when the loop happens the colors will have shifted
  add.w d1,d0
  move.w #BPL5PTL,d2
  move.w #BPL5PTH,d3
  jsr load_bpl

  bra skip_load_bpl
load_bpl:  ; d0 is the movement amount, d2 is the BPLxPTL, d3 is BPLxPTH
  ; a6 is the current copper address, d1 should be untouched
  move.w d2,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e2 BPL1PTL  Bitplane pointer 1 (low 15 bits)
  swap d0
  move.w d3,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e0 BPL1PTH  Bitplane pointer 1 (high 5 bits)
  rts
skip_load_bpl
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palett
  ; playfield 1
  move.l #$01800000,(a6)+  ; color 0
  move.l #$01820fff,(a6)+  ; color 1
  move.l #$01840569,(a6)+  ; color 2
  move.l #$01860cc3,(a6)+  ; color 3
  move.l #$01880235,(a6)+  ; color 4
  move.l #$018a0545,(a6)+  ; color 5
  move.l #$018c0a46,(a6)+  ; color 6
  move.l #$018e0e60,(a6)+  ; color 7
  ; playfield 2
  move.l #$01900000,(a6)+  ; color 8
  move.l #$01920235,(a6)+  ; color 9
  move.l #$01940e01,(a6)+  ; color 10
  move.l #$01960545,(a6)+  ; color 11
  move.l #$01980a36,(a6)+  ; color 12
  move.l #$019a0569,(a6)+  ; color 13
  move.l #$019c0b83,(a6)+  ; color 14
  move.l #$019e0fff,(a6)+  ; color 15
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
  ; sprite 4,5 - bugs
  move.l #$01b00000,(a6)+  ; color 25
  move.l #$01b20215,(a6)+  ; color 26
  move.l #$01b4084a,(a6)+  ; color 27
  move.l #$01b606ab,(a6)+  ; color 29
  ; sprite 6,7 - bugs?
  ; TODO(lucasw) fill these colors in
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
  ; the mountains
  move.w #$0102,(a6)+  ; BPLCON1
  move.l frame,d2
  lsr #1,d2  ; slow down the scrolling
  and.w #$000f,d2
  move.w #$f,d3
  ; reverse direction because scrolling right
  sub.w d2,d3
  ; scroll playfield2 slowerr
  ; the sky
  move.l frame,d2
  lsr #4,d2  ; slow down the scrolling
  and.w #$000f,d2
  move.w #$f,d4
  ; reverse direction because scrolling right
  sub.w d2,d4
  ; combine the two scroll values
  lsl.w #4,d4
  add.w d4,d3
  move.w d3,(a6)+

  ; end of copperlist
  move.l #$fffffffe,(a6)+

  ; setup sprite registers, have to be setup every vblank
  move.l #SHIP_DST,SPR0PTH     ; Sprite 0 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR1PTH     ; Sprite 1 pointer = $30000 dummy sprite
  move.l #FIREBALL_DST,SPR2PTH     ; Sprite 2 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR3PTH     ; Sprite 3 pointer = $25000 actually used sprite
  move.l #BUG_DST,SPR4PTH     ; Sprite 4 pointer = $25000 actually used sprite
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
  bra done_fireball

shoot_fireball:
  ; shoot the fireball at the current ship location
  ; mouse/joy button 2
  btst.b #7,CIAAPRA
  bne done_fireball
  ; copy the ship location first
  move.l (SHIP_DST),(FIREBALL_DST)
  add.b #2,FIREBALL_DST+1 ; offset the hstart to the front of the ship
  add.b #12,FIREBALL_DST  ; offset the start position to so fire from middle of ship
  ; the fireball vstop needs to be reset to vstart then the height of the fireball added
  move.b FIREBALL_DST,FIREBALL_DST+2  ; VSTOP
  add.b #8,FIREBALL_DST+2
done_fireball:

; update bug/s
  .move.w frame,d0
  ;lsr.w #3,d0
  sub.b #1,BUG_DST+1

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
  move.l #copper_list,a6
  move.l a6,COP1LCH
  bra main_loop

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
bug_data:
  dc.w    $4090,$5000             ;VSTART, HSTART, VSTOP
  incbin "gimp/bug.data.raw"
  CNOP 4,4             ; End of sprite data
sky:
  incbin "gimp/sky.data.raw"
  ; datalists aligned to 32-bit
  CNOP 0,4
mountains:
  incbin "gimp/mountains.data.raw"
  ; datalists aligned to 32-bit
  CNOP 0,4

copper_list:
  dc.l $ffffffe ; end of copper list
  blk.l 1023,0

