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

SHIP_DST EQU $25000
; DUMMY_DST EQU $30000

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
  move.w #$0038,DDFSTRT      ; DDFSTRT
  move.w #$00d0,DDFSTOP      ; DDFSTOP
  move.w #%1000000110100000,DMACON  ; DMA set ON
  move.w #%0000000001011111,DMACON  ; DMA set OFF
  move.w #%1100000000000000,INTENA  ; IRQ set ON
  move.w #%0011111111111111,INTENA  ; IRQ set OFF

mainloop:
  move.l frame,d1
  move.l #copper,a6
  addq.l #1,d1
  move.l d1,frame

  ; bitplane 0
  move.l #bitplanes,d0
  move.w #$00e2,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e2 BPL1PTL  Bitplane pointer 1 (low 15 bits)
  swap d0
  move.w #$00e0,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e0 BPL1PTH  Bitplane pointer 1 (high 5 bits)

  ; bitplane 1
  move.l #bitplanes+40,d0
  move.w #$00e6,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e6 BPL2PTL  Bitplane pointer 2 (low 15 bits)
  swap d0
  move.w #$00e4,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e4 BPL2PTH  Bitplane pointer 2 (high 5 bits)

  ; bitplane 2
  move.l #bitplanes+80,d0
  move.w #$00ea,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0ea BPL3PTL  Bitplane pointer 3 (low 15 bits) 
  swap d0
  move.w #$00e8,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e8 BPL3PTH Bitplane pointer 3 (high 5 bits)

  ; the ship sprite
  move.l #SHIP_DST,a1
  move.l #ship,a2
  shiploop:
    move.l (a2),(a1)+
    cmp.l #$00000000,(a2)+
    bne shiploop
  ; the dummy sprite
  move.l #$00000000,$30000

  ; setup sprite registers
  move.l #$25000,SPR0PTH     ; Sprite 0 pointer = $25000 actually used sprite

  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palette
  move.l #$01800000,(a6)+  ; color 0
  move.l #$01820fff,(a6)+  ; color 1
  move.l #$01840800,(a6)+  ; color 2
  move.l #$01860c00,(a6)+  ; color 3
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
  move.l #$01a00e60,(a6)+  ; color 16
  ; sprite 0
  move.l #$01a20ff0,(a6)+  ; color 17
  move.l #$01a400ff,(a6)+  ; color 18
  move.l #$01a60f0f,(a6)+  ; color 19

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
    ; Add horizontal offset to copperlist
    move.w #$0102,(a6)+
    move.w d5,(a6)+
    ; Proceed to next row that we want to offset
    add.l #$500,d1
    ; Move to next sine position for next offset row
    addq.w #1,d2
    subq.w #1,d0
    bne scrollrows

  ; end of copperlist
  move.l #$fffffffe,(a6)+

  ; if mousebutton/joystick 1 or 2 pressed then exit
  btst.b #6,CIAAPRA
  beq exit
  btst.b #7,CIAAPRA
  beq exit

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

; adapted from http://amigadev.elowar.com/read/ADCD_2.1/Hardware_Manual_guide/node02D2.html
; Sprite data for spaceship sprite
; TODO(lucasw) load this from raw file
ship:
  dc.w    $6D60,$7200             ;VSTART, HSTART, VSTOP
  dc.w    $0990,$07E0             ;First pair of descriptor words
  dc.w    $13C8,$0FF0
  dc.w    $23C4,$1FF8
  dc.w    $13C8,$0FF0
  dc.w    $0990,$07E0
  CNOP 4,4             ; End of sprite data

bitplanes:
  ; incbin "masters3.raw"
  incbin "temp.raw"
  ; is the image 320 * 160 pixels, so filling in zeros for final 200-160 rows?
  blk.b 320/8*3*(200-160),0
  ; datalists aligned to 32-bit
  CNOP 0,4
copper:
  dc.l $ffffffe ; end of copper list
  blk.l 1023,0

