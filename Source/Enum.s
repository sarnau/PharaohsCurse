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
    DIGIT_5     = $05	; Digits 0-9
    DIGIT_6     = $06
    DIGIT_7     = $07
    DIGIT_8     = $08
    DIGIT_9     = $09
    CROWN       = $0A	; Crown, which can be collected
    PLAYER      = $0B	; Player in the status line
    SKULL       = $0C	; unused
    TREASURE___ = $0D
    TREASURE__X = $0E	; 0-2 Treasures (2 per character) for the status line
    TREASURE_X_ = $0F
    TREASURE_XX = $10
    GAME_OVER_1 = $11
    GAME_OVER_2 = $12
    GAME_OVER_3 = $13
    GAME_OVER_4 = $14	; "GAME OVER" text as font for the status line
    GAME_OVER_5 = $15
    GAME_OVER_6 = $16
    GAME_OVER_7 = $17
    V_anim_1    = $18	; Winged Avenger images
    V_anim_2    = $19
    V_anim_3    = $1A
    V_anim_4    = $1B
    V_anim_5    = $1C
    ARROW_RIGHT = $1D	; Arrow, which will shoot the player
    ARROW_LEFT  = $1E	; Arrow, which will shoot the player
    ALT_CROWN   = $1F	; unused

    COLOR_1     = $40
    COLOR_2     = $80
    COLOR_3     = $C0
.endenum

; ---------------------------------------------------------------------------

.enum LEVEL_EXIT
    NO     = 0
    LEFT   = 1
    RIGHT  = 2	; which exit was chosen in the level
    TOP    = 3
    BOTTOM = 4
.endenum

; ---------------------------------------------------------------------------

.enum JOYSTICK
    J1_UP    = $01	; Joystick #1 directions
    J1_DOWN  = $02
    J1_LEFT  = $04
    J1_RIGHT = $08

    J2_UP    = $10	; Joystick #2 is unused
    J2_DOWN  = $20
    J2_LEFT  = $40
    J2_RIGHT = $80
.endenum

; ---------------------------------------------------------------------------

; In what kind of motion is the player
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

; PROTECTION: Patches for the code
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

; The different sound effects
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
