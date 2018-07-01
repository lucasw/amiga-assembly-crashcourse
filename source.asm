; registers

DMACONR    EQU    $dff002
ADKCONR    EQU    $dff010
INTENAR    EQU    $dff01c
INTREQR    EQU    $dff01e

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
DMACON    EQU    $dff096
ADKCON    EQU    $dff09e
INTENA    EQU    $dff09a
INTREQ    EQU    $dff09c

; audio
AUD0LCH  EQU $dff0a0
AUD0LCL  EQU $dff0a2
AUD0LEN  EQU $dff0a4
AUD0PER  EQU $dff0a6  ; 124 -> 28.86 KHz, 447 -> 8 KHz
AUD0VOL  EQU $dff0a8
AUD0DAT  EQU $dff0aa

AUD1DAT  EQU $dff0ba
AUD2DAT  EQU $dff0ca
AUD3DAT  EQU $dff0da

CLXCON   EQU  $dff098  ; collision control
CLXCON2  EQU  $dff10e  ; collision control
CLXDAT   EQU  $dff00e  ; collision detection

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

; 7-0: /fir1, /fir0, /rdy, /tk0, /wpro/, /chng, /led, ovl
CIAAPRA EQU $bfe001  ; joystick and mouse buttons

CIAASDR    EQU             $bfec01

JOY0DAT EQU $dff00a
JOY1DAT EQU $dff00c

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

SPR0CTL EQU $dff142  ; Sprite 0 position and control data
SPR1CTL EQU $dff14A  ; Sprite 1 position and control data
SPR2CTL EQU $dff152  ; Sprite 2 position and control data
SPR3CTL EQU $dff15A  ; Sprite 3 position and control data
SPR4CTL EQU $dff162  ; Sprite 4 position and control data
SPR5CTL EQU $dff16A  ; Sprite 5 position and control data
SPR6CTL EQU $dff172  ; Sprite 6 position and control data
SPR7CTL EQU $dff17A  ; Sprite 7 position and control data

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

COLOR16 EQU $dff1a0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; DMA (chip-ram) memory is 0x0 - 0x7FFFF
; TODO(lucasw) but what about the sky/mountains memory below?
; can I allocate this below instead of doing this?
; The regular memory may contain many variations on the ship or bugs,
; but the real chip memory just needs what needs to be accessed
; on short notice
SHIP_DST EQU $25000
FIREBALL0_DST EQU SHIP_DST+end_ship_data-ship_data
FIREBALL1_DST EQU FIREBALL0_DST+end_fireball_data-fireball_data
BUG1_DST EQU FIREBALL1_DST+end_fireball_data-fireball_data
BUG2_DST EQU BUG1_DST+end_bug_data-bug_data
DUMMY_DST EQU BUG2_DST+end_bug_data-bug_data

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

  ; allow all sprites to collide with each other
  move.b #$f0,CLXCON+1

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

  move.w #$0080,player_ship    ; y1
  move.w #$00a0,player_ship+4  ; y2
  move.w #$0050,player_ship+2  ; x1
  move.w #$0060,player_ship+6  ; x2

  move.l #FIREBALL0_DST,a1
  move.l #fireball_data,a2
  move.w #8,d0
  jsr copy_data

  move.w #$0070,fireball0    ; y1
  move.w #$0078,fireball0+4  ; y2
  move.w #$00f8,fireball0+2  ; x1
  move.w #$0108,fireball0+6  ; x2

  move.l #FIREBALL1_DST,a1
  move.l #fireball_data,a2
  move.w #8,d0
  jsr copy_data

  move.w #$0060,fireball1    ; y1
  move.w #$0068,fireball1+4  ; y2
  move.w #$00f8,fireball1+2
  move.w #$0108,fireball1+6

  ;;;;;;;;;;;;;;;;;;;
  ; Enemy 0
  move.l #BUG1_DST,a1
  move.l #bug_data,a2
  move.w #16,d0
  jsr copy_data

  ; position the bug
  ; works
  move.w #$0090,enemy0+2  ; x1
  move.w #$00a0,enemy0+6  ; x2
  move.w #$0060,enemy0    ; y1
  move.w #$0070,enemy0+4  ; y2
  move.w #$0003,enemy0+8  ; counter
  ; these glitch the screen up - because using words with non-aligned odd address
  move.b enemy0+1,BUG1_DST    ; VSTART
  move.b enemy0+3,BUG1_DST+1  ; HSTART
  move.b enemy0+5,BUG1_DST+2  ; VSTOP

  ; Enemy 1
  move.l #BUG2_DST,a1
  move.l #bug_data,a2
  move.w #16,d0
  jsr copy_data

  move.w #$00a0,enemy1+2  ; x1
  move.w #$00b0,enemy1+6  ; x2
  move.w #$0080,enemy1    ; y1
  move.w #$0090,enemy1+4  ; y2
  ; these glitch the screen up - because using words with non-aligned odd address
  move.b enemy1+1,BUG2_DST    ; VSTART
  move.b enemy1+3,BUG2_DST+1  ; HSTART
  move.b enemy1+5,BUG2_DST+2  ; VSTOP

  ;;;;;;;;;;;;;;;;;;;;;
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
  move.l frame,d1
  lsr #4,d1
  move.l #mountains_data,d0
  add.w d1,d0  ; scroll 8 pixels when this increments
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
  move.w d0,(a6)+    ; go into $dff0e2 BPL1PTL  Bitplane pointer 1 (low 15 bits)
  swap d0
  move.w d3,(a6)+  ; HI-bits of start of bitplane
  move.w d0,(a6)+    ; go into $dff0e0 BPL1PTH  Bitplane pointer 1 (high 5 bits)
  rts
skip_load_bpl
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; colors, last 3 characters/12 bits are rgb
  ; TODO(lucasw) replace with inc() command to get externally generated palett
  ; playfield 1 - foreground mountains
  move.l #$01800000,(a6)+  ; color 0
  move.l #$01820000,(a6)+  ; color 1
  move.l #$01840235,(a6)+  ; color 2
  move.l #$01860e01,(a6)+  ; color 3
  move.l #$01880545,(a6)+  ; color 4
  move.l #$018a0a36,(a6)+  ; color 5
  move.l #$018c0569,(a6)+  ; color 6
  move.l #$018e0b83,(a6)+  ; color 7
  ; playfield 2 - background sky
  move.l #$01900000,(a6)+  ; color 8
  move.l #$01920fff,(a6)+  ; color 9
  move.l #$01940112,(a6)+  ; color 10
  move.l #$01960324,(a6)+  ; color 11
  move.l #$01980446,(a6)+  ; color 12
  move.l #$019a0545,(a6)+  ; color 13
  move.l #$019c0946,(a6)+  ; color 14
  move.l #$019e0659,(a6)+  ; color 15
  ; sprite 0,1 - the ship
  move.l #$01a00000,(a6)+  ; color 16
  move.l #$01a20300,(a6)+  ; color 17
  move.l #$01a40b43,(a6)+  ; color 18
  move.l #$01a60d98,(a6)+  ; color 19
  ; sprite 2,3 the fireball
  move.l #$01a80000,(a6)+  ; color 20
  move.l #$01aa0fd0,(a6)+  ; color 21
  move.l #$01ac0ffc,(a6)+  ; color 22
  move.l #$01ae0fff,(a6)+  ; color 23
  ; sprite 4,5 - bugs
  move.l #$01b00000,(a6)+  ; color 25
  move.l #$01b20437,(a6)+  ; color 26
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
  ; TODO(lucasw) the calculations to determine the scroll speed
  ; should be done outside of the setting of the copper list?
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
  ; TODO(lucaw) but this isn't the vblank?  or it is still vblank
  ; because before jumping to mainloop there was a wait for vblank.
  move.l #SHIP_DST,SPR0PTH     ; Sprite 0 pointer = $25000 actually used sprite
  move.l #DUMMY_DST,SPR1PTH     ; Sprite 1 pointer = $30000 dummy sprite
  move.l #FIREBALL0_DST,SPR2PTH     ; Sprite 2 pointer = $25000 actually used sprite
  move.l #FIREBALL1_DST,SPR3PTH     ; Sprite 2 pointer = $25000 actually used sprite
  move.l #BUG1_DST,SPR4PTH
  move.l #BUG2_DST,SPR5PTH
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
  ;  move.w #1,d1
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
      add.w #-$2,d3
  test_down:
    btst.l #1,d1
    bne move_down
    bra done_joy
    move_down:
      add.w #$2,d3
  done_joy:

update_ship:
  add.w d2,player_ship+2  ; x
  add.w d2,player_ship+6
  add.w d3,player_ship    ; y
  add.w d3,player_ship+4

  ; limit movement to scrreen
  ; this only works for slow movement, if movement is fast
  ; need to test the player position moving changing it
x_test_left:  ; $48 to $d8
  cmp.w #$48,player_ship+2
  bgt x_test_right
  move.w #$48,player_ship+2
  move.w #$58,player_ship+6
x_test_right:
  cmp.w #$d8,player_ship+2
  blt y_test_top
  move.w #$d8,player_ship+2
  move.w #$e8,player_ship+6
y_test_top:
  cmp.w #$30,player_ship
  bgt y_test_bottom
  move.w #$30,player_ship
  move.w #$50,player_ship+4
y_test_bottom:
  cmp.w #$d0,player_ship
  blt done_xy_test
  move.w #$d0,player_ship
  move.w #$f0,player_ship+4
done_xy_test:

;;;;;;;;;;;;;;;;;;;;;;;
collision_detection:
  move.w CLXDAT,d0
  ; ship bug collision
  btst.l #10,d0
  bne ship_bug_collision
  bra test_fireball_bug_collision
ship_bug_collision:
  ; sub.w #10,player_ship+2
  move.w #$48,player_ship+2
  move.w #$58,player_ship+6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
test_fireball_bug_collision:
  bra fireball_bug_collision  ; temp always test for collisions with rect-rect code
  btst.l #12,d0
  bne fireball_bug_collision
  bra done_collision
fireball_bug_collision:
; TODO(lucasw) this needs to be a double for loop- loop through all
; fireballs, which loop through all enemies
test_enemy_collision:

  ; unrolled loop
  move.l #fireball1,a1
  move.l #enemy0,a0
  jsr rect_rect_detect
  ; the lea method is faster than jsr, but maybe can only be used
  ; from near enough code?
  ; http://www.easy68k.com/paulrsm/doc/trick68k.htm
  ;lea #test_enemy0_collision_return,a0
  ;jmp rect_rect_detect
  jsr test_enemy_collision_return
  move.l #enemy1,a0
  jsr rect_rect_detect
  jsr test_enemy_collision_return

  move.l #fireball0,a1
  move.l #enemy0,a0
  jsr rect_rect_detect
  jsr test_enemy_collision_return
  move.l #enemy1,a0
  jsr rect_rect_detect
  jsr test_enemy_collision_return

  bra done_collision

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
test_enemy_collision_return:
  ; a0 the enemy
  ; a1 the fireball
  cmp.b #$1,d0
  bne done_enemy_collision
  move.w #$100,2(a0)  ; x1
  move.w #$110,6(a0)  ; x2
  jsr new_y_position
  ;move.b frame,(a2)
  ;move.b frame+$10,4(a2)
  ; reset fireball if it hits an enemy
  ; TODO(lucasw) make a subroutine for this- or is that slower?
  move.w #$00fa,2(a1)
  move.w #$010a,6(a1)
  move.w #$0,(a1)
  move.w #$8,4(a1)
done_enemy_collision:
  rts
;;;;;;;;;;;;;;;;;;;;;;;;;

rect_rect_detect:
  ; ~~a0 is return address~~
  ; a0 is rect 1 with y1 x1 y2 x2 in sequential words
  ; a1 is rect 2 with y1 x1 y2 x2 in sequential words
  ; d0 will be set to 1 if there is overlap
  ; can't dow cmp.w 6(a1),2(a2) , the second arg can't be displaced

  move.w (a1),d1
  move.w 4(a0),d2
  ;move.w #5,d1
  ;move.w #4,d2
  ; cmp.w 4(a1),d1  ; fewer instructions, TODO(lucasw) do this once it is working
  cmp.w d1,d2
  blt rect_no_overlap

  move.w (a0),d1
  move.w 4(a1),d2
  cmp.w d1,d2
  blt rect_no_overlap

  move.w 2(a1),d1
  move.w 6(a0),d2
  cmp.w d1,d2
  blt rect_no_overlap

  move.w 2(a0),d1
  move.w 6(a1),d2
  cmp.w d1,d2
  blt rect_no_overlap

  ; there was an overlap
  move.b #$1,d0
  rts
  ;jmp (a0)
rect_no_overlap:
  move.b #$0,d0
  rts
  ;jmp (a0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
done_collision:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
update_fire:
  ; mouse/joy button 2 - TODO(lucasw) capture in interrupt?
  move.b #0,d0  ; don't fire a new fireball
  ; has the joystick button been pressed - rising edge?
  move.b old_ciaapra,d1
  move.b CIAAPRA,d2
  move.b d2,old_ciaapra
  not.b d1
  and.b d2,d1
  ; can't do btst.b on d registers, so instead of btst.b #7:
  and.b #%10000000,d1
  tst.b d1
  beq update_fireballs
  move.b #1,d0  ; do fire a new fireball
update_fireballs:
  ; copy the ship location first
  move.l #fireball0,a0
  jsr test_fireball
  move.l #fireball1,a0
  jsr test_fireball
  bra done_fireballs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; subroutine launch/update fireball
test_fireball:
  cmp.w #$00fa,2(a0)
  bge test_shoot_fireball
move_fireball:
  add.w #2,2(a0)
  add.w #2,6(a0)
  rts
test_shoot_fireball:
  cmp.b #1,d0
  bne done_test_fireball
shoot_fireball:
  ; shoot the fireball at the current ship location
  move.b #0,d0
  move.l player_ship,(a0)
  move.l player_ship,4(a0)
  ;add.w #2,fireball0+2 ; offset the hstart to the front of the ship
  add.w #12,(a0)  ; offset the start position to so fire from middle of ship
  add.w #12,4(a0)  ; offset the start position to so fire from middle of ship
  add.w #8,4(a0)  ; add height of fireball
  ; play shoot sound
  move.l #shoot_audio_data,AUD0LCH
  move.w #end_shoot_audio_data-shoot_audio_data,AUD0LEN
  ; move.w #4986,AUD0LEN
  move.w #447,AUD0PER
  ; move.w #%111111,AUD0VOL
  ; move.w #$20,AUD0VOL
  move.w #60,AUD0VOL
  move.w #$8000+$200+1,DMACON  ; DMA set ON - TODO(lucasw) doesn't the $200 turn all dma on?

done_test_fireball:
  rts
; end launch/update fireball subroutine
done_fireballs:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;move.b frame,d0
  ;and.b #$01,d0
  ; lsr.w #3,d0

  ;sub.w #0,enemy0  ; y1
  ;add.w #1,enemy0+2  ; x1
  ;sub.w #0,enemy0+4  ; y2
  ;sub.w #1,enemy0+6  ; x2

update_enemies:

  ; TODO(lucasw) enemy0+8 should be xvel, +10 should be yvel
  sub.w #1,enemy0+2  ; x1
  sub.w #1,enemy0+6  ; x2

  sub.w #1,enemy1+2  ; x1
  sub.w #1,enemy1+6  ; x2

init_enemy_y_movement:
  ; update y infrequently
  move.l frame,d1
  and.l #$3,d1
  cmp.l #$3,d1
  bne update_enemy_y_movement
  add.b #1,enemy0+8  ; enemy counter
  add.b #1,enemy1+8  ; enemy counter
update_enemy_y_movement:
  move.l #signed_sin32_15,a0
  ; TODO(lucasw) subroutine
  move.l #$00000000,d1
  move.b enemy0+8,d1
  ext.w d1
  and.w #$1f,d1
  move.l #$00000000,d0
  move.w d1,d0
  move.b (a0,d1),d0
  ext.w d0  ; sign extend
  add.w d0,enemy0    ; y1
  add.w d0,enemy0+4  ; y2

  move.b enemy1+8,d1
  ext.w d1
  and.w #$1f,d1
  move.b (a0,d1),d0
  ext.w d0  ; sign extend
  add.w d0,enemy1    ; y1
  add.w d0,enemy1+4  ; y2
end_enemy_y_movement:

  move.l #enemy0,a0
  jsr test_reset_enemy
  move.l #enemy1,a0
  jsr test_reset_enemy

  bra done_update_enemies
test_reset_enemy:  ; $48 to $d8
  cmp.w #$0038,2(a0)
  bgt enemy_x_test_done
  move.w #$00f8,2(a0)
  move.w #$0108,6(a0)
  ; TODO(lucasw) respawn somewhere random in y
  ;move.w frame,d0
  ;and.w #$3f,d0
enemy_x_test_done:
  jsr ey_test
  rts

; TODO(lucasw) don't make this a subroutine if nothing else needs it
ey_test:
ey_test_top:
  cmp.w #$0030,(a0)
  bgt.w ey_test_bottom
  move.w #$0030,(a0)
  move.w #$0040,4(a0)
  bra edone_xy_test
ey_test_bottom:
  cmp.w #$e0,(a0)
  blt edone_xy_test
  move.w #$e0,(a0)
  move.w #$f0,4(a0)
edone_xy_test
  rts

new_y_position:
  add.w #$43,(a0)
  and.w #$ff,(a0)
  move.w (a0),4(a0)
  add.w #$10,4(a0)
  rts
done_update_enemies:

  ; TODO(lucasw) need to reposition the sprites at right of screen,
  ; they can wrap around visually but the rect rect collision will fail because the high
  ; order bits aren't colliding.

mouse_test:
  ; if mousebutton/joystick 1 or 2 pressed then exit
  ; mouse/joy button 1
  btst.b #6,CIAAPRA
  beq exit
  ; btst.b #7,CIAAPRA
  ; beq exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Wait for vertical blanking before taking the copper list into use
waitVB:
  move.l VPOSR,d0
  and.l #$1ff00,d0
  cmp.l #300<<8,d0
  bne waitVB

  ; Take copper list into use
  move.l #copper_list,a6
  move.l a6,COP1LCH

;;;;;;;;;;;;;;;;
; seems like this should be done during vblank unless re-using sprites
update_sprite_registers:
  move.b player_ship+1,SHIP_DST    ; VSTART
  move.b player_ship+3,SHIP_DST+1  ; HSTART
  move.b player_ship+5,SHIP_DST+2  ; VSTOP
  move.b enemy0+1,BUG1_DST    ; VSTART
  move.b enemy0+3,BUG1_DST+1  ; HSTART
  move.b enemy0+5,BUG1_DST+2  ; VSTOP
  move.b enemy1+1,BUG2_DST    ; VSTART
  move.b enemy1+3,BUG2_DST+1  ; HSTART
  move.b enemy1+5,BUG2_DST+2  ; VSTOP
  move.b fireball0+1,FIREBALL0_DST    ; VSTART
  move.b fireball0+3,FIREBALL0_DST+1  ; HSTART
  move.b fireball0+5,FIREBALL0_DST+2  ; VSTOP
  move.b fireball1+1,FIREBALL1_DST    ; VSTART
  move.b fireball1+3,FIREBALL1_DST+1  ; HSTART
  move.b fireball1+5,FIREBALL1_DST+2  ; VSTOP
  ; TODO add the higher bits to SPRxCTL?

skip4:
  ;sub.b #1,BUG1_DST+1
  ;sub.b #1,BUG2_DST+1

  ;;;;;;;;;;;;;
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
; sprite metadata
player_ship:
  dc.l 0
  dc.l 0
  CNOP 0,4
enemies:
enemy0:
  dc.l 0  ; y1,x1
  dc.l 0  ; y2,x2
  dc.l 0  ; counter (1st byte), TODO(lucasw) status bits, hit points?
  ; TBD health, trajectory, type, status (including whether enabled or not)
  CNOP 0,4
enemy1:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy2:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy3:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy4:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy5:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy6:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
enemy7:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
fireball0:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4
fireball1:
  dc.l 0
  dc.l 0
  dc.l 0
  CNOP 0,4

; storage for 8-bit data
  CNOP 0,4
sin32_15:
  dc.b 8,9,10,12,13,14,14,15,15,15,14,14,13,12,10,9,8,6,5,3,2,1,1,0,0,0,1,1,2,3,5,6
  CNOP 0,4
signed_sin32_15:
  dc.b 3,2,2,2,2,1,1,0,0,0,-1,-1,-2,-2,-2,-2,-3,-2,-2,-2,-2,-1,-1,0,0,0,1,1,2,2,2,2
  CNOP 0,4
test_wave:
  dc.b 4,-3,-2,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,1,1,2,3,4,4
test_neg:
  dc.b -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
  CNOP 0,4
test_pos:
  dc.b 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  CNOP 0,4

; Sprite data
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
end_ship_data:
fireball_data:
  dc.w    $00ff,$1000             ;VSTART, HSTART, VSTOP
  incbin "gimp/fireball.data.raw"
  CNOP 4,4             ; End of sprite data
end_fireball_data:
bug_data:
  ; 0x48 is far left (with no pixels off screen to left
  ; 0xd8 seems to be almost the end of the screen- is hstart added to another number
  ; (diwstrt?), otherwise
  dc.w    $40d8,$5000             ;VSTART, HSTART, VSTOP
  incbin "gimp/bug.data.raw"
  CNOP 4,4             ; End of sprite data
end_bug_data:
end_sprites:

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
mountains_data:
  incbin "gimp/mountains.data.raw"
  ; datalists aligned to 32-bit
  CNOP 0,4

sound_effects:
shoot_audio_data:
  ;dc.w    $00ff,$1000             ;VSTART, HSTART, VSTOP
  incbin "sound/shoot.wav.raw"
  CNOP 4,4             ; End of sprite data
end_shoot_audio_data:

copper_list:
  dc.l $ffffffe ; end of copper list
  blk.l 1023,0

