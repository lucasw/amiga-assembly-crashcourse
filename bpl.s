BASEADD  EQU $dff000

; registers
; store without the dff so that the copper list can use them.
DMACONR    EQU    $002
ADKCONR    EQU    $010
INTENAR    EQU    $01c
INTREQR    EQU    $01e

BLTCON0  EQU $040
BLTCON1  EQU $041
BLTAFWM  EQU $044
BLTALWM  EQU $046

BLTCPTH  EQU $048
BLTCPTL  EQU $04a
BLTBPTH  EQU $04c
BLTBPTL  EQU $04e
BLTAPTH  EQU $050
BLTAPTL  EQU $052
BLTDPTH  EQU $054
BLTDPTL  EQU $056

BLTSIZE  EQU $058
; AGA only
;BLTSIZV  EQU $05c
;BLTSIZH  EQU $05e

BLTCMOD  EQU $060  ; modulo source C
BLTBMOD  EQU $062  ; modulo source B
BLTAMOD  EQU $064  ; modulo source A
BLTDMOD  EQU $066  ; modulo destination D

DMACON    EQU    $096
ADKCON    EQU    $09e
INTENA    EQU    $09a
INTREQ    EQU    $09c

; audio
AUD0LCH  EQU $0a0
AUD0LCL  EQU $0a2
AUD0LEN  EQU $0a4
AUD0PER  EQU $0a6  ; 124 -> 28.86 KHz, 447 -> 8 KHz
AUD0VOL  EQU $0a8
AUD0DAT  EQU $0aa

AUD1DAT  EQU $0ba
AUD2DAT  EQU $0ca
AUD3DAT  EQU $0da

CLXCON   EQU  $098  ; collision control
CLXCON2  EQU  $10e  ; collision control
CLXDAT   EQU  $00e  ; collision detection

; the 000 is dropped for use in the copper
BPLCON0    EQU             $100
BPLCON1    EQU             $102
BPLCON2    EQU             $104
BPL1MOD    EQU             $108
BPL2MOD    EQU             $10a
DIWSTRT    EQU             $08e
DIWSTOP    EQU             $090
DDFSTRT    EQU             $092
DDFSTOP    EQU             $094
VPOSR      EQU             $004
COP1LCH    EQU             $080
; how is this used?
COP2LCH    EQU             $084

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

; 7-0: /fir1, /fir0, /rdy, /tk0, /wpro/, /chng, /led, ovl
CIAAPRA EQU $bfe001  ; joystick and mouse buttons

CIAASDR    EQU             $bfec01

JOY0DAT EQU $00a
JOY1DAT EQU $00c

; SPRxCTL
;15-08 EV7-EV0 End (stop) vertical value. Low 8 bits
;07  ATT Sprite attach control bit (odd sprites only)
;06  SV9 Start vertical value 10th bit
;05  EV9 End (stop) vertical value 10th bit
;04  SH1=0 Start horizontal value, 70nS increment
;03  SH0=0 Start horizontal value 35nS increment
;02  SV8 Start vertical value 9th bit
;01  EV8 End (stop) vertical value 9th bit
;00  SH2 Start horizontal value, 140nS increment

SPR0CTL EQU $142  ; Sprite 0 position and control data
SPR1CTL EQU $14A  ; Sprite 1 position and control data
SPR2CTL EQU $152  ; Sprite 2 position and control data
SPR3CTL EQU $15A  ; Sprite 3 position and control data
SPR4CTL EQU $162  ; Sprite 4 position and control data
SPR5CTL EQU $16A  ; Sprite 5 position and control data
SPR6CTL EQU $172  ; Sprite 6 position and control data
SPR7CTL EQU $17A  ; Sprite 7 position and control data

SPR0PTH EQU $120 ; Sprite 0 pointer (high 5 bits)
SPR0PTL EQU $122 ; Sprite 0 pointer (low 15 bits)
SPR1PTH EQU $124 ; Sprite 1 pointer (high 5 bits)
SPR1PTL EQU $126 ; Sprite 1 pointer (low 15 bits)
SPR2PTH EQU $128 ; Sprite 2 pointer (high 5 bits)
SPR2PTL EQU $12A ; Sprite 2 pointer (low 15 bits)
SPR3PTH EQU $12C ; Sprite 3 pointer (high 5 bits)
SPR3PTL EQU $12E ; Sprite 3 pointer (low 15 bits)
SPR4PTH EQU $130 ; Sprite 4 pointer (high 5 bits)
SPR4PTL EQU $132 ; Sprite 4 pointer (low 15 bits)
SPR5PTH EQU $134 ; Sprite 5 pointer (high 5 bits)
SPR5PTL EQU $136 ; Sprite 5 pointer (low 15 bits)
SPR6PTH EQU $138 ; Sprite 6 pointer (high 5 bits)
SPR6PTL EQU $13A ; Sprite 6 pointer (low 15 bits)
SPR7PTH EQU $13C ; Sprite 7 pointer (high 5 bits)
SPR7PTL EQU $13E ; Sprite 7 pointer (low 15 bits)

; colors
; playfield 1
COLOR00 EQU $180
COLOR01 EQU $182
COLOR02 EQU $184
COLOR03 EQU $186
COLOR04 EQU $188
COLOR05 EQU $18a
COLOR06 EQU $18c
COLOR07 EQU $18e
COLOR08 EQU $190
COLOR09 EQU $192
COLOR10 EQU $194
COLOR11 EQU $196
COLOR12 EQU $198
COLOR13 EQU $19a
COLOR14 EQU $19c
COLOR15 EQU $19e
; sprite 0,1
COLOR16 EQU $1a0
COLOR17 EQU $1a2
COLOR18 EQU $1a4
COLOR19 EQU $1a6
; sprite 2,3
COLOR20 EQU $1a8
COLOR21 EQU $1aa
COLOR22 EQU $1ac
COLOR23 EQU $1ae
; sprite 4,5
COLOR24 EQU $1b0
COLOR25 EQU $1b2
COLOR26 EQU $1b4
COLOR27 EQU $1b6
; sprite 6,7
COLOR28 EQU $1b8
COLOR29 EQU $1ba
COLOR30 EQU $1bc
COLOR31 EQU $1be

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SCREEN_WIDTH EQU 320
PF_WIDTH EQU 640

init:
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

  ; allow all sprites to collide with each other
  move.b #$f0,BASEADD+CLXCON+1

  ; setup displayhardware to show a 640x200px 3 bitplanes playfield
  ; with zero horizontal scroll and zero modulos
  ; move.w #$3200,BPLCON0      ; three bitplanes, single playfield
  move.w #$6600,BASEADD+BPLCON0      ; three bitplanes, dual playfield
  move.w #$0000,BASEADD+BPLCON1      ; horizontal scroll 0
  ; move.w BPLCON2,d0  ; moving BPLCON2 seems to change it
  move.b #$1f,BASEADD+BPLCON2      ; priority

  ; move.w #$0004,BASEADD+BPLCON2      ; priority
  ; horizontal arrangement- given that the 3 color channels are on one row
  ; bplmod = (width of the playfield * (num bitplanes) - width screen) / 8
  ; move.w #$00c8,BPL1MOD      ; odd modulo
  ; move.w #$00c8,BPL2MOD      ; even modulo
  ; vertical arrangement
  ; bplmod = (width of the playfield - width screen) / 8
  move.w #(PF_WIDTH-SCREEN_WIDTH)/8,BASEADD+BPL1MOD      ; odd modulo
  move.w #(PF_WIDTH-SCREEN_WIDTH)/8,BASEADD+BPL2MOD      ; even modulo
  move.w #$2c91,BASEADD+DIWSTRT      ; DIWSTRT - topleft corner (2c81)
  move.w #$f8c1,BASEADD+DIWSTOP      ; DIWSTOP - bottomright corner (c8d1)
  move.w #$0038,BASEADD+DDFSTRT      ; DDFSTRT
  move.w #$00d0,BASEADD+DDFSTOP      ; DDFSTOP
; DMACON
;15  SET/CLR Set/Clear control bit. Determines if bits
;written with a 1 get set or cleared
;Bits written with a zero are unchanged
;14  BBUSY Blitter busy status bit (read only)
;13  BZERO Blitter logic zero status bit (read only)
;12  X
;11  X
;10  BLTPRI  Blitter DMA priority (over CPU micro)
;(also called "blitter nasty")
;(disables /BLS pin, preventing micro
;from stealing any bus cycles while
;blitter DMA is running)
;09  DMAEN Enable all DMA below (also UHRES DMA)
;08  BPLEN Bit plane DMA enable
;07  COPEN Coprocessor DMA enable
;06  BLTEN Blitter DMA enable
;05  SPREN Sprite DMA enable
;04  DSKEN Disk DMA enable
;03  AUD3EN  Audio channel 3 DMA enable
;02  AUD2EN  Audio channel 2 DMA enable
;01  AUD1EN  Audio channel 1 DMA enable
;00  AUD0EN  Audio channel 0 DMA enable
  ;move.w #%1000000111100000,BASEADD+DMACON  ; DMA set ON
  move.w #%1000000010000000,BASEADD+DMACON  ; DMA set ON
  move.w #%0000000000011111,BASEADD+DMACON  ; DMA set OFF

; 15  SET/CLR   Set/clear control bit. Determines if bits
; written with a 1 get set or cleared. Bits
; written with a zero are always unchanged.
; 14  INTEN   Master interrupt (enable only, no request)
; 13  EXTER 6 External interrupt
; 12  DSKSYN  5 Disk sync register (DSKSYNC) matches disk
; 11  RBF 5 Serial port receive buffer full
; 10  AUD3  4 Audio channel 3 block finished
; 09  AUD2  4 Audio channel 2 block finished
; 08  AUD1  4 Audio channel 1 block finished
; 07  AUD0  4 Audio channel 0 block finished
; 06  BLIT  3 Blitter has finished
; 05  VERTB 3 Start of vertical blank
; 04  COPER 3 Coprocessor
; 03  PORTS 2 I/O Ports and timers
; 02  SOFT  1 Reserved for software initiated interrupt.
; 01  DSKBLK  1 Disk block finished
; 00  TBE 1 Serial port transmit buffer empty
  move.w #%1100000000000000,BASEADD+INTENA  ; IRQ set ON
  move.w #%0011111111111111,BASEADD+INTENA  ; IRQ set OFF

main_loop:
  ; increment frame count
  addq.l #1,frame
  ;move.l frame,d1
  ;addq.l #1,d1
  ;move.l d1,frame

  ; write instructions into copperlist
  ; TODO(lucasw) couldn't this be done once if they aren't changing?

  ; start setting up copper list
  move.l #copper_list,a6
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; mountains bitplanes

  move.l frame,d1
  lsr #7,d1 ; scroll slowly
  move.l #sky_data,d0
  add.w d1,d0  ; scroll 8 pixels per increment
  move.w #BPL2PTL,d2
  move.w #BPL2PTH,d3
  jsr load_bpl

  move.l #sky_data+16000,d0
  add.l d1,d0
  move.w #BPL4PTL,d2
  move.w #BPL4PTH,d3
  jsr load_bpl

  move.l #sky_data+32000,d0
  add.l d1,d0
  move.w #BPL6PTL,d2
  move.w #BPL6PTH,d3
  jsr load_bpl

  ;;;;;;;;;;;;;;;;;;;;;;
  ; mountains bitplanes
  move.l pf_scroll_x,d1
  lsr #3,d1  ; divide by 8 for byte scroll value
  move.l #mountains_data,d0
  add.w d1,d0  ; scroll 8 pixels when scroll_x/8 increments
  move.w #BPL1PTL,d2
  move.w #BPL1PTH,d3
  jsr load_bpl

  move.l #mountains_data+16000,d0
  add.w d1,d0
  move.w #BPL3PTL,d2
  move.w #BPL3PTH,d3
  jsr load_bpl

  move.l #mountains_data+32000,d0
  add.w d1,d0
  move.w #BPL5PTL,d2
  move.w #BPL5PTH,d3
  jsr load_bpl

  bra skip_load_bpl
load_bpl:  ; d0 is the movement amount, d2 is the BPLxPTL, d3 is BPLxPTH
  ; a6 is the current copper address, d1 should be untouched
  move.w d2,(a6)+  ; LO-bits of start of bitplane
  move.w d0,(a6)+    ; go into $0e2 BPL1PTL  Bitplane pointer 1 (low 15 bits)
  swap d0
  move.w d3,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $0e0 BPL1PTH  Bitplane pointer 1 (high 5 bits)
  rts
skip_load_bpl
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palett
  ; playfield 1 - foreground mountains
  ;move.w #COLOR00,(a6)+
  ;move.w $0000,(a6)+
  move.l #COLOR00<<16+$0000,(a6)+
  move.l #COLOR01<<16+$0000,(a6)+
  move.l #COLOR02<<16+$0235,(a6)+  ; color 2
  move.l #COLOR03<<16+$0e01,(a6)+  ; color 3
  move.l #COLOR04<<16+$0545,(a6)+  ; color 4
  move.l #COLOR05<<16+$0a36,(a6)+  ; color 5
  move.l #COLOR06<<16+$0569,(a6)+  ; color 6
  move.l #COLOR07<<16+$0b83,(a6)+  ; color 7
  ; playfield 2 - background sky
  move.l #COLOR08<<16+$0000,(a6)+  ; color 8
  move.l #COLOR09<<16+$0fff,(a6)+  ; color 9
  move.l #COLOR10<<16+$0112,(a6)+  ; color 10
  move.l #COLOR11<<16+$0324,(a6)+  ; color 11
  move.l #COLOR12<<16+$0446,(a6)+  ; color 12
  move.l #COLOR13<<16+$0545,(a6)+  ; color 13
  move.l #COLOR14<<16+$0946,(a6)+  ; color 14
  move.l #COLOR15<<16+$0659,(a6)+  ; color 15
  ; sprite 0,1 - the ship
  move.l #COLOR16<<16+$0000,(a6)+  ; color 16
  move.l #COLOR17<<16+$0300,(a6)+  ; color 17
  move.l #COLOR18<<16+$0b43,(a6)+  ; color 18
  move.l #COLOR19<<16+$0d98,(a6)+  ; color 19
  ; sprite 2,3 the fireball
  move.l #COLOR20<<16+$0000,(a6)+  ; color 20
  move.l #COLOR21<<16+$0fd0,(a6)+  ; color 21
  move.l #COLOR22<<16+$0ffc,(a6)+  ; color 22
  move.l #COLOR23<<16+$0fff,(a6)+  ; color 23
  ; sprite 4,5 - enemy bugs
  move.l #COLOR24<<16+$0000,(a6)+  ; color 25
  move.l #COLOR25<<16+$0437,(a6)+  ; color 26
  move.l #COLOR26<<16+$084a,(a6)+  ; color 27
  move.l #COLOR27<<16+$06ab,(a6)+  ; color 29
  ; sprite 6,7 - enemy bugs?
  ; TODO(lucasw) fill these colors in
  ; TODO(lucasw) unless wanting to cycle colors, could store the address
  ; at end of static copper list and then use it below for dynamic copper list stuff?


  ; scroll every row the same
  ; the mountains
  move.w #BPLCON1,(a6)+  ; BPLCON1
  move.l pf_scroll_x,d2
  and.w #$000f,d2  ; only take last four bits for scroll within 1 byte
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
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

  ; Take copper list into use - but only after above updates have been made?
  move.l #copper_list,a6
  move.l a6,BASEADD+COP1LCH  ; this is automatically used at beginning of each vertical blank

  ;;;;;;;;;;;;;
  bra main_loop

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
pf_scroll_x:
  dc.l 0
  CNOP 0,4
blit_yx
  dc.w 0  ; y
  dc.w 0  ; x
do_blit:
  dc.b 0
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
  ; datalists aligned to 32-bit
  CNOP 0,4

copper_list:
  dc.l $ffffffe ; end of copper list
  blk.l 1023,0  ; allocate 1023 instructions?

