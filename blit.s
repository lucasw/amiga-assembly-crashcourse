  include registers.s

SCREEN_WIDTH EQU 320
SCREEN_HEIGHT EQU 200
PF_WIDTH EQU 640
PF_HEIGHT EQU 200
PF_WIDTH_BYTES EQU PF_WIDTH/8
PF_WIDTH_WORDS EQU PF_WIDTH/16
PF_BIT_DEPTH EQU 3
BL_WIDTH EQU 32
BL_HEIGHT EQU 32
BL_WIDTH_BYTES EQU BL_WIDTH/8
BL_WIDTH_WORDS EQU BL_WIDTH/16

backup:
  ; store data in hardwareregisters ORed with $8000
  ;(bit 15 is a write-set bit when values are written back into the system)
  move.w BASEADD+DMACONR,d0
  or.w #$8000,d0
  move.w d0,olddmareq
  move.w BASEADD+INTENAR,d0
  or.w #$8000,d0
  move.w d0,oldintena
  move.w BASEADD+INTREQR,d0
  or.w #$8000,d0
  move.w d0,oldintreq
  move.w BASEADD+ADKCONR,d0
  or.w #$8000,d0
  move.w d0,oldadkcon

init:
  ; boiler plate stuff
  move #$7ff,DMACON(a6) ; disable all dma
  move #$7fff,INTENA(a6) ; disable all interrupts

  ; just get blank screen without this
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

setup:
  ; setup displayhardware to show a 640x200px 3 bitplanes playfield
  ; with zero horizontal scroll and zero modulos
  ;move.w #$3200,BASEADD+BPLCON0      ; three bitplanes, single playfield
  move.w #$6600,BASEADD+BPLCON0      ; three bitplanes, dual playfield
  move.w #$0000,BASEADD+BPLCON1      ; horizontal scroll 0
  ; move.w BPLCON2,d0  ; moving BPLCON2 seems to change it
  move.b #$1f,BASEADD+BPLCON2      ; priority
  ; horizontal arrangement- given that the 3 color channels are on one row
  ; bplmod = (width of the playfield * (num bitplanes) - width screen) / 8
  ; vertical arrangement
  ; bplmod = (width of the playfield - width screen) / 8
  move.w #(PF_WIDTH-SCREEN_WIDTH)/8,BASEADD+BPL1MOD      ; odd modulo
  move.w #(PF_WIDTH-SCREEN_WIDTH)/8,BASEADD+BPL2MOD      ; even modulo
  move.w #$2c91,BASEADD+DIWSTRT      ; DIWSTRT - topleft corner (2c81)
  move.w #$f8c1,BASEADD+DIWSTOP      ; DIWSTOP - bottomright corner (c8d1)
  move.w #$0038,BASEADD+DDFSTRT      ; DDFSTRT
  move.w #$00d0,BASEADD+DDFSTOP      ; DDFSTOP


  ; enable on bitplanes now
  move.w #%1000000101000000,BASEADD+DMACON  ; DMA set ON
  move.w #%0000000010111111,BASEADD+DMACON  ; DMA set OFF
  ;        fedcba9876543210

  move.w #%1100000000000000,BASEADD+INTENA  ; IRQ set ON
  move.w #%0011111111111111,BASEADD+INTENA  ; IRQ set OFF

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palett
  ; playfield 1 - foreground mountains
  move.w #$0000,BASEADD+COLOR00
  move.w #$0000,BASEADD+COLOR01
  move.w #$0235,BASEADD+COLOR02
  move.w #$0e01,BASEADD+COLOR03
  move.w #$0545,BASEADD+COLOR04
  move.w #$0a36,BASEADD+COLOR05
  move.w #$0569,BASEADD+COLOR06
  move.w #$0b83,BASEADD+COLOR07
  ; playfield 2 - background sky
  move.w #$0000,BASEADD+COLOR08
  move.w #$0fff,BASEADD+COLOR09
  move.w #$0112,BASEADD+COLOR10
  move.w #$0324,BASEADD+COLOR11
  move.w #$0446,BASEADD+COLOR12
  move.w #$0545,BASEADD+COLOR13
  move.w #$0946,BASEADD+COLOR14
  move.w #$0659,BASEADD+COLOR15

  ; modify image data for debug
  ;bra skip_modify_bpl
  ;move.l #$1f40,d0
  move.l #(BL_WIDTH_BYTES*BL_HEIGHT*PF_BIT_DEPTH/2-1),d0
  ;move.l #sky_data+32000,a1
  move.l #bl_data,a1
.drawbpl:
  move.w d0,(a1)+
  dbra d0,.drawbpl
skip_modify_bpl:

do_blit:
BL_X EQU 96
BL_Y EQU 80
BL_X_BYTES EQU BL_X/8
BLIT_BLTCON1  equ 0    ;BSH?=0, DOFF=0, EFE=0, IFE=0, FCI=0, DESC=0, LINE=0
BLIT_LF_MINTERM  equ $f0
BLIT_A_SOURCE_SHIFT equ 0

  move.l #2,d0
  move.l #bl_data,a1
  move.l #sky_data,a2
  add.l #(PF_WIDTH_BYTES*BL_Y)+BL_X_BYTES,a2
  ; loop through 3 bit planes
  jsr blit_wait
  move.w #(BLIT_SRCA|BLIT_DEST|BLIT_LF_MINTERM|BLIT_A_SOURCE_SHIFT<<BLIT_ASHIFTSHIFT),BASEADD+BLTCON0
  ; 01ff should write solid 1s to D
  ;move.w #$01ff,BASEADD+BLTCON0
  move.w #BLIT_BLTCON1,BASEADD+BLTCON1
  ;bra end_blit
  move.l #$ffffffff,BASEADD+BLTAFWM
  move.w #0,BASEADD+BLTAMOD
  move.w #PF_WIDTH_BYTES-BL_WIDTH_BYTES,BASEADD+BLTDMOD
.blit_loop:
  jsr blit_wait
  move.l a1,BASEADD+BLTAPTH
  move.l a2,BASEADD+BLTDPTH
  move.w #(BL_HEIGHT<<6)|(BL_WIDTH_WORDS),BASEADD+BLTSIZE
  add.l #(BL_WIDTH_BYTES*BL_HEIGHT),a1
  add.l #16000,a2
  dbra d0,.blit_loop
end_blit:

main_loop:
  ; have to write these every vblank
  ; sky bitplanes
  move.l #sky_data,BASEADD+BPL2PTH
  move.l #sky_data+16000,BASEADD+BPL4PTH
  move.l #sky_data+32000,BASEADD+BPL6PTH
  ; mountains bitplanes
  move.l #mountains_data,BASEADD+BPL1PTH
  move.l #mountains_data+16000,BASEADD+BPL3PTH
  move.l #mountains_data+32000,BASEADD+BPL5PTH

  addq.l #1,frame

mouse_test:
  ; if mousebutton/joystick 1 or 2 pressed then exit
  ; mouse/joy button 1
  btst.b #6,CIAAPRA
  beq exit
  ; btst.b #7,CIAAPRA
  ; beq exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Wait for vertical blanking before taking the copper list into use
wait_vertical_blank:
  move.l BASEADD+VPOSR,d0
  and.l #$1ff00,d0
  cmp.l #300<<8,d0
  bne wait_vertical_blank

  bra main_loop

blit_wait:
  tst BASEADD+DMACONR  ; for compatibility
.wait_blit:
  btst #6,BASEADD+DMACONR
  bne.s .wait_blit
  rts

exit:
; exit gracefully - reverse everything done in init
  move.w #$7fff,BASEADD+DMACON
  move.w olddmareq,BASEADD+DMACON
  move.w #$7fff,BASEADD+INTENA
  move.w oldintena,BASEADD+INTENA
  move.w #$7fff,BASEADD+INTREQ
  move.w oldintreq,BASEADD+INTREQ
  move.w #$7fff,BASEADD+ADKCON
  move.w oldadkcon,BASEADD+ADKCON

  move.l oldcopper,BASEADD+COP1LCH
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
olddmareq: dc.w 0
oldintreq: dc.w 0
oldintena: dc.w 0
oldadkcon: dc.w 0
frame:
  dc.l 0
  ; storage for 16-bit data
  CNOP 0,4
old_ciaapra:
  dc.l 0
  CNOP 0,4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Chip RAM
; DMA (chip-ram) memory is 0x0 - 0x7FFFF
; TODO(lucasw) all data after this chip ram, and what is above is allocated elsewhere?
; so anything below this can be used by the copper list, but the stuff above
; needs to be copied into chip ram by the program.
; Maybe should allocate a big section here instead of using 25000 above
; 0 - 0x7FFFF
gfxbase: dc.l 0 ; TODO(lucasw) moved this from other misc register above, does it matter?
gfxname:
  dc.b 'graphics.library',0
  Section ChipRAM,Data_c
  CNOP 0,4

; TODO(lucasw) make slots for all the sprites that need to be used live
sky_data:  ; TODO(lucasw) what address is this actually?
  incbin "gimp/sky.data.raw"
  ; datalists aligned to 32-bit
  CNOP 0,4
mountains_data:  ; TODO(lucasw) what address is this actually?
  incbin "gimp/mountains.data.raw"
  CNOP 0,4
bl_data:
  incbin "gimp/explosion.data.raw"
  CNOP 0,4
