; ---------------------------------------------------------------------------
; Pharaoh's Curse for Atari 400/800
; ---------------------------------------------------------------------------
; Memory Map
; ---------------------------------------------------------------------------
; $0000 - $007f:  Page 0 for Atari OS and DOS
; $00cb - $00fc:  ZP variables for the game
; $0100 - $01ff:  Stack
; $0200 - $047f:  Page 2-4 for Atari OS and DOS
; $0480 - $05bd:  BOOT loader code and some initialization
; $05be - $10fe:  Game code
; $1fff - $1fff:  ... unused garbage data ...
; $1100 - $12ff:  Graphics for Player, Pharaoh and Mummy
; $1300 - $17ff:  Player Missle Graphics area
; $1800 - $65ff:  Main font with 128 characters
; $1c00 - $65ff:  B/W font with 32 characters and color graphics for animated traps
; $1e00 - $1e17:  Display List during the game
; $1e18 - $1e59:  3 Display List interrupt routines
; $1e5a - $1f17:  Mostly constant game variables
; $1f18 - $1fff:  ... unused garbage data ...
; $2000 - $3fff:  16 $200 Levels mapped directly onto the screen if needed
; $4000 - $41ff:  Title font with 64 characters
; $4200 - $4c17:  Remaining game code
; $4c18 - $4cf1:  Remaining game variables
; $4cf2 - $4dbe:  ... unused garbage data ...
; ---------------------------------------------------------------------------

.include "atari.inc"
.include "ascii_charmap.inc" ; activate standard ASCII encoding

AUDC_POLYS_5_17  = $00
AUDC_POLYS_5     = $20 ; Same as $60
AUDC_POLYS_5_4   = $40
AUDC_POLYS_17    = $80
AUDC_POLYS_NONE  = $A0 ; Same as $E0
AUDC_POLYS_4     = $C0
AUDC_VOLUME_ONLY = $10

; ---------------------------------------------------------------------------

.struct LEVEL_STRUCT
                      .res 40 * 12 ; level data as TILE, which are font characters (160*192 pixel)
    ELEVATOR_TOP      .byte
    ELEVATOR_BOTTOM   .byte ; X position of the top of the moving sidewalk
    ELEVATOR_X        .byte ; Y position of the top of the moving sidewalk
    startPosX_top     .byte
    startPosY_top     .byte
    startPosX_bottom  .byte
    startPosY_bottom  .byte
    startPosX_left    .byte
    startPosY_left    .byte
    startPosX_right   .byte
    startPosY_right   .byte
    color0            .byte
    color1            .byte
    color2            .byte
                      .res 2
                      .res 8*2 ; 2 characters for the custom look of the treasure of the level
.endstruct
.assert .sizeof(LEVEL_STRUCT)=512,error

; ---------------------------------------------------------------------------

.enum FONT_1C00
    DIGIT_0     = $00
    DIGIT_1     = $01
    DIGIT_2     = $02
    DIGIT_3     = $03
    DIGIT_4     = $04
    DIGIT_5     = $05
    DIGIT_6     = $06
    DIGIT_7     = $07
    DIGIT_8     = $08
    DIGIT_9     = $09
    CROWN       = $0A
    PLAYER      = $0B
    SKULL       = $0C
    TREASURE___ = $0D
    TREASURE__X = $0E
    TREASURE_X_ = $0F
    TREASURE_XX = $10
    GAME_OVER_1 = $11
    GAME_OVER_2 = $12
    GAME_OVER_3 = $13
    GAME_OVER_4 = $14
    GAME_OVER_5 = $15
    GAME_OVER_6 = $16
    GAME_OVER_7 = $17
    V_anim_1    = $18
    V_anim_2    = $19
    V_anim_3    = $1A
    V_anim_4    = $1B
    V_anim_5    = $1C
    ARROW_RIGHT = $1D
    ARROW_LEFT  = $1E
    ALT_CROWN   = $1F

    COLOR_1     = $40
    COLOR_2     = $80
    COLOR_3     = $C0
.endenum

; ---------------------------------------------------------------------------

.enum LEVEL_EXIT
    NO     = 0
    LEFT   = 1
    RIGHT  = 2
    TOP    = 3
    BOTTOM = 4
.endenum

; ---------------------------------------------------------------------------

.enum JOYSTICK
    J1_UP    = $01
    J1_DOWN  = $02
    J1_LEFT  = $04
    J1_RIGHT = $08
    J2_UP    = $10
    J2_DOWN  = $20
    J2_LEFT  = $40
    J2_RIGHT = $80
.endenum

; ---------------------------------------------------------------------------

.enum DIRECTION
    NONE  = 0
    CLIMB = 1
    LEFT  = 2
    RIGHT = 3
.endenum

; ---------------------------------------------------------------------------

.enum ROOM_NUMBER
    R0  = 0
    R1  = 1
    R2  = 2
    R3  = 3
    R4  = 4
    R5  = 5
    R6  = 6
    R7  = 7
    R8  = 8
    R9  = 9
    R10 = 10
    R11 = 11
    R12 = 12
    R13 = 13
    ENTRANCE_TITLE = 14
    R15 = 15
    COUNT = 16
.endenum

; ---------------------------------------------------------------------------

.enum PM_OBJECT
    PLAYER         = 0
    PHARAOH        = 1
    MUMMY          = 2
    WINGED_AVENGER = 3
    COUNT          = 4
    ILLEGAL        = $FF
.endenum

; ---------------------------------------------------------------------------

.enum TILE
    FULL = 0
    EMPTY = 1
    FLOOR_02 = 2
    FLOOR_03 = 3
    FLOOR_04 = 4
    FLOOR_05 = 5
    FLOOR_06 = 6
    FLOOR_07 = 7
    FLOOR_08 = 8
    FLOOR_09 = 9
    FLOOR_0a = $A
    FLOOR_0b = $B
    FLOOR_0c = $C
    FLOOR_0d = $D
    FLOOR_0e = $E
    FLOOR_0f = $F
    FLOOR_10 = $10
    FLOOR_11 = $11
    FLOOR_12 = $12
    FLOOR_13 = $13
    FLOOR_14 = $14
    FLOOR_15 = $15
    FLOOR_16 = $16
    FLOOR_17 = $17
    FLOOR_18 = $18
    FLOOR_19 = $19
    FLOOR_1a = $1A
    FLOOR_1b = $1B
    FLOOR_1c = $1C
    FLOOR_1d = $1D
    FLOOR_1e = $1E
    FLOOR_1f = $1F
    FLOOR_20 = $20
    FLOOR_21 = $21
    FLOOR_22 = $22
    FLOOR_23 = $23
    FLOOR_24 = $24
    FLOOR_25 = $25
    FLOOR_26 = $26
    FLOOR_27 = $27
    ROPE = $28
    WALL_29 = $29
    WALL_2a = $2A
    WALL_2b = $2B
    WALL_2c = $2C
    WALL_2d = $2D
    WALL_2e = $2E
    WALL_2f = $2F
    WALL_30 = $30
    WALL_31 = $31
    WALL_32 = $32
    WALL_33 = $33
    WALL_34 = $34
    WALL_35 = $35
    WALL_36 = $36
    WALL_37 = $37
    WALL_38 = $38
    WALL_39 = $39
    WALL_3a = $3A
    WALL_3b = $3B
    WALL_3c = $3C
    WALL_3d = $3D
    WALL_3e = $3E
    WALL_3f = $3F
    WALL_40 = $40
    WALL_41 = $41
    WALL_42 = $42
    WALL_43 = $43
    WALL_44 = $44
    WALL_45 = $45
    WALL_46 = $46
    WALL_47 = $47
    WALL_48 = $48
    WALL_49 = $49
    WALL_4a = $4A
    FIELD_0_moveRight = $4B
    FIELD_1_moveLeft = $4C
    FIELD_2_static = $4D
    WALL_4e = $4E
    WALL_4f = $4F
    WALL_50 = $50
    WALL_51 = $51
    WALL_52 = $52
    WALL_53 = $53
    WALL_54 = $54
    WALL_55 = $55
    WALL_56 = $56
    T57 = $57
    T58 = $58
    T59 = $59
    T5a = $5A
    GATE = $5B
    KEY_left = $5C
    KEY_right = $5D
    TREASURE_left = $5E
    TREASURE_right = $5F
    TRAP_0_left = $60
    TRAP_0_right = $61
    TRAP_1_left = $62
    TRAP_1_right = $63
    TRAP_2_left = $64
    TRAP_2_right = $65
    TRAP_3_left = $66
    TRAP_3_right = $67
    BULLET_0 = $68
    BULLET_1 = $69
    BULLET_2 = $6A
    BULLET_3 = $6B
    ELEVATOR_0 = $6C
    ELEVATOR_2 = $6D
    ELEVATOR_1 = $6E
    ELEVATOR_3 = $6F
    DOOR_0_left = $70
    DOOR_0_right = $71
    DOOR_1_left = $72
    DOOR_1_right = $73
    DOOR_2_left = $74
    DOOR_2_right = $75
    DOOR_3_left = $76
    DOOR_3_right = $77
    ROPE_0 = $78
    ROPE_1 = $79
    ROPE_2 = $7A
    ROPE_3 = $7B
    TRAP_ACTIVE_0_left = $7C
    TRAP_ACTIVE_0_right = $7D
    TRAP_ACTIVE_1_left = $7E
    TRAP_ACTIVE_1_right = $7F

    ACTION_FLAG = $80
.endenum

; ---------------------------------------------------------------------------

.enum OPCODE
    JMP = $4C
    ADC_abs_Y = $79
.endenum

; ---------------------------------------------------------------------------

.enum PLAYER_STATE
    ONGOING   = 0
    WON_GAME  = $FA
    INIT      = $FB
    GAME_LOST = $FF
.endenum

; ---------------------------------------------------------------------------

.enum SOUND_EFFECT
    LOST_LIFE           = 0
    KILLED_PHARAO       = 1
    KILLED_MUMMY        = 2
    WINGED_AVENGER_SHOT = 3
    TREASURE_COLLECTED  = 4
    KEY_COLLECTED       = 5
    OPEN_GATE           = 6
    GAME_END            = 7
.endenum

; ---------------------------------------------------------------------------

.enum ELEVATOR_STATE
    START   = 0
    RESTORE = 1
    RUNNING = 2
    OFF     = $FF
.endenum

; ---------------------------------------------------------------------------

.enum PM_IMAGE_OFFSET
    STANDING    = $00
    CLIMBING    = $10
    RUN_LEFT_0  = $20
    RUN_LEFT_1  = $30
    RUN_LEFT_2  = $40
    RUN_RIGHT_0 = $50
    RUN_RIGHT_1 = $60
    RUN_RIGHT_2 = $70
.endenum

; ---------------------------------------------------------------------------

.enum COLLISION_PLAYER
    PLAYER_A = $01
    PLAYER_B = $02
    PHARAOH  = $04
    MUMMY    = $08
.endenum

; ---------------------------------------------------------------------------

.enum COLLISION_PLAYFIELD
    C0_FLOOR               = $01 ; Floor color
    C1_WALL                = $02 ; Wall color
    C2_DOOR_ACCENT         = $04 ; Wall accent color,  doors
    C3_TRAPS_KEYS_TREASURE = $08 ; used for Traps, Keys and Treasures – flickering
.endenum



; ---------------------------------------------------------------------------
; Page Zero
; BASIC and Floating Point
; Used by Pharaoh's Curse for variables
; ---------------------------------------------------------------------------
    .zeropage
    .org $CB
SCORE:                      .res 2 ; Score in BCD format
unused_00_CD:               .res 1 ; Erased at launch, never read
unused_decrement_VBL_CE:    .res 1 ; Decremented during VBL IRQ, never read
                            .res 5
XLEVELPTR:                  .res 2 ; Ptr to additional level data ($1E0 bytes after the beginning)
                            .res 2
SND_PTR:                    .res 2 ; Ptr to frequency table when playing a sound effect
vTEMP1:                     .res 1
vTEMP2:                     .res 1
vTEMP3:                     .res 1
ELEVATOR_PTR:               .res 2
                            .res 5
MULT_TMP:                   .res 2
pDEST_PTR:                  .res 2
sSRC_PTR:                   .res 2
                            .res 4
vAudio_AUDF2_base:          .res 1
vAudio_AUDF3:               .res 1
vAudio_AUDC2_AUDC3:         .res 1
vAudio_AUDF2_60Hz_countDown: .res 1
vAudio_AUDC1:               .res 1
vWingedAvenger_Hunt_Timer:  .res 1
DOUBLE_YSPEED_FLAG:         .res 1
PLAYER_STATE:               .res 1
SUBPIXEL_X:                 .res 1
SUBPIXEL_Y:                 .res 1
vELEVATOR_X:                .res 1
vELEVATOR_Y:                .res 1
vAudio_AUDC4:               .res 1
CURRENT_ROOM:               .res 1
vTemp_CurrentRoom:          .res 1


                .code
                .org $0480
; ---------------------------------------------------------------------------
; Pharaoh's Curse Boot Record
; ---------------------------------------------------------------------------
.proc BOOT_SECTOR
                .BYTE 0                 ; boot flag, copied to DFLAGS
                .BYTE (START-BOOT_SECTOR+127)/128 ; number of sectors the boot record: 3 * 128 Bytes
                .WORD BOOT_SECTOR       ; Boot address
                .WORD BOOT_INIT         ; Init address - never gets executed

; Boot continuation code
BOOT_CONTINUE:
                LDA     #<RAM_TOP       ; This is wrong, but it doesn't matter because BASIC is not used
                STA     MEMLO           ; BOTTOM OF AVAILABLE MEMORY
                STA     APPMHI          ; APPLICATION MEM HI LIMIT
                LDA     #>RAM_TOP
                STA     MEMLO+1         ; BOTTOM OF AVAILABLE MEMORY
                STA     APPMHI+1        ; APPLICATION MEM HI LIMIT

                LDA     #<LOAD_GAME     ; Continue loading the application code
                STA     DOSVEC          ; DOS START VECTOR
                LDA     #>LOAD_GAME
                STA     DOSVEC+1        ; DOS START VECTOR

                LDA     #(HUE_GREY<<4)|0
                STA     COLOR2          ; COLOR 2
                LDA     #<BOOT_DISPLIST
                STA     SDLSTL          ; SAVE DISPLAY LIST (LOW)
                LDA     #>BOOT_DISPLIST
                STA     SDLSTH          ; SAVE DISPLAY LIST (HIGH)
                LDY     #21             ; Length of the string printed to the screen

; Check for ROM cartridge by modifying RAM
                DEC     CART
                LDA     CART
                BNE     @no_ROM_cart

                LDA     #(HUE_ORANGE<<4)|4
                STA     COLOR2          ; COLOR 2

:               LDA     sREMOVE_CARTRIDGE,Y
                SEC
                SBC     #' '
                STA     PRNBUF+8,Y      ; PRINTER BUFFER
                DEY
                BPL     :-
:               BMI     :-              ; endless loop


; no ROM cartridge detected, display loading text
@no_ROM_cart:   LDA     sLOADING_PHARAOHS_CURSE,Y
                SEC
                SBC     #' '
                STA     PRNBUF+8,Y      ; PRINTER BUFFER
                DEY
                BPL     @no_ROM_cart
                LDA     #256-2
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
:               BIT     RTCLOK+2        ; 1/30s delay
                BMI     :-

                CLC
BOOT_INIT:      RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc LOAD_GAME
                LDA     #(CODE_END-START+127)/128
                STA     a:vTEMP1        ; Number of sectors to read
                LDA     #1
                STA     DUNIT           ; Drive #1
                LDA     #'R'
                STA     DCOMND          ; BUS COMMAND
                LDA     #<START
                STA     DBUFLO          ; DATA BUFFER POINTER (LOW)
                LDA     #>START
                STA     DBUFHI          ; DATA BUFFER POINTER (HIGH)
                LDA     #0
                STA     DAUX1           ; Start reading at sector #256
                LDA     #1
                STA     DAUX2           ; COMMAND AUXILLARY BYTES 2
PROT_LOOP:      JSR     DSKINV          ; DISK INTERFACE
                LDA     DBUFLO          ; DATA BUFFER POINTER (LOW)
                CLC
                ADC     #$80
                STA     DBUFLO          ; DATA BUFFER POINTER (LOW)
                BCC     :+              ; Next sector
                INC     DBUFHI          ; DATA BUFFER POINTER (HIGH)
:               INC     DAUX1           ; Next sector
                DEC     a:vTEMP1
                BNE     PROT_LOOP


; Track #5 with the copy protection:
; Sector # 94, Track # 5 Sector # 4 / OK /   8.608ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK /  19.512ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK /  30.408ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK /  41.288ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK /  52.152ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK /  63.032ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK /  73.904ms / $1a * 128
; Sector #108, Track # 5 Sector #18 / OK /  84.776ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK / 107.800ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK / 118.672ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK / 129.576ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK / 140.504ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK / 151.424ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK / 162.368ms / $1a * 128
; Sector # 98, Track # 5 Sector # 8 / CRC ERROR / 173.304ms / $da * 64 + $00 * 64
; Sector # 97, Track # 5 Sector # 7 / OK / 184.160ms / $1a * 128
; Sector # 94, Track # 5 Sector # 4 / OK / 195.088ms / $1a * 128
; Sector # 97, Track # 5 Sector # 7 / OK / 206.008ms / $1a * 128

                LDA     #94             ; Read sector #94 ten times. It exists 8 times on the track, so it reads _really_ fast
                STA     DAUX1           ; COMMAND AUXILLARY BYTES 1
                LDA     #10
                STA     a:vTEMP1
                LDA     #0
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                STA     DAUX2           ; COMMAND AUXILLARY BYTES 2
:               JSR     DSKINV          ; Read the same sector 10 times
                DEC     a:vTEMP1
                BNE     :-

                LDA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                CMP     #104            ; Was reading fast enough (<1.7s)? In a normal disk it should take 2s to read it 10x
                BCC     @checkOK        ; => crash if too slow

@CRASH:         JMP     (RTCLOK)        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)

@checkOK:       LDA     #0
                STA     SOUNDR          ; NOISY I/O FLAG. (ZERO IS QUIET)

                LDA     #98             ; Sector 98 has to have a CRC error
                STA     DAUX1           ; COMMAND AUXILLARY BYTES 1
                JSR     DSKINV          ; DISK INTERFACE
                BPL     @CRASH          ; if there is no error, crash!

; ---------------------------------------------------------------------------
; Pharaoh's Curse Loading and Protection done, now do initialization
; ---------------------------------------------------------------------------
                JSR     RESET_VARIABLES
                LDA     #PLAYER_STATE::INIT ; Set at load time only
                STA     a:PLAYER_STATE
                LDA     #0
                STA     SCORE
                STA     SCORE+1
                STA     unused_00_CD    ; Erased at launch, never read
                JMP     START
.endproc


; =============== S U B R O U T I N E =======================================

.proc RESET_VARIABLES
                LDY     #15
:               LDA     FONT_KEY,Y
                STA     save_FONT_1800_5C_KEY,Y
                LDA     #$00
                STA     save_FONT_1800_5B_GATE,Y
                STA     vTrasuresCollected,Y
                LDA     #FONT_1C00::TREASURE___
                STA     STATUS_LINE,Y
                DEY
                BPL     :-
                RTS
.endproc

; ---------------------------------------------------------------------------

; The Display List during loading time
BOOT_DISPLIST:  .BYTE DL_BLK8
                .BYTE DL_BLK8
                .BYTE DL_BLK8
                .BYTE DL_CHR40x8x1 | DL_LMS
                .WORD PRNBUF
                .BYTE DL_JVB
                .WORD BOOT_DISPLIST


sLOADING_PHARAOHS_CURSE:
                .BYTE "LOADING PHARAOHS CURSE"
sREMOVE_CARTRIDGE:
                .BYTE "   REMOVE CARTRIDGE   "

s_CODE:         .BYTE " CODE:"

; Password for the levels, you need to enter SYNISTOPS for level 3
sPASSWORD:      .BYTE "   " ; Level 0
                .BYTE "SYN" ; Level 1
                .BYTE "IST" ; Level 2
                .BYTE "OPS" ; Level 3
                .BYTE " "

; ---------------------------------------------------------------------------
; Pharaoh's Curse Main Game
; ---------------------------------------------------------------------------
.proc START
                JSR     CLEAR_ALL_PM_GRAPHICS
                JSR     RESET_CTIA_POKEY

                LDX     #4
                LDA     #FONT_1C00::TREASURE___
:               STA     STATUS_LINE+$F,X
                DEX
                BPL     :-

                LDA     #<VBLANK_IRQ
                STA     VVBLKD          ; DEFERRED VERTICAL BLANK NMI VECTOR
                LDA     #>VBLANK_IRQ
                STA     VVBLKD+1        ; DEFERRED VERTICAL BLANK NMI VECTOR

                LDA     #(>PM_GRAPHICS_MISSLES) & $F0
                STA     PMBASE          ; MSB of the player/missile base address used to locate the graphics for your players and missiles
                LDA     #%00000011      ; Latch Player and Missile collisions
                STA     GRACTL          ; Used with DMACTL to latch all stick and paddle triggers
                LDA     #%00111110      ; DMA for DL, single line PM graphics, DMA for player and missges, standard width (40 characters)
                STA     SDMCTL          ; SAVE DMACTL REGISTER

                LDA     #<DLI_TOP
                STA     VDSLST          ; DISPLAY LIST NMI VECTOR
                LDA     #>DLI_TOP
                STA     VDSLST+1        ; DISPLAY LIST NMI VECTOR
                LDA     #>GAME_DISPLIST ; DLI 1 BLANK - DIL_TOP is called
                STA     SDLSTH          ; SAVE DISPLAY LIST (HIGH)

                LDA     #OPCODE::ADC_abs_Y
                STA     PROT_CHECKSUM   ; patched to ADC $500,Y

                LDA     #ELEVATOR_STATE::OFF
                STA     vELEVATOR_Y
                STA     vELEVATOR_X
                STA     vELEVATOR_STATE
                STA     vWingedAvenger_Attach_Flag
                STA     NMIEN           ; Non-maskable interrupt (NMI) enable
                STA     vKeyCollectedWhenPositive
                STA     CH              ; GLOBAL VARIABLE FOR KEYBOARD

                LDA     #>FONT_BASE_1C00
                STA     CHBAS           ; CHBAS REGISTER (SHADOW)

                LDA     #>LEVEL_MAP_TITLE
                STA     LEVEL_MAP_ADR+1

                LDA     #7              ; Read paddles faster, Keyboard on, KBD debounce on
                STA     SKCTL           ; Serial port control.

                LDX     #PM_OBJECT::WINGED_AVENGER ; flying across the screens
:               LDA     COLOR_TAB,X
                STA     PCOLR0,X        ; P0 COLOR

                LDA     #$FF
                STA     BULLET_MAX_DISTANCE,X
                LDA     #0
                STA     DEATH_ANIM,X
                DEX
                BPL     :-

                STA     vAudio_AUDC2_AUDC3
                STA     vAudio_AUDF2_60Hz_countDown
                STA     COLOR4          ; BACKGROUND
                STA     AUDCTL          ; Audio control
                STA     SDLSTL          ; SAVE DISPLAY LIST (LOW)
                LDA     #226
                STA     PM_YPOS
                LDA     #>LOAD_GAME::PROT_LOOP
                STA     PROT_CHECKSUM+2 ; patched to ADC $500,Y
                LDA     #%00100001      ; Player 0 - 3, playfield 0 - 3, BAK; Overlaps of players have 3rd color
                STA     GPRIOR          ; GLOBAL PRIORITY CELL

                LDY     #15
:               LDA     #1
                STA     vTrasuresCollected,Y
                LDA     #%10001000
                STA     save_FONT_1800_5B_GATE,Y
                DEY
                BPL     :-

                BIT     PLAYER_STATE
                BMI     :+
                LDA     #PLAYER_STATE::GAME_LOST ; Player lost all lifes
                STA     PLAYER_STATE
:
                JSR     GAME_DONE
                JSR     DRAW_TREASURES_LIVES
                LDY     #PLAYER_STATE::ONGOING ; Game is still ongoing
                STY     PLAYER_STATE
                STY     vAudio_AUDC4
                STY     SCORE
                STY     SCORE+1
                STY     player_lives
                DEY                     ; Y = $FF
                STY     CH              ; GLOBAL VARIABLE FOR KEYBOARD

GAME_LOOP:
                LDA     CONSOL          ; Used to see if one of the three yellow console buttons has been pressed (not the RESET button!
                CMP     #7              ; OPTION or SELECT or START pressed?
                BEQ     @notPressed     ; => no

                ; reset the elevator state
                LDA     vELEVATOR_STATE
                BMI     :+
                LDA     #ELEVATOR_STATE::RESTORE
                STA     vELEVATOR_STATE
                JSR     DO_ELEVATOR
:               JMP     START

; ---------------------------------------------------------------------------

@notPressed:
                BIT     GAME_LOOP_COUNTDOWN
                BMI     :+
                DEC     GAME_LOOP_COUNTDOWN
:
                LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BNE     @wa_notTitle
                LDA     #$FF
                STA     vWingedAvenger_Attach_Flag
                BMI     @wa_done
@wa_notTitle:   BIT     vWingedAvenger_Attach_Flag
                BPL     @wa_done
                LDA     vCollisionsPlayer
                BEQ     @wa_done
                LDA     #2
                STA     vWingedAvenger_Attach_Flag
                LDA     #DIRECTION::NONE
                STA     vPLAYER_DIRECTION
                STA     AUDC3
                DEC     vKeyCollectedWhenPositive ; Loose keys when player got picked up
                JSR     CLEAR_ALL_PM_GRAPHICS
@wa_done:

                JSR     DO_ELEVATOR

                LDA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                CMP     #KEY_SPACE      ; Pause game?
                BNE     _no_pause_game_ ; => no

                LDY     #7
                LDA     #0
:               STA     AUDC1,Y         ; stop sound
                DEY
                DEY
                BPL     :-              ; stop sound

:               LDA     vJoystickInput  ; Wait for joystick
                CMP     #%11111111
                STA     GAME_LOOP_COUNTDOWN
                BEQ     :-              ; Wait for joystick
                LDA     #KEY_NONE
                STA     CH              ; GLOBAL VARIABLE FOR KEYBOARD

_no_pause_game_:

; if not moving, be a target for the winged avenger
                LDA     vJoystickInput
                CMP     #%11111111      ; Joystick action?
                BNE     @wa_noTarget    ; => yes

                BIT     vWingedAvenger_Hunt_Timer
                BMI     @wa_isTarget
                INC     vWingedAvenger_Hunt_Timer
                BNE     @wa_isTarget
@wa_noTarget:   LDA     #0
                STA     vWingedAvenger_Hunt_Timer
@wa_isTarget:

                LDA     #$10
                STA     SHOT_PROBABILITY

                LDA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                AND     #$F
                ORA     #(HUE_GOLD<<4)|8
                STA     COLOR3          ; COLOR 3: Flicker keys and treasures

                LDA     COLOR_TAB
                BIT     vKeyCollectedWhenPositive
                BMI     :+              ; Color P0: Flicker player when holding key
                LDA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                LSR     A
                LSR     A
                ORA     #(HUE_REDORANGE<<4)|8
:               STA     PCOLR0          ; Color P0: Flicker player when holding key
                CMP     #(HUE_REDORANGE<<4)|8 ; ??? The n-flag is reset by the LDY

                LDY     vGateOpenPosition
                BMI     @gateNotOpening
                LDA     #0
                STA     FONT_GATE,Y
                DEC     vGateOpenPosition
                BPL     @gateOpeningSnd
                STA     AUDC4
                LDY     #SOUND_EFFECT::OPEN_GATE
                JSR     SOUND_PLAY_on_CH4
                JMP     @gateNotOpening
@gateOpeningSnd:        TYA
                ASL     A
                STA     AUDF4
                LDA     #AUDC_POLYS_5|6
                STA     AUDC4
@gateNotOpening:

                LDA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                CMP     #KEY_9|KEY_SHIFT|KEY_CTRL
                BEQ     @game_end_reached ; => yes

                LDA     player_lives
                BPL     @playerAlive

                LDA     #PLAYER_STATE::GAME_LOST ; Player lost all lifes
                STA     PLAYER_STATE
                JSR     RESET_CTIA_POKEY
                JMP     GAME_OVER
; ---------------------------------------------------------------------------

; Player is alive, check if the game was won
@playerAlive:
                LDY     #15
:               LDA     vTrasuresCollected,Y
                BNE     @continue_game  ; At least one treasure is still missing =>
                DEY
                BPL     :-

                LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BNE     @continue_game  ; Player is not back at the entrance =>

@game_end_reached:
                JSR     RESET_CTIA_POKEY
                LDY     #SOUND_EFFECT::GAME_END
:               JSR     SOUND_PLAY_on_CH4
                DEY
                BPL     :-
                LDA     #PLAYER_STATE::WON_GAME ; Player won the game
                STA     PLAYER_STATE
                JMP     GAME_OVER
; ---------------------------------------------------------------------------

@continue_game:
                LDX     #PM_OBJECT::MUMMY ; 1 player, 1 pharaoh, 1 mummy (the winged revenge is not part of this loop)

; PROTECTION: Checksum over checksum code, which checksums the boot code!
                LDY     #7
                LDA     #0
                CLC
:               ADC     PROT_CHECKSUM_B,Y
                DEY
                BNE     :-
                CMP     #$4A
                BEQ     PROT_CHECKSUM_CD
                LDA     RANDOM
PROT_CHECKSUM_C:STA     PROT_PM_GRAPHICS_MSB_1
PROT_CHECKSUM_CD:

                ; Lower volume for channel #4
                LDA     vAudio_AUDC4
                BEQ     :+
                SEC
                SBC     #1
                STA     vAudio_AUDC4
                STA     AUDC4
:

                ; Increment frequency for channel #1
                BIT     vAudio_AUDC1
                BMI     _next_player_loop
                DEC     vAudio_AUDC1
                BMI     _next_player_loop
                LDA     vAudio_AUDC1
                ORA     #AUDC_POLYS_17
                STA     AUDC1
                INC     vAudio_AUDF1
                LDA     vAudio_AUDF1
                ASL     A
                ASL     A
                STA     AUDF1

_next_player_loop:
                LDA     COLOR_TAB+1,X
                STA     PCOLR1,X        ; P1 COLOR

                JSR     CALC_TILE_POS   ; Convert player position into a tile position
                JSR     DO_BULLET       ; manage the bullets (trigger, movement, etc)

                CPX     #PM_OBJECT::PLAYER ; the actual player
                BEQ     _is_the_player  ; The player is controlled by the joystick, not by the computer =>

                LDA     CURRENT_ROOM,X
                CMP     CURRENT_ROOM    ; enemey in the same room as the player?
                BEQ     _same_room      ; => yes

                DEC     vEnemyDelay,X
                BPL     _no_enemy_in_this_loop
                LDA     level
                ASL     A
                ASL     A
                ASL     A
                STA     vTEMP1
                LDA     #48
                SBC     vTEMP1
                STA     vEnemyDelay,X   ; Delay = 48 - 8 * level

loc_7E2:        LDA     CURRENT_ROOM,X
:               CLC
                ADC     #1              ; move to the next room (but skip title screen)
                AND     #$F
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BEQ     :-
                STA     CURRENT_ROOM,X

                CMP     CURRENT_ROOM    ; enemey in the same room as the player?
                BEQ     loc_805         ; => yes
                CLC
                ADC     #1
                CMP     CURRENT_ROOM    ; on room down from the player?
                BNE     _no_enemy_in_this_loop ; => no
                LDA     #50
                STA     GAME_LOOP_COUNTDOWN
_no_enemy_in_this_loop:
                JSR     DO_CROWN_ARROW
                JMP     _player_done

loc_805:        LDA     CROWN_ARROW_DURATION,X
                BPL     loc_7E2

                LDA     #7
                STA     vPHARAOH_IN_WALL
                LDA     #$7F
                STA     GAME_LOOP_COUNTDOWN
                LDA     #0
                STA     DEATH_ANIM,X
                LDA     #$FF
                STA     SHOT_COUNTER,X
                JSR     CLEAR_PM_GRAPHICS

                LDA     RANDOM
                AND     #3
                CLC
                ADC     #LEVEL_EXIT::LEFT
                STA     level_exit_direction,X
                TAY

_position_player_in_level:
                LDA     ENTRY_START_XPOS,Y
                STA     PM_XPOS,X
                LDA     ENTRY_START_YPOS,Y
                STA     PM_YPOS,X

_same_room:
                LSR     SHOT_PROBABILITY

_is_the_player:
                LDA     DEATH_ANIM,X
                BEQ     :+
                JMP     _player_dead
:
                CPX     #PM_OBJECT::PLAYER ; the actual player?
                BNE     @check_ply_on_elevator

                BIT     vWingedAvenger_Attach_Flag
                BMI     @check_ply_on_elevator
                LDA     PM_XPOS+3
                STA     PM_XPOS
                LDA     PM_YPOS+3       ; attach player to the Winged Avenger
                ADC     #6
                STA     PM_YPOS

                LDA     #AUDC_POLYS_NONE|2
                STA     AUDC2
                LDA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                LSR     A
                LSR     A
                AND     #3
                TAY
                LDA     SND_EFFECT_WINGED_AVENGER_SHOT+3,Y
                STA     AUDF2
                JMP     _player_no_motion ; => no joystick input by the player
; ---------------------------------------------------------------------------

@check_ply_on_elevator:
                LDA     PM_XPOS,X
                SEC
                SBC     vELEVATOR_X
                BPL     :+
                EOR     #$FF
:
                CMP     #4
                BCS     @no_on_elevator
                LDA     PM_YPOS,X
                SEC
                SBC     vELEVATOR_Y
                BPL     @no_on_elevator
                EOR     #$FF
                CMP     #7
                BCS     @no_on_elevator
                DEC     PM_YPOS,X       ; Move up on the elevator
                DEC     PM_YPOS,X
                JMP     _player_no_motion_sound
; ---------------------------------------------------------------------------

@no_on_elevator:
                LDA     ROPE_UNDER_PLAYER,X
                CMP     #TILE::ROPE
                BEQ     @no_right_or_left
                LDA     PM_YPOS,X
                CMP     #42
                BCC     @no_right_or_left

                LDA     vPLAYER_DIRECTION,X
                CMP     #DIRECTION::LEFT
                BNE     @no_left
                LDA     TILE_LEFT,X
                BMI     @no_right_or_left
                AND     #(~TILE::ACTION_FLAG) & $FF
                CMP     #TILE::FLOOR_03
                BNE     @no_right_or_left
                LDA     PM_XPOS,X
                BNE     @x_plus_2

@no_left:       CMP     #DIRECTION::RIGHT
                BNE     @no_right_or_left
                LDA     TILE_RIGHT,X
                BMI     @no_right_or_left
                AND     #(~TILE::ACTION_FLAG) & $FF
                CMP     #TILE::FLOOR_03
                BNE     @no_right_or_left
                LDA     PM_XPOS,X
                BNE     @x_minus_2

@no_right_or_left:

                LDA     vCollisionsPlayfield+1,X
                AND     #COLLISION_PLAYFIELD::C1_WALL ; Wall color
                CMP     #COLLISION_PLAYFIELD::C1_WALL ; Wall color
                BNE     @no_xUpdate
                LDA     PM_XPOS,X
                BMI     @x_minus_2
@x_plus_2:      CLC
                ADC     #2
                JMP     @update_xpos
@x_minus_2:     SEC
                SBC     #2
@update_xpos:   STA     PM_XPOS,X
@no_xUpdate:

                LDA     DEATH_ANIM,X
                BNE     :+
                JSR     CHECK_NEXT_ROPE
                BPL     @player_in_bounds
:               JMP     player_out_of_bounds

@player_in_bounds:
                LDY     #2
@checkLoop:     LDA     (pDEST_PTR),Y
                CPY     #2
                BCS     @nextCheck
                CMP     #TILE::TRAP_0_left|TILE::ACTION_FLAG
                BCC     @nextCheck
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BEQ     @player_on_trap
                CMP     #TILE::TRAP_3_right|TILE::ACTION_FLAG
                BCS     @nextCheck
@player_on_trap:
                JMP     DO_TRAPS

@nextCheck:     CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     :+
                CMP     #TILE::TREASURE_left|TILE::ACTION_FLAG
                BEQ     @on_Treasure
                CMP     #TILE::TREASURE_right|TILE::ACTION_FLAG
                BEQ     @on_Treasure
                CMP     #TILE::KEY_left|TILE::ACTION_FLAG
                BEQ     @on_Key
                CMP     #TILE::GATE
                BEQ     @on_Gate
:               DEY
                BPL     @checkLoop
                BMI     @on_Gate_noKey ; unconditional branch

; Player is on a gate
@on_Gate:       BIT     vKeyCollectedWhenPositive
                BMI     @on_Gate_noKey
                LDA     #7
                STA     vGateOpenPosition
                LDY     CURRENT_ROOM
                LDA     #$00
                STA     save_FONT_1800_5B_GATE,Y

                LDA     #$FF
                STA     vKeyCollectedWhenPositive
                BMI     @on_Gate_noKey

; Player is on a key
@on_Key:        LDA     vCollisionsPlayfield+1
                AND     #COLLISION_PLAYFIELD::C3_TRAPS_KEYS_TREASURE ; used for Traps, Keys and Treasures – flickering
                BEQ     player_out_of_bounds

                LDY     #15
                LDA     #$00            ; Erase key character (= make it invisible)
:               STA     FONT_KEY,Y
                DEY
                BPL     :-

                STA     vKeyCollectedWhenPositive
                STA     HITCLR          ; POKE with any number to clear all player/missile collision registers
                STA     vCollisionsPlayfield+1

                LDY     #SOUND_EFFECT::KEY_COLLECTED
                JSR     SOUND_PLAY_on_CH4 ; Key collected

                SED
                LDA     SCORE+1
                CLC
                ADC     #1              ; +1 Point
                STA     SCORE+1
                CLD

                JSR     DRAW_TREASURES_LIVES

@on_Gate_noKey:
                JMP     player_out_of_bounds

@on_Treasure:
                LDA     vCollisionsPlayfield+1
                AND     #COLLISION_PLAYFIELD::C3_TRAPS_KEYS_TREASURE ; used for Traps, Keys and Treasures – flickering
                BEQ     player_out_of_bounds

                LDY     #SOUND_EFFECT::TREASURE_COLLECTED
                JSR     SOUND_PLAY_on_CH4

                ; clear the treasure collected flag
                LDA     #0
                LDY     CURRENT_ROOM
                STA     vTrasuresCollected,Y

                ; Erase the treasure image from the font to hide it
                LDA     #>FONT_TREASURE
                STA     pDEST_PTR+1
                LDA     #<FONT_TREASURE
                STA     pDEST_PTR
                LDY     #15
                LDA     #$00
:               STA     (pDEST_PTR),Y
                DEY
                BPL     :-

                STA     HITCLR          ; POKE with any number to clear all player/missile collision registers
                STA     vCollisionsPlayfield+1
                INC     player_lives    ; collecting a treasure adds a live

                SED
                LDA     SCORE+1
                CLC
                ADC     #2
                STA     SCORE+1
                CLD

                JSR     DRAW_TREASURES_LIVES
                JMP     player_out_of_bounds
; ---------------------------------------------------------------------------

player_out_of_bounds:
                LDA     PLAYER_IMG_ANIM_PHASE,X
                CMP     #PM_IMAGE_OFFSET::RUN_LEFT_2
                BEQ     _player_dead
                LDA     vCollisionsPlayfield+1,X
                AND     #COLLISION_PLAYFIELD::C0_FLOOR ; Floor color
                BEQ     @loc_9D7

                LDA     vPLAYER_DIRECTION,X
                BEQ     @loc_9BD
                DEC     PM_YPOS,X       ; Move up

@loc_9BD:
                LDA     #3
                STA     SOUND_TIMER,X
                BIT     vAudio_AUDC1
                BPL     :+
                BIT     GAME_LOOP_COUNTDOWN
                BPL     :+
                LDA     #0
                STA     AUDC1
:
                LDA     #$FF
                STA     DOUBLE_YSPEED_FLAG
                JMP     _player_dead
; ---------------------------------------------------------------------------

@loc_9D7:
                LDA     TILE_MID,X
                CMP     #TILE::FLOOR_03
                BEQ     :+              ; Move down
                AND     #1
                BNE     @loc_9BD
:
                INC     PM_YPOS,X       ; Move down
                LDA     #0
                STA     DOUBLE_YSPEED_FLAG

_player_no_motion_sound:
                DEC     SOUND_TIMER,X
                BPL     _player_dead
                BIT     vAudio_AUDC1
                BPL     :+
                BIT     GAME_LOOP_COUNTDOWN
                BPL     :+
                LDA     #AUDC_POLYS_NONE|1
                STA     AUDC1
                LDA     PM_YPOS,X
                STA     AUDF1
:
                LDA     #DIRECTION::NONE
                STA     SOUND_TIMER,X
                STA     vPLAYER_DIRECTION,X
                JMP     _player_set_direction
; ---------------------------------------------------------------------------

_player_dead:
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     _pharaoh_or_mummy
                LDA     DEATH_ANIM
                BNE     _player_dieing

; PROTECTION: Checksum over the boot code
                LDA     #0
                TAY
                CLC
PROT_CHECKSUM_B:ADC     BOOT_SECTOR,Y
                DEY
                BNE     PROT_CHECKSUM_B
                CMP     #$A8
                BEQ     :+
                LDA     RANDOM
                STA     PM_GRAPHICS_MSB
:

                JMP     _player_check_direction
; ---------------------------------------------------------------------------

_player_dieing:
                DEC     DEATH_ANIM
                BNE     loc_A5F
                JSR     CLEAR_ALL_PM_GRAPHICS
                LDA     #0
                STA     vCollisionsPlayer
                LDA     #$FF
                STA     vWingedAvenger_Attach_Flag
                LDY     level_exit_direction
                JMP     _position_player_in_level
; ---------------------------------------------------------------------------

_pharaoh_or_mummy:
                LDA     DEATH_ANIM,X
                BEQ     _pharaoh_or_mummy_alive
                DEC     DEATH_ANIM,X
                BNE     loc_A5F
                LDA     #$FF
                STA     GAME_LOOP_COUNTDOWN
                JSR     CLEAR_PM_GRAPHICS
                INC     CURRENT_ROOM,X
                JSR     CLEAR_PM_GRAPHICS
                JMP     _player_done
; ---------------------------------------------------------------------------

loc_A5F:        JMP     loc_C5C
; ---------------------------------------------------------------------------

_pharaoh_or_mummy_alive:
                LDA     vCollisionsPlayer+1,X
                BEQ     @moveAway
                CPX     #PM_OBJECT::PHARAOH
                BEQ     :+
                INC     PM_XPOS,X
                BNE     @moveAway
:
                DEC     PM_XPOS,X
@moveAway:

                LDA     vCollisionsPlayfield+1,X
                AND     #COLLISION_PLAYFIELD::C1_WALL ; Wall color
                BEQ     @loc_A93
                CPX     #PM_OBJECT::PHARAOH
                BEQ     :+
                BIT     vPHARAOH_IN_WALL
                BMI     :+
                DEC     vPHARAOH_IN_WALL
:

                LDA     vPLAYER_DIRECTION,X
                CMP     #DIRECTION::LEFT
                BEQ     :+
                JMP     _move_left
:               JMP     _move_right

; ---------------------------------------------------------------------------

@loc_A93:       LDA     PM_YPOS
                SEC
                SBC     PM_YPOS,X
                BPL     :+              ; Y-Delta to the player < 16?
                EOR     #$FF
                CLC
                ADC     #1
:               CMP     #16             ; Y-Delta to the player < 16?
                BMI     _shot_gun_at_player ; => yes, could be a collision

                LDA     #256-1
                STA     SHOT_COUNTER,X  ; Player is vertically out of reach

                CPX     #PM_OBJECT::PHARAOH
                BEQ     _continue_move
                BIT     vPHARAOH_IN_WALL
                BMI     _continue_move
                LDA     PM_YPOS,X
                CMP     PM_YPOS
                BCC     _continue_move
                CLC
                ADC     #8
                CMP     vELEVATOR_TOP
                BCC     _continue_move
                CMP     vELEVATOR_BOTTOM
                BCS     _continue_move
                LDA     PM_XPOS,X
                CMP     vELEVATOR_X
                BNE     :+
                LDA     #DIRECTION::NONE
                BEQ     _on_elevator_wait

:               BCS     _move_left
                BCC     _move_right

_continue_move:
                DEC     vPlayerRunTimer,X ; How many cycles will the player run in one direction?
                BMI     :+
                JMP     _move_x_direction
:               LDA     RANDOM
                AND     #$3F ; '?'
                STA     vPlayerRunTimer,X ; How many cycles will the player run in one direction?
                LDA     RANDOM
                AND     #1
                CLC
                ADC     #DIRECTION::LEFT ; Run into a random direction

_on_elevator_wait:
                STA     vPLAYER_DIRECTION,X
                JMP     _player_set_direction
; ---------------------------------------------------------------------------

_shot_gun_at_player:
                LDA     SHOT_COUNTER,X
                BPL     :+
                LDA     #8
                STA     SHOT_COUNTER,X  ; wait for 8 cycles to fire at player
                BPL     @loc_B0A
:               CMP     #0
                BEQ     @loc_B0A
                DEC     SHOT_COUNTER,X
                BNE     _continue_move
@loc_B0A:       STA     SHOT_PROBABILITY

                LDA     PM_XPOS
                SEC
                SBC     PM_XPOS,X
                BPL     :+
                EOR     #$FF
:               CMP     #16
                BCC     _continue_move
                LDA     PM_XPOS
                CMP     PM_XPOS,X
                BCC     _move_left

_move_right:
                LDA     #DIRECTION::RIGHT
_player_set_direction_:
                JMP     _player_set_direction
; ---------------------------------------------------------------------------

_move_left:     LDA     #DIRECTION::LEFT
                BPL     _player_set_direction_

_player_check_direction:
                LDA     vPlayer_counter_b
                BPL     :+
                BIT     vPlayer_counter_c
                BMI     @loc_B57
                DEC     vPlayer_counter_c
                JMP     @loc_BAF
:               LDA     #3
                STA     vAudio_AUDC2_AUDC3

                DEC     vPlayer_counter_b,X
                BPL     @loc_BAF
                LDA     #15
                STA     vPlayer_counter_c
                LDA     #DIRECTION::NONE
                STA     SOUND_TIMER
                STA     vPLAYER_DIRECTION
                STA     vAudio_AUDF2_60Hz_countDown
                BEQ     @loc_BAF

@loc_B57:       BIT     vPlayer_counter_a
                BMI     :+
                DEC     vPlayer_counter_a
                BPL     @joystick_up
:
                LDA     vWingedAvenger_Hunt_Timer
                BPL     :+
                LDA     RANDOM
                AND     #$F
                BNE     :+
                LDA     #4
                STA     vPlayer_counter_a
:

                LDA     vJoystickInput
                CMP     #(~JOYSTICK::J1_UP) & $FF
                BNE     @loc_B8D

@joystick_up:   DEC     PM_YPOS
                BIT     DOUBLE_YSPEED_FLAG
                BMI     :+
                DEC     PM_YPOS
:
                LDA     #PM_IMAGE_OFFSET::CLIMBING
                STA     PLAYER_IMG_ANIM_PHASE
                LDA     #DIRECTION::CLIMB
                STA     vAudio_AUDC2_AUDC3
                BPL     _player_set_direction
; ---------------------------------------------------------------------------

@loc_B8D:       AND     #JOYSTICK::J1_UP
                BNE     @loc_BAF
                LDA     #0
                STA     vWingedAvenger_Counter
                LDA     PLAYER_IMG_ANIM_PHASE
                CMP     #PM_IMAGE_OFFSET::RUN_LEFT_2
                BNE     @loc_BAF
                LDA     #13
                STA     vPlayer_counter_b
                LDA     #8
                STA     vAudio_AUDF2_60Hz_countDown
                DEC     PM_YPOS
                DEC     PM_YPOS
                JMP     _move_x_direction
; ---------------------------------------------------------------------------

@loc_BAF:
                LDA     vJoystickInput
                AND     #JOYSTICK::J1_LEFT
                BEQ     :+
                LDA     #JOYSTICK::J1_RIGHT
                AND     vJoystickInput
                BNE     @loc_BC5
                LDA     #DIRECTION::RIGHT
                BPL     _player_set_direction
:               LDA     #DIRECTION::LEFT
                BPL     _player_set_direction

@loc_BC5:       LDA     #DIRECTION::NONE

_player_set_direction:
                STA     vPLAYER_DIRECTION,X

_move_x_direction:
                LDA     vPLAYER_DIRECTION,X
                CMP     #DIRECTION::LEFT
                BNE     :+
                DEC     PM_XPOS,X
                JMP     _player_no_motion
:               CMP     #DIRECTION::RIGHT
                BNE     _player_no_motion
                INC     PM_XPOS,X

_player_no_motion:
                LDA     PM_XPOS,X
                STA     HPOSP1,X        ; Horizontal position of player 1

                CPX     #PM_OBJECT::PHARAOH
                BNE     @loc_C01
                LDY     vPLAYER_DIRECTION+1
                CPY     #DIRECTION::LEFT
                BEQ     :+
                LDY     #(PM_GRAPHICS_1210_PHARAOH_CLOTHING_RIGHT-PM_GRAPHICS_1210_PHARAOH_CLOTHING_LEFT)+15
                CLC
                ADC     #2
                JMP     @loc_BFC
:               LDY     #15
                CLC
                ADC     #4
@loc_BFC:       STA     HPOSM1          ; Horizontal position of missile 1
                STY     vTEMP2          ; Offset for the clothing of the pharaoh
@loc_C01:
                LDA     PM_XPOS
                STA     HPOSP0          ; Horizontal position of player 0

                DEC     vWingedAvenger_Counter,X
                BPL     loc_C5C
                LDA     #1
                STA     vWingedAvenger_Counter,X
                LDA     vPLAYER_DIRECTION,X
                CMP     #DIRECTION::LEFT
                BCS     :+
                LDA     #PM_IMAGE_OFFSET::STANDING
                STA     PLAYER_IMG_ANIM_PHASE,X
                JMP     loc_C5C

:               CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     :+
                LDA     vPlayer_counter_b
                BPL     loc_C5C
:
                LDA     PLAYER_IMG_ANIM_PHASE,X
                CLC
                ADC     PLAYER_IMG_ANIM_STEP,X
                CMP     #PM_IMAGE_OFFSET::RUN_LEFT_2+1
                BCC     :+
                LDA     #(-(PM_IMAGE_OFFSET::RUN_LEFT_1-PM_IMAGE_OFFSET::RUN_LEFT_0)) & $FF
                STA     PLAYER_IMG_ANIM_STEP,X
                LDA     #PM_IMAGE_OFFSET::RUN_LEFT_2
                BNE     @loc_C59
:
                CMP     #PM_IMAGE_OFFSET::RUN_LEFT_0
                BCS     @loc_C59
                LDA     #(PM_IMAGE_OFFSET::RUN_LEFT_1-PM_IMAGE_OFFSET::RUN_LEFT_0)
                STA     PLAYER_IMG_ANIM_STEP,X
                LDA     #3
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     :+
                STA     vAudio_AUDC2_AUDC3
                BNE     @loc_C57
:               STA     vAudio_AUDC4

                LDA     #96
                STA     AUDF4

@loc_C57:       LDA     #PM_IMAGE_OFFSET::RUN_LEFT_0
@loc_C59:       STA     PLAYER_IMG_ANIM_PHASE,X
loc_C5C:
                LDA     DEATH_ANIM,X
                BNE     :+
                LDA     #$FF            ; no noise
:               STA     vAddRandomDeathNoiseFlag

                LDA     PLAYER_IMG_ANIM_PHASE,X
                LDY     vPLAYER_DIRECTION,X
                CPY     #DIRECTION::LEFT
                BCC     :+
                CPY     #DIRECTION::RIGHT
                BNE     :+
                CLC
                ADC     #PM_IMAGE_OFFSET::RUN_RIGHT_0-PM_IMAGE_OFFSET::RUN_LEFT_0
:
                CPX     #PM_OBJECT::MUMMY
                BNE     :+
                CLC
                ADC     #<PM_GRAPHICS_1280_MUMMY
:
                STA     sSRC_PTR
                LDA     PLAYER_IMG_MSB,X
                STA     sSRC_PTR+1
                LDA     PM_GRAPHICS_MSB,X
                STA     pDEST_PTR+1
                LDA     PM_YPOS,X
                STA     pDEST_PTR

@oloop:
                LDY     #17
                LDA     #0
                STA     (pDEST_PTR),Y   ; 2 empty lines on the top
                DEY
                STA     (pDEST_PTR),Y
                DEY

@loop:
                LDA     (sSRC_PTR),Y
                BIT     vAddRandomDeathNoiseFlag
                BMI     :+
                AND     RANDOM
:               STA     (pDEST_PTR),Y
                DEY
                BPL     @loop

                CPX     #PM_OBJECT::ILLEGAL ; illegal value
                BEQ     @loc_CC2
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     @loc_CCA         ; => no

                DEX
                LDA     sSRC_PTR
                CLC
                ADC     #<PM_GRAPHICS_1100_80_PLAYER_BODY ; Hat, Hands and Feet were the first part drawn, no comes the body
                STA     sSRC_PTR
                LDA     pDEST_PTR+1
                CLC
                ADC     #>(PM_GRAPHICS_1_PLAYER-PM_GRAPHICS_0_PLAYER)
                STA     pDEST_PTR+1
                JMP     @oloop

@loc_CC2:       INX
                INY
                DEC     pDEST_PTR
                LDA     #0
                STA     (pDEST_PTR),Y
@loc_CCA:
                CPX     #PM_OBJECT::PHARAOH
                BNE     @noPharaoh      ; => no

                LDA     #>PM_GRAPHICS_MISSLES
                STA     pDEST_PTR+1
                LDY     #15
                LDX     vTEMP2
:               LDA     (pDEST_PTR),Y
                AND     #%11110011
                ORA     PM_GRAPHICS_1210_PHARAOH_CLOTHING_LEFT,X ; Blue headdress and skirt of the pharao
                STA     (pDEST_PTR),Y
                DEX
                DEY
                BPL     :-
                LDX     #PM_OBJECT::PHARAOH

@noPharaoh:
                JSR     CHECK_LEVEL_EXIT

_player_done:
                                        ; START+49E↑j
                LDA     #3
                STA     vTEMP2          ; This looks like a level based delay to slow the game down

@loopt:         LDA     level
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                STA     vTEMP1
                LDA     #160
                SBC     vTEMP1
                STA     vTEMP1          ; = 160 - level * 32
:               DEC     vTEMP1          ; Count this value down to 0
                BNE     :-              ; Count this value down to 0
                DEC     vTEMP2          ; repeat 3 times
                BPL     @loopt

                DEX
                BMI     :+
                JMP     _next_player_loop

:               LDX     #PM_OBJECT::WINGED_AVENGER ; flying across the screens
                JSR     DO_WINGED_AVENGER
                JSR     DO_FONT_ANIMATIONS
                JMP     GAME_LOOP
.endproc

; =============== S U B R O U T I N E =======================================

.proc CLEAR_PM_GRAPHICS
                LDA     PM_GRAPHICS_MSB,X
                STA     pDEST_PTR+1
.endproc
.proc CLEAR_PM_GRAPHICS_BLOCK
                LDA     #0
                STA     pDEST_PTR
                TAY
@loop:          STA     (pDEST_PTR),Y
                CPX     #PM_OBJECT::PHARAOH
                BNE     @skip
                STA     PM_GRAPHICS_MISSLES,Y
@skip:          DEY
                BNE     @loop
                RTS
.endproc

.proc CLEAR_ALL_PM_GRAPHICS
                LDA     #>PM_GRAPHICS_MISSLES
                STA     pDEST_PTR+1
:               JSR     CLEAR_PM_GRAPHICS_BLOCK
                INC     pDEST_PTR+1
                LDA     pDEST_PTR+1
                CMP     #>FONT_BASE_1800
                BNE     :-
                RTS
.endproc


; =============== S U B R O U T I N E =======================================


FIND_NEXT_ROOM:

; PROTECTION: Checksum over the boot code! This routine is patched before running it
                LDA     #$1E
                LDY     #$3F ; '?'
PROT_CHECKSUM:  STA     LEVEL_MAP_8+$100,Y ; patched to ADC $500,Y
                DEY
                BPL     PROT_CHECKSUM   ; patched to ADC $500,Y
                PHA
; That said: the result is _never_ tested!

                LDA     CURRENT_ROOM,X
                LDY     level_exit_direction,X
                CPY     #LEVEL_EXIT::BOTTOM
                BNE     @checkRoom      ; Row of rooms
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BNE     @checkRoom      ; Row of rooms

@exit_from_title:
                LDA     RANDOM          ; Pick random room 0,2 or 3 after starting the game
                AND     #3
                CMP     #1
                BEQ     @exit_from_title ; Pick random room 0,2 or 3 after starting the game
                BNE     @first_game_room

@checkRoom:     AND     #3              ; Row of rooms
                DEY
                BNE     :+              ; Exit to the left?
                SEC
                SBC     #1              ; Pick room to the left
:
                DEY
                BNE     :+              ; Exit to the right?
                CLC
                ADC     #1              ; Pick room to the right
:
                AND     #3
                STA     vTEMP1          ; Room position in the row

                LDA     #%1100
                AND     CURRENT_ROOM,X  ; vertical position of the room
                DEY
                BNE     :+              ; Exit at the top?
                SEC
                SBC     #4              ; Pick room above
:
                DEY
                BNE     :+              ; Exit at the bottom?
                CLC
                ADC     #4              ; Pick room below
:
                AND     #%1100
                ORA     vTEMP1

@first_game_room:
                STA     CURRENT_ROOM,X

; PROTECTION: Result of the checksum code
                PLA                     ; Checksum (never checked!)
                ORA     #0
                RTS


; =============== S U B R O U T I N E =======================================

.proc CHECK_LEVEL_EXIT
                LDY     #LEVEL_EXIT::NO
                LDA     PM_XPOS,X
                CMP     #42
                BCS     :+
                LDY     #LEVEL_EXIT::LEFT
                BPL     @exit_check_done	; Branch always

:               CMP     #207
                BCC     :+
                LDY     #LEVEL_EXIT::RIGHT
                BPL     @exit_check_done	; Branch always

:               LDA     PM_YPOS,X
                CMP     #23
                BCS     :+
                LDY     #LEVEL_EXIT::TOP
                BPL     @exit_check_done	; Branch always

:               CMP     #228
                BCC     @exit_check_done
                LDY     #LEVEL_EXIT::BOTTOM

@exit_check_done:
                CPY     #LEVEL_EXIT::NO		; did the player exit the level?
                BNE     @level_exit			; yes =>
                RTS


@level_exit:    TYA
                STA     level_exit_direction,X

                JSR     CLEAR_PM_GRAPHICS
                CLC                     ; CLC is part of the checksum for the copy protection
                JSR     FIND_NEXT_ROOM

                CPX     #PM_OBJECT::PLAYER ; the actual player
                BEQ     :+
                LDA     #0
                STA     DEATH_ANIM,X
                RTS

:               LDA     #0
                STA     SNDF1_NoteOffset
                STA     CROWN_ARROW_DURATION+1
                STA     CROWN_ARROW_XPOS
                LDA     #$FF
                STA     GAME_LOOP_COUNTDOWN

                LDY     #0
                LDA     CURRENT_ROOM
                ASL     A
                CLC
                ADC     #>LEVEL_MAP_0
                STA     LEVEL_MAP_ADR+1
                CLC
                ADC     #1
                STA     XLEVELPTR+1     ; Ptr to additional level data ($1E0 bytes after the beginning)
                LDA     #$E0
                STA     XLEVELPTR       ; Ptr to additional level data ($1E0 bytes after the beginning)

                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     vELEVATOR_TOP
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     vELEVATOR_BOTTOM
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     vELEVATOR_X
                STX     vTEMP1
                LDX     #2
@loop:          INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     ENTRY_START_XPOS+1,X
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     ENTRY_START_YPOS+1,X
                INX
                CPX     #LEVEL_EXIT::RIGHT
                BEQ     @loopdone
                CPX     #LEVEL_EXIT::BOTTOM
                BNE     @loop
                LDX     #0
                STX     ATRACT          ; ATTRACT MODE FLAG
                BEQ     @loop

@loopdone:      LDX     vTEMP1
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     COLOR0          ; COLOR 0
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     COLOR1          ; COLOR 1
                INY
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
                STA     COLOR2          ; COLOR 2

                LDA     #$F0
                STA     XLEVELPTR       ; Ptr to additional level data ($1E0 bytes after the beginning)
                LDY     CURRENT_ROOM
                LDA     vTrasuresCollected,Y
                STA     vTEMP1
                LDY     #15
@loopTreas:     LDA     vTEMP1          ; Treasure already collected?
                BEQ     @skipTreas      ; => clear the graphics
                LDA     (XLEVELPTR),Y   ; Ptr to additional level data ($1E0 bytes after the beginning)
@skipTreas:     STA     FONT_TREASURE,Y
                DEY
                BPL     @loopTreas

                LDY     level_exit_direction
                LDA     #0
                BIT     vWingedAvenger_Attach_Flag
                BMI     :+
                DEC     vWingedAvenger_Attach_Flag
                BMI     :+
                LDA     ENTRY_START_XPOS,Y
:               STA     PM_XPOS+3		; X-Position of the Winged Avenger

                LDA     ENTRY_START_YPOS,Y
                STA     PM_YPOS			; X-Position of plater hold by the Winged Avenger
                STA     PM_YPOS+3		; Y-Position of the Winged Avenger
                LDA     ENTRY_START_XPOS,Y
                STA     PM_XPOS			; Y-Position of plater hold by the Winged Avenger

                STX     vTEMP1
                LDX     CURRENT_ROOM
                LDY     #7
:               LDA     save_FONT_1800_5B_GATE,X
                STA     FONT_GATE,Y		; fully open the gate by erasing it
                DEY
                BPL     :-
                LDX     vTEMP1

                LDY     #15
:               LDA     save_FONT_1800_5C_KEY,Y
                STA     FONT_KEY,Y		; restore the key
                DEY
                BPL     :-

                JSR     CLEAR_ALL_PM_GRAPHICS

                LDA     #8
                STA     SHOT_COUNTER+1	; delay for pharaoh and mummy bullets
                STA     SHOT_COUNTER+2

                ; reset the elevator state
                LDA     vELEVATOR_STATE
                BMI     :+
                LDA     #ELEVATOR_STATE::RESTORE
                STA     vELEVATOR_STATE
                JSR     DO_ELEVATOR
:
                LDA     #ELEVATOR_STATE::START
                STA     vELEVATOR_STATE

                LDA     vELEVATOR_X
                CMP     #20
                BCS     @hasElevator
@noElevator:    LDA     #192
                STA     vELEVATOR_STATE
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                RTS
@hasElevator:   LDA     #0
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                STA     vELEVATOR_Y
                LDA     vELEVATOR_BOTTOM
                SEC
                SBC     #34
                CMP     #192
                BCS     @noElevator     ; This seems never happen with the levels!

                AND     #$F0            ; yOffset = ((LEVEL_Y_BOTTOM - 34) >> 4) * 40
                LSR     A
                STA     vTEMP1
                ASL     A
                ROL     ELEVATOR_PTR+1  ; 40 bytes per line
                ASL     A
                ROL     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                CLC
                ADC     vTEMP1
                STA     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                LDA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                ADC     #0
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator

                LDA     vELEVATOR_X     ; offset = yOffset + (LEVEL_X - 48) >> 2
                SEC
                SBC     #48
                LSR     A               ; 4 Pixel per char
                LSR     A
                CLC
                ADC     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                STA     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                STA     save_ELEVATOR_PTR
                BCC     :+
                INC     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
:
                LDA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                CLC
                ADC     LEVEL_MAP_ADR+1 ; Base address of the level data
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                STA     save_ELEVATOR_PTR+1
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc DO_BULLET
                LDA     BULLET_MAX_DISTANCE,X
                BMI     :+
                JMP     @move_bullet

:               LDA     CURRENT_ROOM,X
                CMP     CURRENT_ROOM
                BNE     @rts
                LDA     DEATH_ANIM,X
                BNE     @rts
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BEQ     :+
                LDA     SHOT_COUNTER,X
                BNE     @rts
                LDA     RANDOM
                AND     #$F
                BNE     @rts
                BEQ     @trigger
:
                LDA     STRIG0          ; Joystick button 0 pressed?
                BEQ     @trigger
@rts:           RTS

@trigger:       INC     pDEST_PTR
                BNE     :+
                INC     pDEST_PTR+1
:
                LDA     SUBPIXEL_Y
                SEC
                SBC     #4
                STA     vTEMP1
                BPL     :+
                LDA     pDEST_PTR
                SEC
                SBC     #40
                STA     pDEST_PTR
                BCS     :+
                DEC     pDEST_PTR+1
:
                LDA     vTEMP1
                AND     #7
                STA     BULLET_SAVE_SUBPIXEL_Y,X
                STA     SUBPIXEL_Y
                LDA     pDEST_PTR
                STA     BULLET_TILE_LSB,X
                LDA     pDEST_PTR+1
                STA     BULLET_TILE_MSB,X

                LDA     vPLAYER_DIRECTION,X
                CMP     #DIRECTION::LEFT
                BNE     @noLeft
                LDA     #256-4
                BNE     @shootLeft
@noLeft:        CMP     #DIRECTION::RIGHT
                BNE     @rts
                LDA     #4
@shootLeft:     STA     BULLET_SPEED,X

                LDA     #50
                STA     BULLET_MAX_DISTANCE,X
                LDA     #8
                STA     vAudio_AUDC1
                LDA     #$FF
                STA     vAudio_AUDF1
                LDA     PM_XPOS,X
                STA     BULLET_XPOS,X
                LDA     PM_YPOS,X
                STA     BULLET_YPOS,X
                JMP     @bullet_on_screen

@move_bullet:
                LDA     BULLET_TILE_LSB,X
                STA     pDEST_PTR
                LDA     BULLET_TILE_MSB,X
                STA     pDEST_PTR+1
                LDA     BULLET_SAVE_SUBPIXEL_Y,X
                STA     SUBPIXEL_Y
                LDA     BULLET_SAVE_TILE,X
                LDY     #0
                STA     (pDEST_PTR),Y
                STX     vTEMP1
                LDA     BULLET_MAX_DISTANCE,X
                BNE     :+
                JMP     @move_bullet_next
:
                LDY     #PM_OBJECT::MUMMY
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BEQ     @scan_target_loop
                LDY     #PM_OBJECT::PLAYER ; the actual player
@scan_target_loop:
                CPY     vTEMP1
                BEQ     @scan_target_next
                LDA     CURRENT_ROOM
                CMP     CURRENT_ROOM,Y
                BEQ     @inSameRoom
@scan_target_next:
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     @move_bullet_next
                DEY
                BNE     @scan_target_loop
                BEQ     @move_bullet_next	; Branch always

@inSameRoom:    LDA     BULLET_XPOS,X
                SEC
                SBC     PM_XPOS,Y			; X-Distance
                CMP     #5
                BCS     @scan_target_next

                LDA     BULLET_YPOS,X
                SEC
                SBC     PM_YPOS,Y
                BPL     :+
                EOR     #$FF
:               CMP     #7					; Y-Distance
                BCS     @scan_target_next
                LDA     DEATH_ANIM,Y		; already dieing?
                BNE     @scan_target_next
                LDA     #32
                STA     DEATH_ANIM,Y

                CPY     #PM_OBJECT::PLAYER ; target is the actual player?
                BEQ     :+				   ; => yes
                LDA     BULLET_MAX_DISTANCE,Y
                BMI     :+
                LDA     #0
                STA     BULLET_MAX_DISTANCE,Y
:
                CPY     #PM_OBJECT::PLAYER ; Target was the player?
                BNE     @add_y_times_5_to_score ; => no, the player hit the pharao or mummy

                DEC     player_lives
                JSR     SOUND_PLAY_on_CH4
                LDA     #$FF
                STA     vKeyCollectedWhenPositive
                JMP     @remove_bullet_hit

@add_y_times_5_to_score:
                JSR     SOUND_PLAY_on_CH4
                SED
@loop:          LDA     #5
                CLC
                ADC     SCORE
                STA     SCORE
                BCC     :+
                INC     SCORE+1
:               DEY
                BPL     @loop
                CLD

@remove_bullet_hit:
                LDA     #$FF
                STA     BULLET_MAX_DISTANCE,X
                JSR     DRAW_TREASURES_LIVES

@move_bullet_next:
                DEC     BULLET_MAX_DISTANCE,X
                BMI     @remove_bullet

                LDA     BULLET_XPOS,X
                LDY     BULLET_SPEED,X
                BMI     @bulletLeft		; => bullet flies to the left
                CLC
                ADC     #4
                STA     BULLET_XPOS,X
                INC     pDEST_PTR
                BNE     @checkBulletPos
                INC     pDEST_PTR+1
                BNE     @checkBulletPos	; Branch always =>

@bulletLeft:    SEC
                SBC     #4
                STA     BULLET_XPOS,X
                LDA     pDEST_PTR
                SEC
                SBC     #1
                STA     pDEST_PTR
                BCS     @checkBulletPos
                DEC     pDEST_PTR+1

; Did the bullet left the screen?
@checkBulletPos:LDA     BULLET_XPOS,X
                CMP     #204
                BCS     @remove_bullet
                CMP     #44
                BCS     @bullet_on_screen
@remove_bullet: LDA     #$FF
                STA     BULLET_MAX_DISTANCE,X
                RTS

@bullet_on_screen:
                LDY     #0
                STY     MULT_TMP+1
                LDA     (pDEST_PTR),Y
                STA     vTEMP1
                AND     #(~TILE::ACTION_FLAG) & $FF
                CMP     #TILE::TRAP_0_left
                BCC     @validTile
                CMP     #TILE::BULLET_0
                BCS     @remove_bullet
                SEC
                SBC     #TILE::TRAP_0_left
                LSR     A
                TAY
                LDA     TRAP_ANIM_PHASE,Y
                BPL     @remove_bullet

@validTile:
                LDA     vTEMP1
                STA     BULLET_SAVE_TILE,X
                AND     #(~TILE::ACTION_FLAG) & $FF
                ASL     A
                ROL     MULT_TMP+1
                ASL     A
                ROL     MULT_TMP+1
                ASL     A
                ROL     MULT_TMP+1
                STA     MULT_TMP
                LDA     #>FONT_BASE_1800
                CLC
                ADC     MULT_TMP+1
                STA     MULT_TMP+1
                STX     vTEMP1
                TXA
                ASL     A
                ASL     A
                ASL     A
                CLC
                ADC     #7
                TAX
                LDY     #7
@loop2:         LDA     (MULT_TMP),Y ; load current bitmap from character
                CPY     SUBPIXEL_Y
                BNE     @loopj          ; create bullet character
                CMP     #%00000000      ; nothing in the bitmap?
                BEQ     :+              ; correct => add the bullet
                LDX     vTEMP1
                BPL     @remove_bullet  ; otherwise remove the bullet
:               ORA     #%00000100      ; add the bullet to the bitmap
@loopj:         STA     FONT_BASE_1800_68_BULLET,X ; create bullet character
                DEX
                DEY
                BPL     @loop2          ; load current bitmap from character

                INY
                LDA     vTEMP1
                TAX
                CLC
                ADC     #TILE::BULLET_0
                STA     (pDEST_PTR),Y
                LDA     pDEST_PTR
                STA     BULLET_TILE_LSB,X
                LDA     pDEST_PTR+1
                STA     BULLET_TILE_MSB,X
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc SOUND_PLAY_on_CH4
                LDA     #(HUE_YELLOW<<4)|14
                CPY     #SOUND_EFFECT::WINGED_AVENGER_SHOT
                BCS     :+
                STA     PCOLR1,Y        ; P1 COLOR
:
                LDA     #>SND_EFFECT_LOST_LIFE
                STA     SND_PTR+1       ; Ptr to frequency table when playing a sound effect
                LDA     SND_TABLE_LSB,Y
                STA     SND_PTR         ; Ptr to frequency table when playing a sound effect
                STY     SND_save_Y
                LDY     #7
@loop:          LDA     (SND_PTR),Y     ; Ptr to frequency table when playing a sound effect
                STA     AUDF4
                LDA     #AUDC_POLYS_NONE|3
                STA     AUDC4

                LDA     #256-4
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
:               LDA     RTCLOK+2        ; 1/15s delay
                BNE     :-

                STA     ATRACT          ; ATTRACT MODE FLAG
                DEY
                BPL     @loop
                LDY     SND_save_Y
                LDA     #0
                STA     AUDC4
                RTS
.endproc

; ---------------------------------------------------------------------------
                .BYTE $A9

; ---------------------------------------------------------------------------
; Pharaoh's Curse graphics
; ---------------------------------------------------------------------------
.assert * = $1100, error, "PM data not at $1100"
PM_GRAPHICS_1100_PLAYER:.BYTE  $00, $00, $1C, $3E, $1C, $1C, $08, $08, $00, $1C, $41, $00, $00, $00, $36, $00
                .BYTE  $00, $00, $1C, $3E, $1C, $1C, $08, $08, $41, $1C, $00, $00, $00, $63, $00, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $00, $00, $20, $00, $00, $00, $00, $18, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $00, $00, $44, $00, $00, $00, $60, $0C, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $40, $00, $02, $00, $00, $C1, $01, $00, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $00, $00, $04, $00, $00, $00, $00, $18, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $00, $00, $22, $00, $00, $00, $06, $30, $00
                .BYTE  $00, $00, $18, $3C, $18, $18, $00, $00, $02, $40, $00, $00, $83, $80, $00, $00
PM_GRAPHICS_1100_80_PLAYER_BODY:.BYTE  $00, $00, $00, $00, $1C, $1C, $08, $3E, $5D, $5D, $5D, $14, $14, $14, $00, $00
                .BYTE  $00, $00, $00, $00, $1C, $1C, $08, $3E, $5D, $1C, $3E, $41, $22, $00, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $08, $18, $18, $38, $18, $08, $08, $08, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $08, $18, $38, $5C, $18, $28, $2C, $04, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $08, $58, $3C, $1A, $78, $48, $0E, $00, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $10, $18, $18, $1C, $18, $10, $10, $10, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $10, $18, $1C, $3A, $18, $14, $34, $20, $00, $00
                .BYTE  $00, $00, $00, $00, $18, $18, $10, $18, $3E, $58, $1E, $12, $70, $00, $00, $00
PM_GRAPHICS_1200_PHARAOH:.BYTE  $00, $08, $08, $18, $58, $13, $7C, $EC, $B8, $80, $28, $28, $28, $28, $6C, $00
PM_GRAPHICS_1210_PHARAOH_CLOTHING_LEFT:.BYTE  $00, $08, $0C, $0C, $0C, $00, $00, $08, $00, $08, $08, $08, $00, $00, $00, $00
                .BYTE  $00, $10, $10, $18, $1A, $08, $BE, $55, $1D, $01, $14, $14, $14, $14, $36, $00
                .BYTE  $00, $10, $10, $18, $1A, $88, $7E, $15, $1D, $01, $14, $34, $22, $62, $03, $00
                .BYTE  $00, $10, $10, $18, $9A, $48, $3E, $15, $1D, $31, $74, $46, $C2, $03, $00, $00
                .BYTE  $00, $08, $08, $18, $58, $10, $7D, $AA, $B8, $40, $28, $28, $28, $28, $6C, $00
                .BYTE  $00, $08, $08, $18, $58, $11, $7E, $A8, $B8, $80, $28, $6C, $44, $46, $C0, $00
                .BYTE  $00, $08, $08, $18, $59, $12, $7C, $AC, $B8, $08, $2E, $6A, $42, $C3, $00, $00
PM_GRAPHICS_1280_MUMMY:.BYTE  $00, $00, $38, $38, $38, $10, $38, $7C, $BA, $38, $38, $28, $28, $28, $6C, $00
PM_GRAPHICS_1210_PHARAOH_CLOTHING_RIGHT:.BYTE  $00, $04, $0C, $0C, $08, $00, $00, $04, $00, $04, $04, $04, $00, $00, $00, $00

                .BYTE  $00, $00, $1C, $1C, $0C, $0C, $FC, $1C, $1C, $1C, $0C, $0C, $0C, $0C, $1C, $00
                .BYTE  $00, $00, $1C, $1C, $0C, $0C, $7C, $1C, $1C, $0C, $0C, $1C, $34, $22, $66, $00
                .BYTE  $00, $00, $00, $1C, $1C, $0C, $0C, $FC, $1C, $1C, $0C, $3C, $64, $47, $C1, $00
                .BYTE  $00, $00, $1C, $1C, $18, $18, $1F, $1C, $1C, $1C, $18, $18, $18, $18, $1C, $00
                .BYTE  $00, $00, $1C, $1C, $18, $18, $1F, $1C, $1C, $18, $18, $1C, $16, $22, $33, $00
                .BYTE  $00, $00, $00, $1C, $1C, $18, $18, $1F, $1C, $1C, $18, $1E, $13, $71, $41, $00

; ---------------------------------------------------------------------------
; Pharaoh's Curse Player Missile Memory
; ---------------------------------------------------------------------------
.assert * = $1300, error, "PM graphics not at $1300"
PM_GRAPHICS_MISSLES:
                .BYTE  $84, $B1, $90, $29, $F8, $F0, $38, $4A, $4A, $4A, $85, $85, $C8, $B1, $90, $C5
                .BYTE  $80, $F0, $14, $18, $A5, $84, $65, $85, $69, $01, $65, $90, $85, $90, $A5, $91
                .BYTE  $69, $00, $85, $91, $4C, $EE, $52, $E6, $97, $CA, $F0, $15, $E6, $96, $A4, $96
                .BYTE  $B1, $92, $85, $80, $E6, $97, $C8, $B1, $90, $C5, $80, $F0, $EC, $D0, $D4, $38
                .BYTE  $60, $A5, $96, $38, $65, $92, $85, $92, $90, $02, $E6, $93, $A5, $97, $38, $65
                .BYTE  $90, $85, $90, $90, $02, $E6, $91, $A0, $00, $B1, $90, $18, $60, $18, $65, $84
                .BYTE  $85, $84, $90, $3A, $E6, $85, $60, $18, $B5, $00, $65, $84, $85, $84, $B5, $01
                .BYTE  $65, $85, $85, $85, $60, $18, $B5, $00, $65, $82, $85, $82, $B5, $01, $65, $83
                .BYTE  $85, $83, $60, $A6, $84, $86, $80, $A6, $85, $86, $81, $A5, $80, $38, $E5, $82
                .BYTE  $85, $82, $A5, $81, $E5, $83, $85, $83, $90, $04, $D0, $02, $A5, $82, $60, $A2
                .BYTE  $82, $B5, $01, $49, $FF, $95, $01, $B5, $00, $49, $FF, $95, $00, $4C, $B2, $53
                .BYTE  $A2, $84, $F6, $00, $D0, $E8, $F6, $01, $60, $D6, $00, $48, $A9, $FF, $D5, $00
                .BYTE  $D0, $02, $D6, $01, $68, $60, $A6, $81, $F0, $D4, $46, $83, $66, $82, $CA, $D0
                .BYTE  $F9, $60, $A5, $81, $48, $A5, $80, $48, $A6, $82, $86, $80, $A6, $83, $86, $81
                .BYTE  $A6, $84, $86, $82, $A6, $85, $86, $83, $A2, $00, $86, $84, $86, $85, $A5, $81
                .BYTE  $05, $80, $F0, $0D, $A2, $82, $20, $67, $53, $A2, $80, $20, $B9, $53, $4C, $EE
PM_GRAPHICS_0_PLAYER:.BYTE  $53, $68, $85, $80, $68, $85, $81, $60, $A2, $51, $C9, $40, $F0, $17, $A2, $48
                .BYTE  $C9, $24, $F0, $11, $A2, $42, $C9, $25, $F0, $0B, $C9, $30, $90, $09, $C9, $3A
                .BYTE  $B0, $05, $AE, $86, $04, $18, $60, $38, $60, $A5, $81, $48, $A5, $80, $48, $A5
                .BYTE  $85, $48, $A5, $84, $48, $A2, $00, $86, $82, $86, $83, $86, $81, $86, $80, $A0
                .BYTE  $00, $B1, $84, $C9, $30, $90, $17, $C9, $3A, $90, $08, $C9, $41, $90, $0F, $C9
                .BYTE  $5B, $B0, $0B, $E6, $80, $E6, $84, $D0, $02, $E6, $85, $4C, $41, $54, $A2, $84
                .BYTE  $20, $B9, $53, $B1, $84, $85, $81, $68, $85, $86, $68, $85, $87, $A5, $85, $48
                .BYTE  $A5, $84, $48, $A6, $86, $86, $84, $A6, $87, $86, $85, $A5, $80, $D0, $03, $4C
                .BYTE  $1B, $55, $AD, $86, $04, $30, $21, $A5, $81, $C6, $80, $F0, $19, $C9, $42, $D0
                .BYTE  $03, $4C, $AF, $55, $C9, $4E, $F0, $2A, $C9, $51, $D0, $03, $4C, $42, $55, $C9
                .BYTE  $48, $D0, $03, $4C, $6F, $55, $E6, $80, $AD, $86, $04, $29, $7F, $C9, $42, $D0
                .BYTE  $03, $4C, $AF, $55, $C9, $51, $D0, $03, $4C, $42, $55, $C9, $48, $D0, $03, $4C
                .BYTE  $6F, $55, $A5, $80, $C9, $02, $90, $34, $F0, $27, $C9, $04, $90, $18, $F0, $0B
                .BYTE  $A2, $10, $86, $80, $A2, $27, $86, $81, $20, $1F, $55, $A2, $E8, $86, $80, $A2
                .BYTE  $03, $86, $81, $20, $1F, $55, $A2, $64, $86, $80, $A2, $00, $86, $81, $20, $1F
                .BYTE  $55, $A2, $0A, $86, $80, $A2, $00, $86, $81, $20, $1F, $55, $A2, $01, $86, $80
PM_GRAPHICS_1_PLAYER:.BYTE  $A2, $00, $86, $81, $20, $1F, $55, $18, $68, $85, $84, $68, $85, $85, $68, $85
                .BYTE  $80, $68, $85, $81, $60, $68, $85, $80, $68, $85, $81, $38, $4C, $08, $55, $A0
                .BYTE  $00, $B1, $84, $38, $E9, $30, $30, $ED, $C9, $0A, $B0, $E9, $E6, $84, $D0, $02
                .BYTE  $E6, $85, $C9, $00, $F0, $0B, $85, $86, $A2, $80, $20, $75, $53, $C6, $86, $D0
                .BYTE  $F7, $60, $A0, $00, $B1, $84, $38, $E9, $30, $30, $D0, $C9, $08, $B0, $CC, $05
                .BYTE  $82, $85, $82, $E6, $84, $D0, $02, $E6, $85, $C6, $80, $F0, $AA, $A2, $82, $20
                .BYTE  $75, $53, $A2, $82, $20, $75, $53, $A2, $82, $20, $75, $53, $4C, $42, $55, $A0
                .BYTE  $00, $B1, $84, $C9, $30, $30, $A4, $C9, $3A, $90, $0A, $C9, $41, $90, $9C, $C9
                .BYTE  $47, $B0, $98, $E9, $06, $29, $0F, $05, $82, $85, $82, $E6, $84, $D0, $02, $E6
                .BYTE  $85, $C6, $80, $D0, $03, $4C, $07, $55, $A2, $82, $20, $75, $53, $A2, $82, $20
                .BYTE  $75, $53, $A2, $82, $20, $75, $53, $A2, $82, $20, $75, $53, $4C, $6F, $55, $A2
                .BYTE  $00, $86, $82, $86, $83, $A0, $00, $B1, $84, $38, $E9, $30, $30, $1E, $C9, $02
                .BYTE  $B0, $1A, $85, $86, $A2, $82, $20, $75, $53, $A5, $86, $05, $82, $85, $82, $E6
                .BYTE  $84, $D0, $02, $E6, $85, $C6, $80, $D0, $DC, $4C, $07, $55, $4C, $1B, $55, $A2
                .BYTE  $18, $86, $80, $A2, $FC, $86, $81, $20, $18, $56, $20, $41, $56, $A2, $9C, $86
                .BYTE  $80, $A2, $FF, $86, $81, $20, $18, $56, $20, $41, $56, $A2, $F6, $86, $80, $A2
PM_GRAPHICS_2_PHARAO:.BYTE  $FF, $86, $81, $20, $18, $56, $20, $41, $56, $A5, $84, $18, $69, $30, $A0, $00
                .BYTE  $91, $82, $A9, $30, $8D, $69, $56, $60, $A0, $30, $A5, $83, $48, $A5, $82, $48
                .BYTE  $A6, $84, $86, $82, $A6, $85, $86, $83, $C8, $A2, $80, $20, $67, $53, $B0, $F0
                .BYTE  $88, $A6, $82, $86, $84, $A6, $83, $86, $85, $68, $85, $82, $68, $85, $83, $98
                .BYTE  $60, $85, $81, $AD, $69, $56, $C5, $81, $D0, $0D, $A9, $20, $A0, $00, $91, $82
                .BYTE  $E6, $82, $D0, $02, $E6, $83, $60, $A5, $81, $A0, $00, $91, $82, $E6, $82, $D0
                .BYTE  $02, $E6, $83, $A9, $FF, $8D, $69, $56, $60, $30, $A0, $00, $B1, $84, $0A, $0A
                .BYTE  $0A, $0A, $29, $0F, $18, $69, $30, $91, $82, $E6, $82, $D0, $02, $E6, $83, $B1
                .BYTE  $84, $29, $0F, $18, $69, $30, $91, $82, $E6, $82, $D0, $02, $E6, $83, $E6, $84
                .BYTE  $D0, $02, $E6, $85, $C6, $81, $F0, $0D, $A5, $80, $91, $82, $E6, $82, $D0, $02
                .BYTE  $E6, $83, $4C, $6A, $56, $60, $A5, $85, $C5, $83, $D0, $07, $A5, $84, $C5, $82
                .BYTE  $D0, $01, $18, $60, $A6, $82, $A4, $84, $84, $82, $86, $84, $A6, $83, $A4, $85
                .BYTE  $84, $83, $86, $85, $60, $A0, $00, $A2, $84, $20, $B9, $53, $B1, $84, $A2, $82
                .BYTE  $20, $B9, $53, $91, $82, $A2, $80, $20, $B9, $53, $A5, $81, $05, $80, $D0, $E7
                .BYTE  $60, $A4, $81, $F0, $0A, $98, $48, $20, $EF, $56, $68, $A8, $88, $D0, $F6, $A0
                .BYTE  $00, $A6, $80, $E0, $00, $F0, $16, $B1, $84, $91, $82, $C8, $CA, $D0, $F8, $98
PM_GRAPHICS_3_MUMMY:.BYTE  $20, $5D, $53, $98, $18, $65, $82, $85, $82, $90, $02, $E6, $83, $60, $A5, $85
                .BYTE  $20, $15, $57, $A5, $84, $48, $6A, $6A, $6A, $6A, $20, $1E, $57, $68, $A0, $00
                .BYTE  $29, $0F, $C9, $0A, $90, $02, $69, $06, $18, $69, $30, $91, $82, $E6, $82, $D0
                .BYTE  $02, $E6, $83, $60, $A6, $82, $86, $86, $A6, $83, $86, $87, $A0, $00, $B1, $8E
                .BYTE  $C9, $44, $D0, $1B, $91, $86, $C8, $B1, $8E, $C9, $3A, $D0, $0E, $A9, $31, $91
                .BYTE  $86, $E6, $86, $D0, $02, $E6, $87, $A9, $3A, $D0, $14, $C9, $35, $90, $03, $4C
                .BYTE  $F2, $57, $C9, $31, $90, $F9, $91, $86, $C8, $B1, $8E, $C9, $3A, $D0, $F0, $91
                .BYTE  $86, $A2, $00, $C8, $B1, $8E, $C9, $9B, $D0, $03, $4C, $F4, $57, $C9, $00, $F0
                .BYTE  $F9, $C9, $5B, $90, $03, $4C, $F2, $57, $C9, $41, $90, $F9, $91, $86, $E8, $C8
                .BYTE  $B1, $8E, $91, $86, $C9, $9B, $F0, $18, $C9, $00, $F0, $14, $C9, $2E, $F0, $31
                .BYTE  $C9, $5B, $90, $03, $4C, $F2, $57, $C9, $30, $90, $F9, $E8, $E0, $09, $90, $DF
                .BYTE  $A9, $2E, $91, $86, $A2, $00, $BD, $3F, $24, $C8, $91, $86, $C9, $00, $F0, $09
                .BYTE  $C9, $9B, $F0, $09, $E8, $E0, $04, $90, $ED, $A9, $9B, $91, $86, $A9, $20, $18
                .BYTE  $60, $A2, $00, $C8, $B1, $8E, $91, $86, $C9, $9B, $F0, $F1, $C9, $00, $F0, $E9
                .BYTE  $C9, $5B, $90, $03, $4C, $F2, $57, $C9, $30, $90, $F9, $E8, $E0, $04, $90, $E3
                .BYTE  $B0, $D7, $38, $60, $A9, $9B, $91, $86, $A9, $3A, $18, $60, $4C, $C7, $2A, $A9

; ---------------------------------------------------------------------------
; Pharaoh's Curse Main Font
; ---------------------------------------------------------------------------
.assert * = $1800, error, "Main Font not at $1800"
FONT_BASE_1800: .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$55,$55,$55
                .BYTE $55,$55,$55,$55,$55,$55,$55,$50
                .BYTE $55,$55,$55,$55,$55,$50,$00,$00
                .BYTE $55,$55,$55,$50,$00,$00,$00,$00
                .BYTE $55,$50,$00,$00,$00,$00,$00,$00
                .BYTE $50,$00,$00,$00,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$54,$50,$40
                .BYTE $55,$54,$50,$40,$00,$00,$00,$00
                .BYTE $55,$05,$00,$00,$00,$00,$00,$00
                .BYTE $55,$55,$55,$05,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$05,$00,$00
                .BYTE $55,$55,$55,$55,$55,$55,$55,$05
                .BYTE $01,$01,$01,$01,$04,$04,$04,$04
                .BYTE $55,$15,$05,$01,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$15,$05,$01
                .BYTE $55,$55,$55,$00,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$00,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$55,$00,$00
                .BYTE $55,$55,$55,$55,$55,$55,$55,$00
                .BYTE $00,$50,$55,$55,$55,$55,$55,$55
                .BYTE $00,$00,$00,$50,$55,$55,$55,$55
                .BYTE $00,$00,$00,$00,$00,$50,$55,$55
                .BYTE $00,$00,$00,$00,$00,$00,$00,$50
                .BYTE $40,$50,$54,$55,$55,$55,$55,$55
                .BYTE $00,$00,$00,$00,$40,$50,$54,$55
                .BYTE $00,$00,$00,$00,$00,$00,$05,$55
                .BYTE $00,$00,$00,$00,$05,$55,$55,$55
                .BYTE $00,$00,$05,$55,$55,$55,$55,$55
                .BYTE $05,$55,$55,$55,$55,$55,$55,$55
                .BYTE $00,$00,$00,$00,$01,$05,$15,$55
                .BYTE $01,$05,$15,$55,$55,$55,$55,$55
                .BYTE $00,$00,$00,$00,$00,$00,$45,$55
                .BYTE $00,$00,$00,$00,$00,$00,$55,$55
                .BYTE $00,$00,$00,$00,$00,$55,$55,$55
                .BYTE $00,$00,$00,$00,$55,$55,$55,$55
                .BYTE $00,$00,$00,$55,$55,$55,$55,$55
                .BYTE $00,$00,$55,$55,$55,$55,$55,$55
                .BYTE $00,$55,$55,$55,$55,$55,$55,$55
FONT_BASE_1800_28_ROPE:.BYTE $04,$01,$04,$01,$04,$01,$04,$01
                .BYTE $88,$22,$88,$22,$88,$22,$88,$22
                .BYTE $80,$AA,$A8,$22,$88,$22,$88,$22
                .BYTE $8A,$22,$8A,$22,$8A,$22,$8A,$22
                .BYTE $88,$A2,$88,$A2,$88,$A2,$88,$A2
                .BYTE $88,$22,$88,$22,$A8,$8A,$80,$00
                .BYTE $A8,$2A,$0A,$00,$00,$00,$00,$00
                .BYTE $88,$22,$88,$AA,$0A,$02,$02,$00
                .BYTE $88,$22,$88,$22,$8A,$28,$A0,$80
                .BYTE $8A,$2A,$A8,$A0,$00,$00,$00,$00
                .BYTE $55,$65,$89,$22,$88,$22,$88,$22
                .BYTE $55,$55,$55,$66,$99,$22,$88,$22
                .BYTE $55,$55,$55,$55,$55,$65,$99,$26
                .BYTE $55,$56,$58,$52,$58,$52,$48,$22
                .BYTE $AA,$A2,$80,$00,$00,$00,$00,$00
                .BYTE $AA,$2A,$08,$00,$00,$00,$00,$00
                .BYTE $80,$A0,$A0,$20,$A8,$28,$8A,$22
                .BYTE $02,$02,$08,$0A,$28,$2A,$A8,$A2
                .BYTE $80,$A0,$A0,$28,$8A,$2A,$A8,$A0
                .BYTE $00,$02,$0A,$2A,$A8,$2A,$08,$02
                .BYTE $00,$00,$00,$00,$00,$55,$26,$0C
                .BYTE $55,$7F,$75,$77,$77,$75,$7F,$55
                .BYTE $55,$F5,$55,$FD,$5D,$5D,$FD,$55
                .BYTE $55,$FD,$5D,$DD,$DD,$5D,$FD,$55
                .BYTE $57,$57,$FF,$D7,$D7,$5F,$75,$75
                .BYTE $DF,$5D,$FD,$D5,$D5,$F5,$5D,$5F
                .BYTE $57,$5D,$57,$55,$5D,$75,$75,$5F
                .BYTE $F5,$55,$F5,$5D,$57,$5D,$75,$D5
                .BYTE $55,$55,$55,$55,$55,$55,$77,$FF
                .BYTE $55,$57,$55,$57,$55,$57,$55,$57
                .BYTE $D5,$55,$D5,$55,$D5,$55,$D5,$55
                .BYTE $77,$55,$55,$55,$55,$55,$55,$55
                .BYTE $00,$00,$00,$00,$00,$00,$55,$DD
                .BYTE $75,$5D,$57,$7F,$D7,$5F,$75,$55
                .BYTE $5D,$75,$D5,$FD,$D7,$F5,$5D,$55
FONT_FIELD_moveRight:.BYTE $0A,$A0,$0A,$A0,$0A,$A0,$0A,$A0
FONT_FIELD_moveLeft:.BYTE $0A,$A0,$0A,$A0,$0A,$A0,$0A,$A0
                .BYTE $0A,$A0,$0A,$A0,$0A,$A0,$0A,$A0
                .BYTE $00,$00,$55,$2A,$0C,$00,$00,$00
                .BYTE $55,$55,$55,$55,$55,$55,$77,$FF
                .BYTE $F5,$FD,$F5,$FD,$F5,$FD,$F5,$FD
                .BYTE $7F,$5F,$7F,$5F,$7F,$5F,$7F,$5F
                .BYTE $FD,$F5,$FD,$F5,$FD,$F5,$FF,$FF
                .BYTE $7F,$5F,$7F,$5F,$7F,$5F,$FF,$FF
                .BYTE $08,$08,$08,$08,$08,$08,$08,$08
                .BYTE $00,$00,$00,$00,$08,$08,$08,$08
                .BYTE $00,$00,$00,$00,$00,$00,$00,$55
                .BYTE $8F,$23,$8F,$23,$8F,$23,$8F,$23
                .BYTE $00,$00,$00,$00,$00,$00,$A5,$57
                .BYTE $00,$00,$00,$00,$00,$00,$55,$57
                .BYTE $F2,$CA,$F2,$CA,$F2,$CA,$F2,$CA
FONT_GATE:      .BYTE $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC
FONT_KEY:       .BYTE $00,$00,$00,$00,$00,$3C,$C3,$3C
                .BYTE $00,$00,$00,$00,$00,$00,$FF,$33
FONT_TREASURE:  .BYTE $FF,$3F,$CF,$C3,$33, $F,  3,$3F
                .BYTE $FF,$FC,$F3,$C3,$CC,$F0,$C0,$FC
FONT_TRAP_0_left:.BYTE $00,$00,$00,$00,$00,$01,$55,$55
FONT_TRAP_0_right:.BYTE $00,$00,$00,$00,$00,$40,$55,$55
FONT_TRAP_1:    .BYTE $00,$00,$00,$00,$00,$01,$55,$55
FONT_TRAP_1_right:.BYTE $00,$00,$00,$00,$00,$40,$55,$55
FONT_TRAP_2:    .BYTE $00,$00,$00,$00,$00,$01,$55,$55
FONT_TRAP_2_right:.BYTE $00,$00,$00,$00,$00,$40,$55,$55
FONT_TRAP_3:    .BYTE $00,$00,$00,$00,$00,$01,$55,$55
FONT_TRAP_3_right:.BYTE $00,$00,$00,$00,$00,$40,$55,$55
FONT_BASE_1800_68_BULLET:.BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_ELEVATOR_0:.BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_ELEVATOR_1:.BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_ELEVATOR_2:.BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_ELEVATOR_3:.BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_DOOR_0:    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_DOOR_1:    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_DOOR_2:    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_DOOR_3:    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
                .BYTE $00,$00,$00,$00,$00,$00,$00,$00
FONT_ROPE_ANIM_0:.BYTE $04,$01,$04,$01,$0C,$01,$04,$03
FONT_ROPE_ANIM_1:.BYTE $01,$04,$01,$0C,$01,$04,$03,$04
FONT_ROPE_ANIM_2:.BYTE $04,$01,$0C,$01,$04,$03,$04,$01
FONT_ROPE_ANIM_3:.BYTE $01,$0C,$01,$04,$03,$04,$01,$04
FONT_TRAP_ACTIVE_0:.BYTE $00,$00,$00,$00,$00,$01,$55,$55
                .BYTE $00,$00,$00,$00,$00,$40,$55,$55
FONT_TRAP_ACTIVE_1:.BYTE $00,$00,$00,$00,$00,$03,$55,$55
                .BYTE $00,$00,$00,$00,$00,$C0,$55,$55

; ---------------------------------------------------------------------------
; Pharaoh's Curse Status Line B/W Font
; ---------------------------------------------------------------------------
.assert * = $1C00, error, "Status Line Font not at $1800"
FONT_BASE_1C00: .BYTE  $3C, $7E, $66, $66, $66, $66, $7E, $3C
                .BYTE  $18, $38, $18, $18, $18, $18, $18, $3C
                .BYTE  $38, $6C, $0C, $18, $30, $60, $78, $7C
                .BYTE  $7E, $46, $0C, $18, $0C, $06, $4E, $7C
                .BYTE  $18, $3C, $6C, $6C, $7E, $0C, $0C, $1C
                .BYTE  $7E, $62, $60, $60, $18, $06, $66, $7C
                .BYTE  $3C, $66, $60, $7C, $66, $66, $7E, $3C
                .BYTE  $7E, $7E, $4C, $1C, $38, $30, $30, $30
                .BYTE  $3C, $66, $7E, $3C, $66, $66, $7E, $3C
                .BYTE  $3C, $66, $66, $66, $3E, $06, $66, $3C
FONT_BASE_1C00_CROWN:.BYTE  $00, $00, $5A, $A5, $A5, $7E, $3C, $7E
FONT_BASE_1C00_PLAYER:.BYTE  $1C, $1C, $08, $3E, $5D, $55, $14, $36
                .BYTE  $38, $38, $54, $54, $6C, $38, $38, $28
FONT_BASE_1C00_TREASURE___:.BYTE  $00, $00, $00, $00, $00, $00, $00, $00
FONT_BASE_1C00_TREASURE__X:.BYTE  $00, $00, $20, $70, $50, $20, $00, $00
FONT_BASE_1C00_TREASURE_X_:.BYTE  $00, $00, $02, $07, $05, $02, $00, $00
FONT_BASE_1C00_TREASURE_XX:.BYTE  $00, $00, $22, $77, $55, $22, $00, $00
FONT_BASE_1C00_GAMEOVER:.BYTE  $7D, $65, $61, $61, $6D, $65, $7D, $00
                .BYTE  $F6, $35, $35, $F4, $34, $34, $34, $00
                .BYTE  $EF, $6C, $6C, $6E, $6C, $6C, $6F, $00
                .BYTE  $1F, $13, $13, $13, $13, $13, $9F, $00
                .BYTE  $4D, $4D, $4D, $4D, $6D, $6D, $39, $00
                .BYTE  $E7, $84, $84, $C7, $84, $84, $F4, $00
                .BYTE  $80, $80, $80, $80, $C0, $C0, $C0, $00
FONT_BASE_1C00_18_WINGED_AVENGER:.BYTE  $00, $00, $00, $E7, $66, $3C, $18, $00
                .BYTE  $00, $00, $00, $E7, $7E, $18, $00, $00
                .BYTE  $00, $00, $00, $E7, $3C, $00, $00, $00
                .BYTE  $00, $00, $00, $FF, $00, $00, $00, $00
                .BYTE  $00, $00, $7E, $E7, $00, $00, $00, $00
FONT_BASE_1C00_ARROW_RIGHT:.BYTE  $00, $20, $90, $50, $7F, $50, $90, $20
FONT_BASE_1C00_ARROW_LEFT:.BYTE  $00, $04, $09, $0A, $FE, $0A, $09, $04
                .BYTE  $3E, $49, $49, $36, $3E, $2A, $22, $00
FONT_TRAP_0_ANIM:.BYTE $00,$00,$00,$00,$00,$01,$54,$55
                .BYTE $00,$00,$00,$00,$00,$40,$15,$55
                .BYTE $00,$00,$00,$00,$01,$04,$50,$55
                .BYTE $00,$00,$00,$00,$40,$10,$05,$55
                .BYTE $00,$00,$00,$01,$04,$10,$43,$55
                .BYTE $00,$00,$00,$40,$10,$04,$C1,$55
                .BYTE $00,$00,$03,$13,$13,$43,$43,$55
                .BYTE $00,$00,$C0,$C4,$C4,$C1,$C1,$55
FONT_TRAP_1_ANIM:.BYTE $00,$00,$00,$00,$00,$00,$57,$55
                .BYTE $00,$00,$00,$00,$00,$00,$55,$55
                .BYTE $00,$00,$00,$00,$00,$00,$50,$55
                .BYTE $00,$00,$00,$00,$00,$C0,$C5,$55
                .BYTE $00,$00,$00,$00,$00,$0C,$43,$55
                .BYTE $00,$00,$00,$00,$C0,$CC,$F1,$55
                .BYTE $00,$00,$00,$00,$0C,$03,$00,$55
                .BYTE $00,$00,$00,$C0,$CC,$F0,$C1,$55
FONT_TRAP_2_ANIM:.BYTE $00,$00,$00,$00,$00,$00,$50,$55
                .BYTE $00,$00,$00,$00,$00,$00,$C5,$55
                .BYTE $00,$00,$00,$00,$00,$30,$4C,$55
                .BYTE $00,$00,$00,$00,$C0,$30,$3D,$55
                .BYTE $00,$00,$03,$30,$30,$0C,$0F,$55
                .BYTE $00,$00,$C0,$F0,$F0,$3C,$3C,$55
                .BYTE $3F,$C3,$C0,$F0,$3C,$3F,$03,$55
                .BYTE $00,$C0,$F0,$F0,$FC,$FC,$FC,$55
FONT_TRAP_3_ANIM:.BYTE $00,$00,$00,$00,$30,$C0,$15,$55
                .BYTE $00,$00,$00,$00,$00,$00,$54,$55
                .BYTE $00,$00,$03,$0C,$00,$00,$15,$55
                .BYTE $00,$00,$00,$00,$00,$00,$54,$55
                .BYTE $00,$00,$00,$00,$00,$00,$15,$55
                .BYTE $00,$00,$C0,$30,$00,$00,$54,$55
                .BYTE $00,$00,$00,$00,$00,$00,$15,$55
                .BYTE $00,$00,$00,$00,$0C,$03,$54,$55

; ---------------------------------------------------------------------------
; Pharaoh's Curse Display List
; ---------------------------------------------------------------------------
GAME_DISPLIST:  .BYTE DL_DLI            ; DIL_TOP is called
                .BYTE DL_BLK8
                .BYTE DL_BLK8
                .BYTE DL_CHR20x8x2 | DL_LMS
                .WORD STATUS_LINE
                .BYTE DL_BLK1 | DL_DLI  ; DIL_TITLE_ROOM or DIL_OTHER_ROOM is called
                .BYTE DL_CHR40x16x4 | DL_VSCROL | DL_LMS
LEVEL_MAP_ADR:  .WORD LEVEL_MAP_TITLE
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL | DL_DLI ; on the title screen: DIL_OTHER_ROOM is called
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_CHR40x16x4 | DL_VSCROL
                .BYTE DL_JVB
                .WORD GAME_DISPLIST

; ---------------------------------------------------------------------------
; Pharaoh's Curse Display List Routines
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

.proc DLI_TITLE_ROOM
                PHA
                LDA     #>FONT_BASE_TITLE
                STA     CHBASE          ; Character base address
                LDA     COLOR2          ; COLOR 2
                STA     COLPF2          ; Color and luminance of playfield 2
                LDA     COLOR3          ; COLOR 3
                STA     COLPF3          ; Color and luminance of playfield 3
                LDA     #<DLI_OTHER_ROOM
                STA     VDSLST          ; DISPLAY LIST NMI VECTOR
                PLA
                RTI
.endproc

; =============== S U B R O U T I N E =======================================


.proc DLI_TOP
                PHA
                LDA     #(HUE_GREY<<4)|10
                STA     COLPF2          ; Color and luminance of playfield 2
                LDA     #(HUE_PURPLE<<4)|8
                STA     COLPF3          ; Color and luminance of playfield 3
DLI_select_room:
                LDA     #<DLI_OTHER_ROOM
                STA     VDSLST          ; DISPLAY LIST NMI VECTOR
                PLA
                RTI
.endproc

; =============== S U B R O U T I N E =======================================

.proc DLI_OTHER_ROOM
                PHA
                LDA     #>FONT_BASE_1800
                STA     CHBASE          ; Character base address
                LDA     COLOR2          ; COLOR 2
                STA     COLPF2          ; Color and luminance of playfield 2
                LDA     COLOR3          ; COLOR 3
                STA     COLPF3          ; Color and luminance of playfield 3
                STA     WSYNC           ; Wait for horizontal synchronization
                PLA
                RTI
.endproc

; ---------------------------------------------------------------------------
; Pharaoh's Curse Variables
; ---------------------------------------------------------------------------
                .BYTE $FF,$FF,$FF       ; unused
vAddRandomDeathNoiseFlag:.BYTE $FF
level_exit_direction:.BYTE LEVEL_EXIT::NO,LEVEL_EXIT::NO,LEVEL_EXIT::NO
SHOT_COUNTER:   .BYTE $00,$FF,$FF,$1F
SNDF1_NoteOffset:.BYTE 0
SNDF1_NoteDelay:.BYTE 0
SND_ZeroOneToggle: .BYTE 0
SNDF1_NoteIndex:.BYTE 1
SHOT_SOUND_TIMER:.BYTE 0
SHOT_PROBABILITY:.BYTE $10
GAME_LOOP_COUNTDOWN:.BYTE $FF

SND_EFFECT_LOST_LIFE:.BYTE 243
                .BYTE 230
                .BYTE 217
                .BYTE 204
                .BYTE 193
                .BYTE 182
                .BYTE 173
                .BYTE 162
SND_EFFECT_KILLED_PHARAO:.BYTE 60
                .BYTE 64
                .BYTE 81
                .BYTE 76
                .BYTE 85
                .BYTE 108
                .BYTE 102
                .BYTE 121
SND_EFFECT_KILLED_MUMMY:.BYTE 45
                .BYTE 47
                .BYTE 60
                .BYTE 64
                .BYTE 57
                .BYTE 81
                .BYTE 91
                .BYTE 76
SND_EFFECT_WINGED_AVENGER_SHOT:.BYTE 60
                .BYTE 68
                .BYTE 76
                .BYTE 85
                .BYTE 96
                .BYTE 85
                .BYTE 76
                .BYTE 68
SND_EFFECT_TREASURE_COLLECTED:.BYTE 60
                .BYTE 60
                .BYTE 81
                .BYTE 96
                .BYTE 121
                .BYTE 162
                .BYTE 193
                .BYTE 243
SND_EFFECT_KEY_COLLECTED:.BYTE 10
                .BYTE 20
                .BYTE 10
                .BYTE 20
                .BYTE 10
                .BYTE 20
                .BYTE 10
                .BYTE 20
SND_EFFECT_OPEN_GATE:.BYTE 230
                .BYTE 204
                .BYTE 144
                .BYTE 217
                .BYTE 153
                .BYTE 230
                .BYTE 162
                .BYTE 243
SND_EFFECT_GAME_END:.BYTE 114
                .BYTE 96
                .BYTE 114
                .BYTE 136
                .BYTE 114
                .BYTE 136
                .BYTE 162
                .BYTE 136

PM_XPOS:        .BYTE  96,124,124,124
BULLET_XPOS:    .BYTE   0,  0,  0,  0
PM_YPOS:        .BYTE 184,192,204,180
BULLET_YPOS:    .BYTE   0,  0,  0,  0
vKeyCollectedWhenPositive:.BYTE $FF
vGateOpenPosition:.BYTE $FF

PLAYER_IMG_MSB: .BYTE >PM_GRAPHICS_1100_PLAYER
                .BYTE >PM_GRAPHICS_1200_PHARAOH
                .BYTE >PM_GRAPHICS_1280_MUMMY
                .BYTE >FONT_BASE_1C00_18_WINGED_AVENGER

PM_GRAPHICS_MSB:.BYTE >PM_GRAPHICS_0_PLAYER
PROT_PM_GRAPHICS_MSB_1:.BYTE >PM_GRAPHICS_2_PHARAO
PROT_PM_GRAPHICS_MSB_2:.BYTE >PM_GRAPHICS_3_MUMMY
                .BYTE >PM_GRAPHICS_MISSLES
                .BYTE >PM_GRAPHICS_1100_PLAYER

vWingedAvenger_Attach_Flag:.BYTE $FF

COLOR_TAB:      .BYTE (HUE_GOLDORANGE<<4)|6
                .BYTE (HUE_BLUE2<<4)|8
                .BYTE (HUE_GOLDORANGE<<4)|10
                .BYTE (HUE_GREY<<4)|10

SND_TABLE_LSB:  .BYTE <SND_EFFECT_LOST_LIFE
                .BYTE <SND_EFFECT_KILLED_PHARAO
                .BYTE <SND_EFFECT_KILLED_MUMMY
                .BYTE <SND_EFFECT_WINGED_AVENGER_SHOT
                .BYTE <SND_EFFECT_TREASURE_COLLECTED
                .BYTE <SND_EFFECT_KEY_COLLECTED
                .BYTE <SND_EFFECT_OPEN_GATE
                .BYTE <SND_EFFECT_GAME_END

FONT_TRAP_ANIM_LSB:.BYTE <FONT_TRAP_0_ANIM
                .BYTE <FONT_TRAP_1_ANIM
                .BYTE <FONT_TRAP_2_ANIM
                .BYTE <FONT_TRAP_3_ANIM
CROWN_ARROW_DURATION:.BYTE  $EA, $FF
CROWN_ARROW_XPOS:.BYTE  $FF, $FF
CROWN_ARROW_LSB:.BYTE  $FF, $FF
CROWN_ARROW_type:.BYTE  $FF,   0
CROWN_ARROW_SOUND_DELAY:.BYTE    0,   0
CROWN_ARROW_COUNTER:.BYTE    0,   0
CROWN_ARROW_SOUND:.BYTE    0,   0
ARROW_XOFFSET:  .BYTE    0,   0
                .BYTE   0
CROWN_ARROW_GRAPHICS_LSB:.BYTE <FONT_BASE_1C00_CROWN
                .BYTE <FONT_BASE_1C00_ARROW_RIGHT
cARROW_XOFFSET_TAB:.BYTE 256-1
                .BYTE 1
s_LEVEL_0_:     .BYTE " LEVEL 0 "
vDemoMode:      .BYTE $FF
FONT_ANIM_DOOR_POSITION:.BYTE   0,  2,  4,  6
FONT_ANIM_DOOR_DIR:.BYTE   1,  1,  1,  1
FONT_ANIM_DOOR: .BYTE 0,8,16,24
PLAYER_IMG_ANIM_STEP:.BYTE  16, 16, 16, 16
TRAP_ANIM_STEP: .BYTE  16, 16, 16, 16
TRAP_ANIM_PHASE:.BYTE $FF,$FF,$FF,$FF   ; 'TRAP' is the original name
TRAP_ANIM_DELAY:.BYTE $FF,$FF,$FF,$FF
vELEVATOR_STATE:.BYTE $FF
vPlayer_counter_b:.BYTE  $FF, $FF, $FF, $FF

; ---------------------------------------------------------------------------
; Garbage (memory alignment for the level data)
; ---------------------------------------------------------------------------
                .BYTE  $8E, $6B, $65, $A2, $20, $8E, $87, $04
                .BYTE  $8E, $88, $04, $A2, $6E, $8E, $89, $04
                .BYTE  $A2, $6F, $8E, $8A, $04, $A2, $46, $A0
                .BYTE  $6D, $86, $A9, $84, $AA, $86, $B5, $84
                .BYTE  $B6, $86, $B7, $84, $B8, $86, $B9, $84
                .BYTE  $BA, $A2, $78, $A0, $67, $86, $B3, $84
                .BYTE  $B4, $A2, $FF, $8E, $80, $04, $A2, $3F
                .BYTE  $8E, $81, $04, $A2, $20, $8E, $2C, $3E
                .BYTE  $86, $DD, $A0, $00, $A9, $20, $A2, $19
                .BYTE  $86, $8C, $A2, $05, $86, $8D, $A2, $64
                .BYTE  $86, $8E, $A2, $05, $86, $8F, $91, $8C
                .BYTE  $91, $8E, $C8, $C0, $32, $D0, $F7, $A9
                .BYTE  $00, $A2, $06, $9D, $6E, $65, $CA, $10
                .BYTE  $FA, $60, $45, $6E, $74, $65, $72, $20
                .BYTE  $73, $6F, $75, $72, $63, $65, $20, $66
                .BYTE  $69, $6C, $65, $20, $6E, $61, $6D, $65
                .BYTE  $20, $61, $6E, $64, $20, $6F, $70, $74
                .BYTE  $69, $6F, $6E, $73, $9B, $A9, $02, $85
                .BYTE  $52, $A9, $27, $85, $53, $20, $CB, $4F
                .BYTE  $B0, $CF, $A2, $05, $BD, $15, $24, $9D
                .BYTE  $06, $05, $CA, $D0, $F7, $AD, $0C, $05
                .BYTE  $48, $A9, $9B, $8D, $0C, $05, $A2, $ED
                .BYTE  $86, $8C, $A2, $04, $86, $8D, $A9, $53
                .BYTE  $8D, $6C, $65, $A9, $00, $20, $DB, $50
                .BYTE  $A2, $E9, $86, $8C, $A2, $23, $86, $8D
                .BYTE  $A9, $00, $20, $04, $51, $68, $8D, $0C
                .BYTE  $05, $A2, $82, $86, $8C, $A2, $5F, $86
                .BYTE  $8D, $A9, $00, $20, $DB, $50, $B0, $3C
                .BYTE  $A9, $00, $20, $B3, $50, $B0, $35, $A2

; ---------------------------------------------------------------------------
; Pharaoh's Curse Level Data
; ---------------------------------------------------------------------------
.include "Levels.s"

; ---------------------------------------------------------------------------
; Pharaoh's Curse Title Screen Font
; ---------------------------------------------------------------------------
.assert * = $4000, error, "Title font not at $4000"
FONT_BASE_TITLE:.BYTE  $00, $00, $00, $00, $00, $00, $00, $00; 0
                .BYTE  $C0, $F0, $FC, $EC, $EC, $EC, $EC, $EC; 8
                .BYTE  $3F, $FB, $EB, $FB, $3B, $3B, $3B, $3B; $10
                .BYTE  $3F, $FB, $EB, $FF, $C3, $00, $00, $0A; $18
                .BYTE  $C0, $F0, $BC, $AC, $AC, $BC, $F0, $C0; $20
                .BYTE  $0F, $3F, $3B, $3B, $3B, $3B, $3B, $3B; $28
                .BYTE  $00, $00, $00, $00, $00, $00, $3C, $EB; $30
                .BYTE  $03, $0E, $3A, $3A, $EF, $FC, $F0, $F0; $38
                .BYTE  $FC, $AF, $FF, $C0, $00, $00, $00, $00; $40
                .BYTE  $00, $C0, $B0, $2C, $0B, $0F, $3F, $FB; $48
                .BYTE  $0F, $3E, $3A, $3A, $3A, $3E, $0F, $00; $50
                .BYTE  $FF, $00, $00, $03, $00, $C0, $B0, $FC; $58
                .BYTE  $00, $B0, $B0, $00, $00, $00, $00, $00; $60
                .BYTE  $FF, $3B, $0E, $3B, $3B, $3B, $3B, $3B; $68
                .BYTE  $FF, $EB, $C0, $00, $00, $00, $00, $00; $70
                .BYTE  $FC, $EC, $EC, $EC, $FC, $3C, $0C, $00; $78
                .BYTE  $00, $00, $00, $54, $44, $44, $44, $54; $80
                .BYTE  $00, $00, $00, $10, $10, $10, $10, $10; $88
                .BYTE  $00, $00, $00, $54, $04, $54, $40, $54; $90
                .BYTE  $00, $00, $00, $54, $04, $14, $04, $54; $98
                .BYTE  $00, $00, $00, $44, $44, $54, $04, $04; $A0
                .BYTE  $3F, $3B, $3B, $3B, $3F, $3C, $30, $00; $A8
                .BYTE  $3A, $0E, $03, $00, $00, $00, $03, $00; $B0
                .BYTE  $C0, $C0, $F0, $B0, $F0, $C0, $00, $00; $B8
                .BYTE  $00, $00, $00, $54, $44, $54, $44, $54; $C0
                .BYTE  $00, $00, $00, $54, $44, $54, $04, $04; $C8
                .BYTE  $00, $00, $00, $00, $10, $00, $10, $00; $D0
                .BYTE  $E0, $F0, $38, $3E, $0F, $03, $00, $00; $D8
                .BYTE  $03, $0F, $3E, $FA, $AA, $BF, $F0, $00; $E0
                .BYTE  $AF, $AC, $BC, $F0, $C0, $00, $00, $00; $E8
                .BYTE  $00, $00, $00, $0F, $3E, $0F, $00, $00; $F0
                .BYTE  $05, $10, $45, $44, $44, $45, $10, $05; $F8
                .BYTE  $40, $10, $44, $04, $04, $44, $10, $40; $100
                .BYTE  $00, $00, $00, $54, $44, $54, $44, $44; $108
                .BYTE  $00, $00, $00, $54, $44, $54, $44, $54; $110
                .BYTE  $00, $00, $00, $54, $40, $40, $40, $54; $118
                .BYTE  $00, $00, $00, $50, $44, $44, $44, $50; $120
                .BYTE  $00, $00, $00, $54, $40, $50, $40, $54; $128
                .BYTE  $00, $00, $00, $54, $40, $50, $40, $40; $130
                .BYTE  $00, $00, $00, $54, $40, $41, $44, $54; $138
                .BYTE  $00, $00, $00, $44, $44, $54, $44, $44; $140
                .BYTE  $00, $00, $00, $10, $10, $10, $10, $10; $148
                .BYTE  $00, $00, $00, $04, $04, $04, $44, $54; $150
                .BYTE  $00, $00, $00, $40, $44, $50, $44, $44; $158
                .BYTE  $00, $00, $00, $40, $40, $40, $40, $54; $160
                .BYTE  $00, $00, $00, $44, $54, $54, $44, $44; $168
                .BYTE  $00, $00, $00, $40, $54, $54, $44, $44; $170
                .BYTE  $00, $00, $00, $54, $44, $44, $44, $54; $178
                .BYTE  $00, $00, $00, $54, $44, $54, $40, $40; $180
                .BYTE  $F0, $FC, $EC, $EC, $FC, $F0, $C0, $00; $188
                .BYTE  $00, $00, $00, $54, $44, $50, $44, $44; $190
                .BYTE  $00, $00, $00, $14, $40, $10, $04, $50; $198
                .BYTE  $00, $00, $00, $54, $10, $10, $10, $10; $1A0
                .BYTE  $00, $00, $00, $44, $44, $44, $44, $10; $1A8
                .BYTE  $00, $00, $04, $44, $44, $44, $44, $10; $1B0
                .BYTE  $00, $00, $00, $44, $44, $54, $54, $44; $1B8
                .BYTE  $00, $00, $00, $44, $44, $10, $44, $44; $1C0
                .BYTE  $00, $00, $00, $44, $44, $54, $04, $54; $1C8
                .BYTE  $FC, $0F, $C3, $00, $C0, $FF, $00, $00; $1D0
                .BYTE  $00, $C0, $F0, $BC, $BC, $F0, $00, $00; $1D8
                .BYTE  $3A, $3A, $3E, $3F, $0F, $00, $00, $00; $1E0
                .BYTE  $00, $00, $00, $C0, $E3, $FF, $00, $00; $1E8
                .BYTE  $00, $30, $0C, $3C, $F0, $C0, $00, $00; $1F0
                .BYTE  $80, $00, $00, $00, $00, $00, $00, $00; $1F8

; =============== S U B R O U T I N E =======================================

.proc CALC_TILE_POS
                LDA     #0
                STA     pDEST_PTR+1
                LDA     PM_YPOS,X
                CMP     #37
                BCC     @loc_4212
                SEC
                SBC     #19
                CMP     #192
                BCC     @loc_421D

@loc_4212:      LDA     #0
                STA     TILE_RIGHT,X
                STA     TILE_MID,X
                JMP     @loc_42BD
; ---------------------------------------------------------------------------

@loc_421D:      STA     vTEMP1
                LSR     A
                AND     #7
                STA     SUBPIXEL_Y
                LDA     vTEMP1
                AND     #$F0
                LSR     A
                STA     vTEMP1
                ASL     A
                ROL     pDEST_PTR+1
                ASL     A
                ROL     pDEST_PTR+1
                CLC
                ADC     vTEMP1
                STA     pDEST_PTR
                BCC     :+
                INC     pDEST_PTR+1
:
                LDA     PM_XPOS,X
                SEC
                SBC     #44
                STA     vTEMP1
                AND     #3
                STA     SUBPIXEL_X
                LDA     vTEMP1
                LSR     A
                LSR     A
                CLC
                ADC     pDEST_PTR
                STA     pDEST_PTR
                LDA     pDEST_PTR+1
                ADC     LEVEL_MAP_ADR+1
                STA     pDEST_PTR+1

                LDA     pDEST_PTR
                SEC
                SBC     #1
                STA     pDEST_PTR
                LDA     pDEST_PTR+1
                SBC     #0
                STA     pDEST_PTR+1

                LDA     #3
                STA     vTEMP1

@loc_4267:
                LDA     SUBPIXEL_X
                STA     vTEMP2
                LDA     #0
                STA     MULT_TMP+1
                DEC     vTEMP1
                LDY     vTEMP1
                LDA     (pDEST_PTR),Y
                PHA
                AND     #TILE::ACTION_FLAG
                STA     vTEMP3
                PLA
                AND     #(~TILE::ACTION_FLAG) & $FF
                CPY     #1
                BNE     :+
                STA     ROPE_UNDER_PLAYER,X
:
                ASL     A
                ROL     MULT_TMP+1
                ASL     A
                ROL     MULT_TMP+1
                ASL     A
                ROL     MULT_TMP+1
                STA     MULT_TMP
                LDA     MULT_TMP+1
                CLC
                ADC     #>FONT_BASE_1800
                STA     MULT_TMP+1
                LDY     SUBPIXEL_Y
                LDA     (MULT_TMP),Y
                ROL     A
:               ROL     A
                ROL     A
                DEC     vTEMP2
                BPL     :-
                AND     #3
                LDY     vTEMP1
                CPY     #2
                BNE     @loc_42B1
                ORA     vTEMP3
                STA     TILE_RIGHT,X
                JMP     @loc_4267

@loc_42B1:      CPY     #1
                BNE     @loc_42BB
                STA     TILE_MID,X
                JMP     @loc_4267

@loc_42BB:      ORA     vTEMP3
@loc_42BD:      STA     TILE_LEFT,X
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc CHECK_NEXT_ROPE
                LDA     #0
                STA     pDEST_PTR+1
                LDA     PM_YPOS,X
                SEC
                SBC     #30
                CMP     #192
                BCC     :+
                LDY     #$FF
                RTS
:
                AND     #$F0
                LSR     A
                STA     vTEMP1
                ASL     A
                ROL     pDEST_PTR+1
                ASL     A
                ROL     pDEST_PTR+1
                CLC
                ADC     vTEMP1
                STA     pDEST_PTR
                BCC     :+
                INC     pDEST_PTR+1
:
                LDA     PM_XPOS,X
                SEC
                SBC     #42
                LSR     A
                LSR     A
                CLC
                ADC     pDEST_PTR
                STA     pDEST_PTR
                BCC     :+
                INC     pDEST_PTR+1
:
                CLC
                LDA     pDEST_PTR+1
                ADC     LEVEL_MAP_ADR+1
                STA     pDEST_PTR+1

                LDA     pDEST_PTR
                SEC
                SBC     #1
                STA     pDEST_PTR
                BCS     :+
                DEC     pDEST_PTR+1
:
                LDY     #1
                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     @notPlayer

@loop:          LDA     (pDEST_PTR),Y
                CMP     #TILE::ROPE
                BNE     :+
                STA     ROPE_UNDER_PLAYER,X
:               STA     CURRENT_CH,Y    ; only written to, unused
                DEY
                BPL     @loop

@notPlayer:     LDY     #0
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc GAME_DONE
                LDA     #ROOM_NUMBER::R10
                STA     CURRENT_ROOM
                LDA     #250
                STA     PM_YPOS
                STA     vDemoMode
                LDX     #0
                STX     player_lives
                JSR     CHECK_LEVEL_EXIT
                JSR     TITLE_TEXT_LINE_CLEAR
                LDA     PLAYER_STATE
                CMP     #PLAYER_STATE::WON_GAME ; Player won the game
                BEQ     @player_won
                JSR     TITLE_SHOW_AND_WAIT
                JMP     @continue
@player_won:    JSR     INCREASE_LEVEL
@continue:
                JSR     TITLE_SHOW_LEVEL_TEXT

                LDA     #0
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
:               LDA     RTCLOK+2        ; 2.13s delay
                BPL     :-

                LDA     #0
                STA     ATRACT          ; ATTRACT MODE FLAG
                JSR     TITLE_TEXT_LINE_CLEAR
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc INCREASE_LEVEL
                INC     level
                LDA     level
                CMP     #4
                BCC     :+
                LDA     #3
:
                STA     level
                JSR     TITLE_SHOW_LEVEL_TEXT
                LDA     level
                ASL     A
                CLC
                ADC     level
                CLC
                ADC     #8
                TAY
@loop:          LDA     s_CODE,Y
                SEC
                SBC     #' '
                STA     LEVEL_MAP_TITLE_LINE_7+$F,Y
                DEY
                BPL     @loop
                LDA     #KEY_NONE
                STA     CH              ; GLOBAL VARIABLE FOR KEYBOARD

@wait_button_or_key:
                LDA     STRIG0          ; Joystick button 0 pressed?
                BEQ     @wait_button_or_key_done
                LDA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                CMP     #KEY_NONE
                BEQ     @wait_button_or_key

@wait_button_or_key_done:
                RTS
.endproc


; =============== S U B R O U T I N E =======================================

.proc TITLE_SHOW_AND_WAIT
                LDA     #KEY_NONE
                STA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                LDA     #1
                STA     RTCLOK+1        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)

TITLE_CODE_OR_TRIGGER_loop:
                LDY     #24

@loop:          LDA     RTCLOK+1        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                AND     #$20 ; ' '
                BEQ     @alt_text
                LDA     sOR_PRESSS_TRIGGER_TO_BEGIN,Y
                JMP     @continue
@alt_text:      LDA     sENTER_SECRET_CODE_WORD___,Y
@continue:      SEC
                SBC     #' '
                STA     LEVEL_MAP_TITLE_LINE_7+7,Y
                DEY
                BPL     @loop
                JMP     TITLE_WAIT_FOR_START
.endproc

; =============== S U B R O U T I N E =======================================

.proc TITLE_PASSWORD_ENTRY
                JSR     TITLE_TEXT_LINE_CLEAR

                LDA     #OPCODE::JMP
                STA     pDEST_PTR
                LDA     KEYBDV+4        ; GET CHAR FROM KEYBOARD
                STA     pDEST_PTR+1
                LDA     KEYBDV+4+1      ; GET CHAR FROM KEYBOARD
                STA     sSRC_PTR
                INC     pDEST_PTR+1
                BNE     :+
                INC     sSRC_PTR
:
                LDA     #0
                STA     level
                LDA     #2
                STA     vPasswordIndex

@loop:          INC     vPasswordIndex
                JSR     pDEST_PTR       ; GET CHAR FROM KEYBOARD
                LDA     ATACHR          ; ATASCII CHARACTER
                LDY     vPasswordIndex
                CMP     sPASSWORD,Y
                BNE     @pw_end
                SEC
                SBC     #' '
                STA     LEVEL_MAP_TITLE_LINE_7+7,Y
                JMP     @loop

@pw_end:        TYA
                CMP     #6
                BCC     @rts
                INC     level
                CMP     #9
                BCC     @rts
                INC     level
                CMP     #12
                BCC     @rts
                INC     level
@rts:
                RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc TITLE_TEXT_LINE_CLEAR
                LDY     #27
                LDA     #0
:               STA     LEVEL_MAP_TITLE_LINE_7+5,Y
                DEY
                BPL     :-
                RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc TITLE_SHOW_LEVEL_TEXT
                JSR     TITLE_TEXT_LINE_CLEAR
                LDA     level
                CLC
                ADC     #'0'
                STA     s_LEVEL_0_+7
                LDY     #7
@loop:          LDA     s_LEVEL_0_,Y
                SEC
                SBC     #' '
                STA     LEVEL_MAP_TITLE_LINE_7+7,Y
                DEY
                BPL     @loop
                RTS
.endproc

; ---------------------------------------------------------------------------
sENTER_SECRET_CODE_WORD___:
                .BYTE "ENTER SECRET CODE WORD   "
sOR_PRESSS_TRIGGER_TO_BEGIN:
                .BYTE "OR PRESS TRIGGER TO BEGIN"

; =============== S U B R O U T I N E =======================================

.proc TITLE_WAIT_FOR_START
                LDA     #0
                STA     AUDC2
                LDA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                CMP     #KEY_NONE
                BEQ     :+
                JMP     TITLE_PASSWORD_ENTRY
:
                LDA     STRIG0          ; Joystick button 0 pressed?
                BNE     :+              ; Here sort of a loop counter
                RTS
:
                INC     RTCLOK+1        ; Here sort of a loop counter
                BNE     :+
                LDA     #0
                STA     vDemoMode
                LDA     #(~JOYSTICK::J1_RIGHT) & $FF
                STA     vJoystickInput  ; Demo mode starts after around 1:20min
                RTS
:
                LDA     RTCLOK+1        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                AND     #$15
                BNE     :+
                JMP     TITLE_SHOW_AND_WAIT::TITLE_CODE_OR_TRIGGER_loop

:               LDY     #0
                LDA     #AUDC_POLYS_NONE|2
                STA     AUDC2
@loop:          LDA     RANDOM
                AND     #7
                CMP     #SOUND_EFFECT::KEY_COLLECTED
                BCS     @loop
                SEC
                SBC     #2
                CLC
                ADC     vRandomSound
                AND     #$F
                STA     vRandomSound
                TAX
                LDA     SND_EFFECT_KILLED_PHARAO,X
                STA     AUDF2
                LDA     RANDOM
                AND     #$3F ; '?'
                BNE     :+
                JSR     SOUND_PLAY_on_CH4
:
                LDA     RANDOM
                AND     #8
                ORA     #7
                STA     vTEMP1
                LDA     #0
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)

@delay_loop:    LDA     CH              ; GLOBAL VARIABLE FOR KEYBOARD
                CMP     #KEY_NONE
                BEQ     :+
                JMP     TITLE_WAIT_FOR_START
:
                LDA     RTCLOK+2        ; 1/8-1/4s wait time (random)
                CMP     vTEMP1
                BCC     @delay_loop

                JMP     TITLE_WAIT_FOR_START
.endproc


; =============== S U B R O U T I N E =======================================

.proc DRAW_TREASURES_LIVES
                STX     vTEMP2
                LDX     #7
                LDY     #14
@loop:          LDA     vTrasuresCollected,Y
                STA     vTEMP1
                LDA     vTrasuresCollected+1,Y
                ASL     A
                ORA     vTEMP1
                CLC
                ADC     #FONT_1C00::TREASURE___
                ORA     #%11000000
                STA     STATUS_LINE,X
                DEY
                DEY
                DEX
                BPL     @loop

                LDA     #FONT_1C00::TREASURE___
                STA     STATUS_LINE+8

                LDX     player_lives
                BMI     @rts

                LDY     #9
@loop2:         LDA     #FONT_1C00::TREASURE___
                DEX
                BMI     :+
                LDA     #FONT_1C00::PLAYER|FONT_1C00::COLOR_2
:               STA     STATUS_LINE,Y
                INY
                CPY     #14
                BNE     @loop2

                LDA     #FONT_1C00::TREASURE___
                STA     STATUS_LINE,Y

@rts:           LDX     vTEMP2
                RTS
.endproc

; ---------------------------------------------------------------------------
SND_MELODY:     .BYTE 106
                .BYTE 102
                .BYTE 85
                .BYTE 78
                .BYTE 70
                .BYTE 66
                .BYTE 55
                .BYTE 52
                .BYTE 48
                .BYTE 40
                .BYTE 37

; =============== S U B R O U T I N E =======================================

.proc VBLANK_IRQ
                LDA     vAudio_AUDF2_60Hz_countDown
                BEQ     :+
                CLC
                ADC     #8
                STA     vAudio_AUDF2_60Hz_countDown
:
                BIT     PLAYER_STATE
                BMI     @irq_VBLANK_audio_4
                BIT     vWingedAvenger_Attach_Flag
                BPL     @irq_VBLANK_audio_4
                LDA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
                AND     #3
                BNE     :+
                LDA     vAudio_AUDC2_AUDC3
                BEQ     @irq_VBLANK_audio_4
                DEC     vAudio_AUDC2_AUDC3
:
                LDA     vAudio_AUDF2_base
                SBC     #5
                BPL     :+
                LDA     #$40 ; '@'
:
                STA     vAudio_AUDF2_base
                SBC     vAudio_AUDF2_60Hz_countDown
                ADC     #204
                STA     AUDF2
                STA     vAudio_AUDF3
                LDA     RANDOM
                AND     #3
                ADC     vAudio_AUDF3
                STA     AUDF3
                LDA     vAudio_AUDC2_AUDC3
                ORA     #AUDC_POLYS_NONE
                STA     AUDC2
                STA     AUDC3

@irq_VBLANK_audio_4:

                LDX     #PM_OBJECT::WINGED_AVENGER ; flying across the screens
                LDA     #0
                STA     vCollisionsPlayer
@player_loop:   LDA     PM_YPOS,X
                CMP     #33
                BCS     :+              ; P0PF: Collision Player to Playfield (bitmask 0-3: colors 0-3)
                LDA     #0
                BEQ     @noColl
:               LDA     HPOSM0,X        ; P0PF: Collision Player to Playfield (bitmask 0-3: colors 0-3)
@noColl:        STA     vCollisionsPlayfield,X

                CPX     #PM_OBJECT::PHARAOH ; The Pharaoh has clothing as missile graphics, so check for this collision as well
                BEQ     :+              ; Collision Player to Player
                LDA     M0PL,X          ; Missile 0 to player collisions. There is no missile-to-missile collision register.
                AND     #COLLISION_PLAYER::PLAYER_A|COLLISION_PLAYER::PLAYER_B
                BEQ     :+              ; Collision Player to Player
                STA     vCollisionsPlayer
:
                LDA     P0PL,X          ; Collision Player to Player
                STA     vCollisionsPlayer,X
                DEX
                BNE     @player_loop

                LDA     HPOSM0          ; P0PF: Collision Player to Playfield (bitmask 0-3: colors 0-3)
                ORA     vCollisionsPlayfield+1
                STA     vCollisionsPlayfield+1

                STA     HITCLR          ; POKE with any number to clear all player/missile collision registers

                AND     #COLLISION_PLAYER::PLAYER_B|COLLISION_PLAYER::PHARAOH ; Pharao or Mummy collided with Playfield?
                BEQ     @noCollPha      ; => no
                LDA     vJoystickInput
                CMP     #(~JOYSTICK::J1_LEFT) & $FF
                BNE     @invertA
                LDA     #(~JOYSTICK::J1_RIGHT) & $FF
                BNE     @invertB        ; Invert left <-> right joystick directions
@invertA:       LDA     #(~JOYSTICK::J1_LEFT) & $FF
@invertB:       STA     vJoystickInput

@noCollPha:
                LDA     vJoystickInput
                BIT     vDemoMode
                BPL     :+
                LDA     PORTA           ; Reads or writes data from controller jacks one and two if BIT 2 of PACTL
:               STA     vJoystickInput

                BIT     vDemoMode
                BMI     :+
                LDA     RANDOM
                AND     #$1F            ; 1/32 (~twice per second)
                BNE     :+
                STA     STRIG0          ; Fire joystick button
:
                LDA     #<DLI_TOP
                STA     VDSLST          ; DISPLAY LIST NMI VECTOR
                LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BNE     @notTitle
                LDA     #<DLI_TITLE_ROOM
                STA     DLI_TOP::DLI_select_room+1
                BNE     @dliDone
@notTitle:      LDA     #<DLI_OTHER_ROOM
                STA     DLI_TOP::DLI_select_room+1
@dliDone:
                DEC     unused_decrement_VBL_CE ; Decremented during VBL IRQ, never read

                LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BNE     :+
                LDA     #$40
                BPL     @shot
:               EOR     #$FF
                CLC
                ADC     #ROOM_NUMBER::COUNT
                CLC
                ADC     SHOT_PROBABILITY
@shot:          STA     SHOT_COUNTER+3

                DEC     SHOT_SOUND_TIMER
                BPL     @draw_score
                LDA     SHOT_COUNTER+3
                STA     SHOT_SOUND_TIMER

                DEC     SNDF1_NoteDelay
                BPL     @loc_4631
                LDA     #$7F
                STA     SNDF1_NoteDelay

                LDA     SNDF1_NoteOffset
                CMP     #5
                BCS     @loc_4631
                BIT     GAME_LOOP_COUNTDOWN
                BMI     @loc_4631
                INC     SNDF1_NoteOffset

@loc_4631:
                LDY     #0
                BIT     SHOT_COUNTER+1
                BMI     :+
                INY
:               BIT     SHOT_COUNTER+2
                BMI     :+
                INY
:               STY     SNDF1_NoteIndex

                LDA     CURRENT_ROOM
                LSR     A
                LSR     A
                CLC
                ADC     SNDF1_NoteIndex
                CLC
                ADC     SNDF1_NoteOffset
                STA     SNDF1_NoteIndex

                LDA     SND_ZeroOneToggle
                BNE     @noZero
                LDA     #1
                BNE     @wasZero
@noZero:        LDA     #0
@wasZero:       STA     SND_ZeroOneToggle
                CLC
                ADC     SNDF1_NoteIndex
                TAY
                LDA     SND_MELODY,Y
                STA     AUDF1

                BIT     PLAYER_STATE
                BMI     @loc_4673
                BIT     GAME_LOOP_COUNTDOWN
                BPL     @loc_4677
@loc_4673:      LDA     #0
                BEQ     @loc_4679
@loc_4677:      LDA     #AUDC_POLYS_4|1
@loc_4679:      STA     AUDC1

@draw_score:
                LDY     #19
                LDA     SCORE
                AND     #$F
                ORA     #FONT_1C00::DIGIT_0|FONT_1C00::COLOR_2
                STA     STATUS_LINE,Y
                DEY
                LDA     SCORE
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                ORA     #FONT_1C00::DIGIT_0|FONT_1C00::COLOR_2
                STA     STATUS_LINE,Y
                DEY
                LDA     SCORE+1
                AND     #$F
                ORA     #FONT_1C00::DIGIT_0|FONT_1C00::COLOR_2
                STA     STATUS_LINE,Y
                DEY
                LDA     SCORE+1
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                ORA     #FONT_1C00::DIGIT_0|FONT_1C00::COLOR_2
                STA     STATUS_LINE,Y
                DEY
                LDA     #FONT_1C00::TREASURE___
                STA     STATUS_LINE,Y

                JMP     XITVBV          ; EXIT VERTICAL BLANK ROUTINE
.endproc


; =============== S U B R O U T I N E =======================================

.proc GAME_OVER
                ; reset the elevator state
                LDA     vELEVATOR_STATE
                BMI     :+
                LDA     #ELEVATOR_STATE::RESTORE
                STA     vELEVATOR_STATE
                JSR     DO_ELEVATOR
:
                LDA     #FONT_1C00::GAME_OVER_7
                STA     vTEMP1
                LDY     #6
:               STA     STATUS_LINE+8,Y
                DEC     vTEMP1
                LDA     vTEMP1
                DEY
                BPL     :-

                LDY     #SOUND_EFFECT::WINGED_AVENGER_SHOT
                LDX     #2
@loop:          JSR     SOUND_PLAY_on_CH4
                LDA     BULLET_MAX_DISTANCE,X
                BMI     :+
                LDA     #0
                STA     BULLET_MAX_DISTANCE,X
                JSR     DO_BULLET
:               DEX
                BPL     @loop

                LDA     CURRENT_ROOM
                STA     vTemp_CurrentRoom
                JMP     @cycle_all_rooms
; ---------------------------------------------------------------------------

@cycle_all_rooms_loop:
                LDA     CURRENT_ROOM
                CMP     vTemp_CurrentRoom
                BEQ     @loc_470D

@cycle_all_rooms:
                CLC
                ADC     #1
                AND     #$F
                STA     CURRENT_ROOM
                ASL     A
                CLC
                ADC     #>LEVEL_MAP_0
                STA     LEVEL_MAP_ADR+1

                LDA     #256-6
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
:               LDA     RTCLOK+2        ; 1/10s delay
                BNE     :-

                STA     ATRACT          ; ATTRACT MODE FLAG
                BEQ     @cycle_all_rooms_loop

@loc_470D:      LDA     #1
                STA     RTCLOK+2        ; REAL TIME CLOCK (60HZ OR 16.66666 MS)
:               LDA     RTCLOK+2        ; ~1s delay
                BNE     :-

                LDA     #>LEVEL_MAP_TITLE
                STA     LEVEL_MAP_ADR+1
                JMP     START           ; Restart game
.endproc


; =============== S U B R O U T I N E =======================================

.proc RESET_CTIA_POKEY
                LDY     #7
                LDA     #0
:               STA     AUDF1,Y
                STA     HPOSP0,Y        ; Horizontal position of player 0
                DEY
                BPL     :-
                RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc DO_ELEVATOR
                LDA     vELEVATOR_STATE
                BPL     :+
                RTS
:               CMP     #ELEVATOR_STATE::START
                BEQ     @elevator_start
                CMP     #ELEVATOR_STATE::RESTORE
                BEQ     @elevator_restore
                LDA     vELEVATOR_ROW_COUNTER
                BNE     @elevator_running

@elevator_restore:
                LDX     #4
                LDY     #41
@loop:          DEX
                LDA     saved_ELEVATOR_TILES_00_01_40_41,X ; Saved 2x2 characters from the level data
                STA     (ELEVATOR_PTR),Y ; Ptr to the 2x2 character position of the elevator
                DEY
                BMI     :+
                CPY     #39
                BNE     @loop
                LDY     #1
                BNE     @loop
:
                LDA     vELEVATOR_STATE
                CMP     #ELEVATOR_STATE::RUNNING
                BEQ     @elevator_running
                LDA     #ELEVATOR_STATE::START
                STA     vELEVATOR_STATE
                RTS
; ---------------------------------------------------------------------------

@elevator_running:
                DEC     vELEVATOR_Y
                DEC     vELEVATOR_Y
                LDA     vELEVATOR_Y
                CMP     vELEVATOR_TOP
                BCS     @loc_478D
                LDA     #ELEVATOR_STATE::RESTORE
                STA     vELEVATOR_STATE
                BNE     @elevator_restore
; ---------------------------------------------------------------------------

@elevator_start:
                LDA     vELEVATOR_BOTTOM
                STA     vELEVATOR_Y
                LDA     save_ELEVATOR_PTR
                STA     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                LDA     save_ELEVATOR_PTR+1
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator

                LDA     #ELEVATOR_STATE::RUNNING
                STA     vELEVATOR_STATE
                LDA     #7
                STA     vELEVATOR_ROW_COUNTER
                BNE     @loc_47A4
; ---------------------------------------------------------------------------

@loc_478D:
                DEC     vELEVATOR_ROW_COUNTER
                BPL     @loc_47D9
                LDA     #7
                STA     vELEVATOR_ROW_COUNTER

                LDA     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                SEC
                SBC     #40
                STA     ELEVATOR_PTR    ; Ptr to the 2x2 character position of the elevator
                LDA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
                SBC     #0
                STA     ELEVATOR_PTR+1  ; Ptr to the 2x2 character position of the elevator
@loc_47A4:
                LDX     #4
                LDY     #41
@loop2:         DEX
                LDA     #0
                STA     FONT_ELEVATOR_2,X
                STA     FONT_ELEVATOR_0,X

                LDA     (ELEVATOR_PTR),Y ; Ptr to the 2x2 character position of the elevator
                CMP     #TILE::BULLET_0
                BCC     @loc_47C6
                CMP     #TILE::BULLET_3
                BCS     @loc_47C6
                STY     vTEMP1
                SEC
                SBC     #TILE::BULLET_0
                TAY
                LDA     BULLET_SAVE_TILE,Y
                LDY     vTEMP1
@loc_47C6:      STA     saved_ELEVATOR_TILES_00_01_40_41,X ; Saved 2x2 characters from the level data

                LDA     ELEVATOR_TILES,X
                STA     (ELEVATOR_PTR),Y ; Ptr to the 2x2 character position of the elevator
                DEY
                BMI     @loc_47D9
                CPY     #39
                BNE     @loop2
                LDY     #1
                BNE     @loop2

@loc_47D9:
                LDA     #$FF
                STA     vTEMP2
                LDX     #3
@loop3:         LDA     saved_ELEVATOR_TILES_00_01_40_41,X ; Saved 2x2 characters from the level data
                CMP     #TILE::TRAP_0_left|TILE::ACTION_FLAG
                BNE     @loc_47F2
                CPX     #2
                BCC     :+
                LDA     #16
                BNE     @loc_47F0
:               LDA     #8
@loc_47F0:      STA     vTEMP2
@loc_47F2:      DEX
                BPL     @loop3

                LDA     #7
                STA     vTEMP3
                LDY     #15
@loop4:         TYA
                SEC
                SBC     vELEVATOR_ROW_COUNTER
                BPL     @loc_4806
@loc_4802:      LDX     #4
                BNE     @loc_480B
@loc_4806:      CMP     #3
                BCS     @loc_4802
                TAX
@loc_480B:      LDA     ELEVATOR_LEFT,X
                BIT     vTEMP2
                BMI     @loc_4821
                CPY     vTEMP2
                BCS     @loc_4821
                STY     vTEMP1
                LDY     vTEMP3
                BMI     @loc_481F
                ORA     FONT_TRAP_0_left,Y
@loc_481F:      LDY     vTEMP1
@loc_4821:      STA     FONT_ELEVATOR_0,Y

                LDA     ELEVATOR_RIGHT,X
                BIT     vTEMP2
                BMI     @loc_483A
                CPY     vTEMP2
                BCS     @loc_483A
                LDY     vTEMP3
                BMI     @loc_4838
                ORA     FONT_TRAP_0_right,Y
                DEC     vTEMP3
@loc_4838:      LDY     vTEMP1
@loc_483A:      STA     FONT_ELEVATOR_2,Y
                DEY
                BPL     @loop4
                RTS
.endproc

; ---------------------------------------------------------------------------
ELEVATOR_TILES: .BYTE TILE::ELEVATOR_0|TILE::ACTION_FLAG
                .BYTE TILE::ELEVATOR_1|TILE::ACTION_FLAG
                .BYTE TILE::ELEVATOR_2|TILE::ACTION_FLAG
                .BYTE TILE::ELEVATOR_3|TILE::ACTION_FLAG

ELEVATOR_LEFT:  .BYTE %01000000
                .BYTE %01010000
                .BYTE %00000101
                .BYTE %00000001
                .BYTE %00000000

ELEVATOR_RIGHT: .BYTE %00000001
                .BYTE %00000101
                .BYTE %01010000
                .BYTE %01000000
                .BYTE %00000000

FONT_TRAP_LSB:  .BYTE <FONT_TRAP_0_left
                .BYTE <FONT_TRAP_1
                .BYTE <FONT_TRAP_2
                .BYTE <FONT_TRAP_3

; =============== S U B R O U T I N E =======================================


.proc DO_FONT_ANIMATIONS
                DEC     FONT_ANIM_DELAY
                BMI     :+
                JMP     @trap_animation ; 4 Traps are possible
:
                LDA     #4
                STA     FONT_ANIM_DELAY

; Rope animation
@rope_animation:
                LDA     ROPE_ANIM_PHASE
                CLC
                ADC     #8
                CMP     #25
                BCC     :+
                LDA     #0
:               STA     ROPE_ANIM_PHASE
                TAX
                LDY     #0
:               LDA     FONT_ROPE_ANIM_0,X
                STA     FONT_BASE_1800_28_ROPE,Y
                INX
                INY
                CPY     #8
                BCC     :-

; Field animation
@field_animation:
                LDY     #7
@loop2:         LDA     FONT_FIELD_moveRight,Y
                LSR     A
                BCC     :+
                ORA     #%10000000
:               LSR     A
                BCC     :+
                ORA     #%10000000
:               STA     FONT_FIELD_moveRight,Y
                LDA     FONT_FIELD_moveLeft,Y
                ASL     A
                BCC     :+
                ORA     #%00000001
:               ASL     A
                BCC     :+
                ORA     #%00000001
:               STA     FONT_FIELD_moveLeft,Y
                DEY
                BPL     @loop2

; Door animation
@door_animation:                        ; 4 Doors are possible
                LDX     #3
@loop3:         LDA     FONT_ANIM_DOOR_POSITION,X
                CLC
                ADC     FONT_ANIM_DOOR_DIR,X
                BPL     :+
                LDA     #1
                STA     FONT_ANIM_DOOR_DIR,X
                LDA     #0
                BEQ     @loc_48C2

:               CMP     #8
                BCC     @loc_48C2
                LDA     #256-1
                STA     FONT_ANIM_DOOR_DIR,X
                LDA     #7
@loc_48C2:      STA     FONT_ANIM_DOOR_POSITION,X
                CLC
                ADC     FONT_ANIM_DOOR,X
                TAY
                LDA     FONT_ANIM_DOOR_DIR,X
                BPL     :+
                LDA     #%00000000
                BEQ     @loc_48D5
:               LDA     #%00000011
@loc_48D5:      STA     FONT_DOOR_0,Y
                DEX
                BPL     @loop3

; Trap animation
@trap_animation:
                LDX     #3              ; 4 Traps are possible
@trap_loop:
                DEC     TRAP_ANIM_SPEED,X
                BPL     @font_anim_next_
                LDA     #4
                STA     TRAP_ANIM_SPEED,X

                LDA     TRAP_ANIM_PHASE,X ; 'TRAP' is the original name
                BPL     @loc_4914

                LDA     TRAP_ANIM_DELAY,X
                BMI     @font_anim_next_
                DEC     TRAP_ANIM_DELAY,X
                PHP
                AND     #7                ; Volume
                ORA     #AUDC_POLYS_17
                STA     AUDC4
                PLP
                BPL     @font_anim_next_

                LDA     #0
                STA     TRAP_ANIM_PHASE,X ; 'TRAP' is the original name
                LDA     #16             ; 16 Bytes (2 characters x 8 pixel)
                STA     TRAP_ANIM_STEP,X
                LDA     RANDOM          ; Pick a random trap animation
                AND     #$C0
                STA     FONT_TRAP_ANIM_LSB,X

@font_anim_next_:
                JMP     @font_anim_next
; ---------------------------------------------------------------------------

@loc_4914:      CLC
                ADC     TRAP_ANIM_STEP,X
                BPL     @T20
                STA     TRAP_ANIM_PHASE,X ; 'TRAP' is the original name

                LDA     FONT_TRAP_LSB,X
                STA     pDEST_PTR
                LDA     #>FONT_TRAP_0_left
                STA     pDEST_PTR+1
                LDY     #15
:               LDA     FONT_TRAP_ACTIVE_0,Y
                STA     (pDEST_PTR),Y
                DEY
                BPL     :-
                JMP     @font_anim_next
; ---------------------------------------------------------------------------

@T20:           CMP     #3*16+1
                BCC     @T30             ; Last phase of the animation reached?
                LDA     #256-16
                STA     TRAP_ANIM_STEP,X ; Then reset to default state
                LDA     #3*16
@T30:           STA     TRAP_ANIM_PHASE,X ; 'TRAP' is the original name

                LDA     #0
                CLC
                ADC     FONT_TRAP_ANIM_LSB,X
                PHA
                LDA     #>FONT_TRAP_0_ANIM
                ADC     #0
                STA     sSRC_PTR+1
                PLA
                CLC
                ADC     TRAP_ANIM_PHASE,X ; 'TRAP' is the original name
                STA     sSRC_PTR
                BCC     :+
                INC     sSRC_PTR+1
:
                LDA     FONT_TRAP_LSB,X
                STA     pDEST_PTR
                LDA     #>FONT_TRAP_0_left
                STA     pDEST_PTR+1
                LDY     #15
:               LDA     (sSRC_PTR),Y
                STA     (pDEST_PTR),Y
                DEY
                BPL     :-

@font_anim_next:
                DEX
                BMI     :+
                JMP     @trap_loop
:               RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc DO_TRAPS
                PHA
                LDA     vCollisionsPlayfield+1,X
                AND     #COLLISION_PLAYFIELD::C3_TRAPS_KEYS_TREASURE ; used for Traps, Keys and Treasures – flickering
                BEQ     @noColl

                CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     :+

                LDY     #$FF			   ; Loose key
                STY     vKeyCollectedWhenPositive
                DEC     player_lives	   ; Loose life
                JSR     DRAW_TREASURES_LIVES
:
                LDA     #32
                STA     DEATH_ANIM,X
                TXA
                TAY
                JSR     SOUND_PLAY_on_CH4

@trapsDone:     PLA
                JMP     START::player_out_of_bounds

@noColl:        CPX     #PM_OBJECT::PLAYER ; the actual player
                BNE     @trapsDone

                PLA
                SEC
                SBC     #TILE::TRAP_0_left|TILE::ACTION_FLAG
                LSR     A
                TAY
                LDA     TRAP_ANIM_DELAY,Y
                BPL     :+
                LDA     TRAP_ANIM_PHASE,Y
                BPL     :+
                LDA     RANDOM
                AND     #$F
                ORA     #1
                STA     TRAP_ANIM_DELAY,Y
:               JMP     START::player_out_of_bounds
.endproc

; =============== S U B R O U T I N E =======================================

.proc DO_WINGED_AVENGER
                BIT     BULLET_MAX_DISTANCE
                BMI     @not_shot
                LDA     BULLET_XPOS
                SEC
                SBC     PM_XPOS+3
                CMP     #5
                BCS     @not_shot
                LDA     BULLET_YPOS
                SEC
                SBC     PM_YPOS+3
                CMP     #7
                BCS     @not_shot

                SED
                LDA     SCORE
                CLC
                ADC     #$25
                STA     SCORE
                LDA     SCORE+1
                ADC     #0
                STA     SCORE+1
                CLD

                LDY     #SOUND_EFFECT::WINGED_AVENGER_SHOT
                JSR     SOUND_PLAY_on_CH4
                STA     PM_XPOS+3       ; A=0, so hide the graphic

@not_shot:
                DEC     vWingedAvenger_Counter,X
                BMI     :+
                RTS
:
                LDA     #2
                STA     vWingedAvenger_Counter,X

                LDA     RANDOM
                AND     #$1F
                BNE     @no_y_change
                LDA     RANDOM
                AND     #1
                BNE     @move_up
                LDA     #256-1
@move_up:       STA     vBAT_YOffset

@no_y_change:
                BIT     vWingedAvenger_Attach_Flag
                BMI     @fly
                LDA     #0
                STA     vWingedAvenger_Hunt_Timer
                LDA     #256-3
                BMI     @fly_left		; Branch always

@fly:           LDA     RANDOM
                AND     #$1F
                BNE     @no_x_change
                LDA     RANDOM
                AND     #3
                SEC
                SBC     #2
                BNE     @fly_left
                LDA     #2
@fly_left:      STA     vBAT_XOffset

; PROTECTION: check the checksum routine
                LDY     START::PROT_CHECKSUM_C+1
                CPY     #$C3
                BEQ     @no_x_change
                LDA     RANDOM
                STA     PROT_PM_GRAPHICS_MSB_2

@no_x_change:   BIT     vWingedAvenger_Hunt_Timer
                BPL     @inTitle
                LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BEQ     @inTitle

                LDA     PM_YPOS,X
                ADC     #6
                CMP     PM_YPOS
                BCC     @yOffsetPos
                LDA     #256-2
                BMI     @yOffsetNeg
@yOffsetPos:    LDA     #2
@yOffsetNeg:    STA     vBAT_YOffset

@inTitle:
                LDA     vBAT_YOffset
                CLC
                ADC     PM_YPOS,X
                STA     PM_YPOS,X
                STA     pDEST_PTR

                LDA     vBAT_XOffset
                STA     vTEMP1
                CLC
                ADC     PM_XPOS,X
                STA     PM_XPOS,X
                STA     HPOSM0          ; Horizontal position of missile 0
                CLC
                ADC     #2
                STA     HPOSM3          ; Horizontal position of missile 3
                CLC
                ADC     #2
                STA     HPOSM2          ; Horizontal position of missile 2

                BIT     vTEMP1
                BMI     :+              ; Bat wing flap animation
                CLC
                ADC     #1
                STA     HPOSM0          ; Horizontal position of missile 0
:
                LDA     PLAYER_IMG_ANIM_PHASE,X ; Bat wing flap animation
                CLC
                ADC     PLAYER_IMG_ANIM_STEP,X
                BPL     @underflow
                LDA     #8
                STA     PLAYER_IMG_ANIM_STEP,X
                LDA     #(FONT_1C00::V_anim_1-FONT_1C00::V_anim_1)*8 ; Bat phase #0
                BEQ     @overflow		; Branch always

@underflow:     CMP     #(FONT_1C00::V_anim_5-FONT_1C00::V_anim_1)*8+1
                BCC     @overflow
                LDA     #256-8
                STA     PLAYER_IMG_ANIM_STEP,X
                LDA     #(FONT_1C00::V_anim_5-FONT_1C00::V_anim_1)*8 ; Bat phase #4

@overflow:      STA     PLAYER_IMG_ANIM_PHASE,X
                CLC
                ADC     #7
                TAX
                LDA     #>PM_GRAPHICS_MISSLES
                STA     pDEST_PTR+1

                LDY     #15
@loop:          LDA     FONT_BASE_1C00_18_WINGED_AVENGER,X
                BIT     vTEMP1
                BMI     :+              ; PM2 and PM3 are defined by the character
                ASL     A
                ASL     A               ; Bit 7 controls if the lower or upper 4 bits of the character are used
                ASL     A               ; flap down vs flap up
                ASL     A
:
                AND     #%11110000      ; PM2 and PM3 are defined by the character
                CPY     #8
                BCC     :+
                CPY     #10
                BCS     :+
                ORA     #%00000001      ; ROW #8 and #9 add PM0 as COLOR1
:
                STA     (pDEST_PTR),Y	; double height
                DEY
                STA     (pDEST_PTR),Y
                DEX
                DEY
                BPL     @loop
                RTS
.endproc

; =============== S U B R O U T I N E =======================================

.proc DO_CROWN_ARROW
                LDA     CROWN_ARROW_DURATION,X
                BPL     @checkTimer
                LDA     RANDOM
                AND     #$3F ; '?'
                BEQ     :+
@rts:           RTS

:               LDA     CURRENT_ROOM
                CMP     #ROOM_NUMBER::ENTRANCE_TITLE
                BEQ     @rts
                SEC
                SBC     #2
                SBC     CURRENT_ROOM,X
                BMI     @rts

                LDY     level
                LDA     RANDOM
                AND     BITMASK_4_bits,Y
                BNE     @rts

                LDA     #$7F
                STA     CROWN_ARROW_DURATION,X
                LDA     RANDOM
                AND     #1
                STA     CROWN_ARROW_type,X
                LDA     RANDOM
                AND     #1
                TAY
                LDA     cARROW_XOFFSET_TAB,Y
                STA     ARROW_XOFFSET,X
                INY
                LDA     ENTRY_START_YPOS,Y
                ADC     #8
                STA     CROWN_ARROW_LSB,X
                LDA     ENTRY_START_XPOS,Y
                STA     CROWN_ARROW_XPOS,X

@checkTimer:    DEC     CROWN_ARROW_COUNTER,X
                BPL     :+
                LDA     #5
                STA     CROWN_ARROW_COUNTER,X
:
                DEC     CROWN_ARROW_DURATION,X
                BMI     @crown_arrow_done
                LDA     vCollisionsPlayfield+1,X
                AND     #COLLISION_PLAYFIELD::C1_WALL|COLLISION_PLAYFIELD::C2_DOOR_ACCENT
                BNE     @crown_arrow_done

                LDA     CROWN_ARROW_DURATION,X
                CMP     #48
                BCS     @moreWait
                STA     AUDF4
                LDA     #AUDC_POLYS_4|2
                STA     AUDC4
                BMI     @durationDone	; Branch always

@moreWait:      LDA     #0
@durationDone:  STA     CROWN_ARROW_FLAG
                BMI     @flickerGold
                LDA     RANDOM
                ORA     #(HUE_GREY<<4)|3
                BNE     @flickerNot		; Branch always
@flickerGold:   LDA     #(HUE_GOLDORANGE<<4)|12
@flickerNot:    STA     PCOLR1,X        ; P1 COLOR

                LDA     vCollisionsPlayer+1,X
                BEQ     @noHitWithPlayer
                BIT     CROWN_ARROW_FLAG
                BPL     @crown_arrow_done
                AND     #3
                BEQ     @noHitWithPlayer

                LDA     CROWN_ARROW_type,X
                BNE     @isArrow
                INC     player_lives    ; Crown adds a life
                LDY     #SOUND_EFFECT::TREASURE_COLLECTED
                BNE     @treasureCol	; Branch always

@isArrow:       LDY     #SOUND_EFFECT::LOST_LIFE
                DEC     player_lives    ; Arrow removes a life
                LDA     #32
                STA     DEATH_ANIM

@treasureCol:   JSR     SOUND_PLAY_on_CH4
                JSR     DRAW_TREASURES_LIVES

@crown_arrow_done:
                LDA     #0
                STA     AUDC4
                LDA     #$FF
                STA     CROWN_ARROW_DURATION,X
                JSR     CLEAR_PM_GRAPHICS
                RTS
; ---------------------------------------------------------------------------

@noHitWithPlayer:
				; Move X-Position of the arrow
                LDA     CROWN_ARROW_XPOS,X
                BIT     CROWN_ARROW_FLAG
                BPL     :+
                LDY     CROWN_ARROW_type,X
                BEQ     :+
                CLC
                ADC     ARROW_XOFFSET,X
                STA     CROWN_ARROW_XPOS,X
:               STA     HPOSP1,X        ; Horizontal position of player 1

				; Play sound for arrow
                BIT     CROWN_ARROW_FLAG
                BMI     :+
                DEC     CROWN_ARROW_SOUND_DELAY,X
                BPL     :+
                LDA     #3
                STA     CROWN_ARROW_SOUND_DELAY,X
                INC     CROWN_ARROW_SOUND,X
                LDA     CROWN_ARROW_SOUND,X
                AND     #7
                TAY
                LDA     SND_EFFECT_GAME_END,Y
                STA     AUDF4
:
                BIT     CROWN_ARROW_FLAG
                BMI     :+
                LDA     CROWN_ARROW_SOUND_DELAY,X
                ORA     #AUDC_POLYS_NONE
                STA     AUDC4
:
                BIT     CROWN_ARROW_FLAG
                BMI     @select
                LDA     RANDOM
                AND     #1
                TAY                     ; 0 = Crown, 1 = Arrow
                LDA     #0
                BPL     @newOne  		; Branch always

@select:        LDA     CROWN_ARROW_type,X
                BEQ     :+              ; => crown
                LDA     #<(FONT_BASE_1C00_ARROW_LEFT-FONT_BASE_1C00_ARROW_RIGHT)
                LDY     ARROW_XOFFSET,X
                BMI     :+
                LDA     #<(FONT_BASE_1C00_ARROW_RIGHT-FONT_BASE_1C00_ARROW_RIGHT)
:
                LDY     CROWN_ARROW_type,X
@newOne:        CLC
                ADC     CROWN_ARROW_GRAPHICS_LSB,Y
                STA     sSRC_PTR
                LDA     PM_GRAPHICS_MSB,X
                STA     pDEST_PTR+1
                LDA     #>FONT_BASE_1C00
                STA     sSRC_PTR+1
                LDA     CROWN_ARROW_LSB,X
                STA     pDEST_PTR

                LDY     #7
@loop:          LDA     (sSRC_PTR),Y
                BIT     CROWN_ARROW_FLAG
                BMI     :+
                AND     RANDOM
:               STA     (pDEST_PTR),Y
                DEY
                BPL     @loop
                RTS
.endproc

; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Pharaoh's Curse 2nd part of the variables
; ---------------------------------------------------------------------------
BITMASK_4_bits: .BYTE %00001111,%00000111,%00000011,%00000001

STATUS_LINE:    .BYTE   8,  0,$3A,$44,$34,$33,$20,$20,$A8,  0,$E1,$4B,  8,  0,$3A,$44; 0
                .BYTE $34,$37,$20,$20,$A8,  0,$EF,$4B,  8,  0,$3A,$44,$34,$38,$20,$20; $10
                .BYTE $A8,  0,$F2,$4B,  8,  0,$3A,$44; $20
vTrasuresCollected:.BYTE $35,$30,$20,$20,$A8,  0,  8,$4C,  8,  0,$3A,$44,$35,$31,$20,$20
save_FONT_1800_5C_KEY:.BYTE $A8,  0,$12,$4C,  8,  0,$50,$4E,$44,$31,$20,$20,$A8,  0,$1C,$4C
save_FONT_1800_5B_GATE:.BYTE   0,  0,$4D,$44,$59,$20,$20,$20,$A0,  0,$BB,$4C,  0,  0,$48,$49
level:          .BYTE 0
vPasswordIndex: .BYTE 0
BULLET_TILE_LSB:.BYTE   0,  0,  0,  0
BULLET_TILE_MSB:.BYTE   0,  0,  0,  0
BULLET_SAVE_TILE:.BYTE   0,  0,  0,  0
BULLET_SAVE_SUBPIXEL_Y:.BYTE   0,  0,  0,  0
TRAP_ANIM_SPEED:.BYTE   0,  0,  0,  0
FONT_ANIM_DELAY:.BYTE 0
ROPE_ANIM_PHASE:.BYTE 0
vBAT_XOffset:   .BYTE 0
vBAT_YOffset:   .BYTE 0
vPHARAOH_IN_WALL:.BYTE 0
vPlayer_counter_c:.BYTE 0
vPlayer_counter_a:.BYTE 0
CURRENT_CH:     .BYTE   0,  0           ; only written to, unused
                .BYTE   0
vRandomSound:   .BYTE 0
vJoystickInput: .BYTE 0
SND_save_Y:     .BYTE 0
player_lives:   .BYTE 0
SOUND_TIMER:    .BYTE 0
                .BYTE   0
                .BYTE   0
                .BYTE   0
PLAYER_IMG_ANIM_PHASE:.BYTE    0,   0,   0
vCollisionsPlayfield:.BYTE   0,  0,  0,  0,  0
vCollisionsPlayer:.BYTE   0,  0,  0,  0,  0
vEnemyDelay:    .BYTE   0,  0,  0,  0
ENTRY_START_XPOS:.BYTE   0,  0,  0,  0,  0
ENTRY_START_YPOS:.BYTE   0,  0,  0,  0,  0
BULLET_SPEED:   .BYTE   0,  0,  0,  0
                .BYTE   0
                .BYTE   0
                .BYTE   0
                .BYTE   0
BULLET_MAX_DISTANCE:.BYTE   0,  0,  0,  0
                .BYTE   0
                .BYTE   0
                .BYTE   0
                .BYTE   0
vELEVATOR_TOP:  .BYTE 0
vELEVATOR_BOTTOM:.BYTE 0
vPlayerRunTimer:.BYTE   0,  0,  0,  0 ; How many cycles will the player run in one direction?
vPLAYER_DIRECTION:.BYTE DIRECTION::NONE,DIRECTION::NONE,DIRECTION::NONE,DIRECTION::NONE
DEATH_ANIM:     .BYTE $00,$00,$00,$00
                .BYTE   0,  0,  0,  0   ; unused
vWingedAvenger_Counter:.BYTE   0,  0,  0,  0
TILE_MID:       .BYTE   0,  0,  0
TILE_LEFT:      .BYTE   0,  0,  0
TILE_RIGHT:     .BYTE   0,  0,  0
ROPE_UNDER_PLAYER:.BYTE   0,  0,  0
CROWN_ARROW_FLAG:.BYTE 0
save_ELEVATOR_PTR:.WORD 0
vELEVATOR_ROW_COUNTER:.BYTE 0
saved_ELEVATOR_TILES_00_01_40_41:.BYTE $00,$00
                .BYTE $00,$00           ; Saved 2x2 characters from the level data
vAudio_AUDF1:   .BYTE 0

; ---------------------------------------------------------------------------
; Pharaoh's Curse end of the application
; ---------------------------------------------------------------------------
CODE_END:       .BYTE $20,$A3,$40,$20,$5D,  5,$A9,$FF,$85,$F5,$4C,$BE,  5,$55,  0,  0,$53,$45,$43,$54,$45,$52,$A0,  0,$90,  0,  0,  0,$54,$45,$4E,$54,$20,$20,$A8,  0,$F2,$4C,  0,  0,$4D,$50,$20,$3A,$4E,$45,$58,$54,$9B,$3B,$3A,$54,$31,$36,$20,$4C,$44,$41,$20,$41,$4C,$21,$20,$43,$4C

                .BYTE $43,$21,$20,$41,$44,$43,$20,$23,$38,$21,$20,$53,$54,$41,$20,$41,$4C,$9B,$3B,$20,$4A,$4D,$50,$20,$3A,$54,$31,$32,$9B,$9B,$9B,$9B,$3A,$54,$32,$30,$9B,$20,$43,$4D,$50,$20,$23,$33,$2A,$31,$36,$2B,$31,$9B,$20,$42,$43,$43,$20,$3A,$54,$33,$30,$9B,$20,$4C,$44,$41,$20
                .BYTE $23,$32,$35,$36,$2D,$31,$36,$9B,$20,$53,$54,$41,$20,$54,$59,$C8,$7D,$52,$50,$44,$49,$52,$2C,$58,$9B,$20,$4C,$44,$41,$20,$23,$33,$2A,$31,$36,$9B,$3A,$54,$33,$30,$20,$53,$54,$41,$20,$54,$52,$41,$50,$2C,$58,$9B,$9B,$20,$3B,$20,$20,$20,$A0,$D7,$D2,$C9,$D4,$C5,$A0
                .BYTE $9B,$9B,$20,$4C,$44,$41,$20,$23,$4C

                .END
