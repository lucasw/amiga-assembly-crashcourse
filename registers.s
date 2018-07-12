BASEADD  EQU $dff000

; registers
; store without the dff so that the copper list can use them.
DMACONR    EQU    $002
ADKCONR    EQU    $010
INTENAR    EQU    $01c
INTREQR    EQU    $01e

BLTCON0  EQU $040
BLTCON1  EQU $042
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

;; BLTCON? configuration

;; http://amigadev.elowar.com/read/ADCD_2.1/Hardware_Manual_guide/node011C.html
;; blitter logic function minterm truth table
;; fill in D column for desired function
;;       A       B       C       D
;;       -       -       -       -
;;       0       0       0       0
;;       0       0       1       0
;;       0       1       0       0
;;       0       1       1       0
;;       1       0       0       1
;;       1       0       1       1
;;       1       1       0       1
;;       1       1       1       1
;;
;; then read D column from bottom up = 11110000 = $f0
;; this is used in the LF? bits
BLIT_DEST  equ $100
BLIT_SRCC      equ $200
BLIT_SRCB      equ $400
BLIT_SRCA      equ $800
BLIT_ASHIFTSHIFT equ 12   ;Bit index of ASH? bits

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

  ;        fedcba9876543210

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

; INTENA
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

