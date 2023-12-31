; ---------------------------------------------------------------------------
; Pharaoh's Curse Main Font, see TILE enum
; ---------------------------------------------------------------------------
	.res $1800 - * ; we need to align the PC to this address
.assert * = $1800, error, "Main Font not at $1800"

FONT_MAIN:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010100
    .byte %01010000
    .byte %01000000

    .byte %01010101
    .byte %01010100
    .byte %01010000
    .byte %01000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %00000101
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000101
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000101
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000101

    .byte %00000001
    .byte %00000001
    .byte %00000001
    .byte %00000001
    .byte %00000100
    .byte %00000100
    .byte %00000100
    .byte %00000100

    .byte %01010101
    .byte %00010101
    .byte %00000101
    .byte %00000001
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00010101
    .byte %00000101
    .byte %00000001

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %00000000

    .byte %00000000
    .byte %01010000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010000
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010000

    .byte %01000000
    .byte %01010000
    .byte %01010100
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010000
    .byte %01010100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %00000101
    .byte %00010101
    .byte %01010101

    .byte %00000001
    .byte %00000101
    .byte %00010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

FONT_MAIN_28_ROPE:
    .byte %00000100
    .byte %00000001
    .byte %00000100
    .byte %00000001
    .byte %00000100
    .byte %00000001
    .byte %00000100
    .byte %00000001

    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010

    .byte %10000000
    .byte %10101010
    .byte %10101000
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010

    .byte %10001010
    .byte %00100010
    .byte %10001010
    .byte %00100010
    .byte %10001010
    .byte %00100010
    .byte %10001010
    .byte %00100010

    .byte %10001000
    .byte %10100010
    .byte %10001000
    .byte %10100010
    .byte %10001000
    .byte %10100010
    .byte %10001000
    .byte %10100010

    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10101000
    .byte %10001010
    .byte %10000000
    .byte %00000000

    .byte %10101000
    .byte %00101010
    .byte %00001010
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %10101010
    .byte %00001010
    .byte %00000010
    .byte %00000010
    .byte %00000000

    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10001010
    .byte %00101000
    .byte %10100000
    .byte %10000000

    .byte %10001010
    .byte %00101010
    .byte %10101000
    .byte %10100000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01100101
    .byte %10001001
    .byte %00100010
    .byte %10001000
    .byte %00100010
    .byte %10001000
    .byte %00100010

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01100110
    .byte %10011001
    .byte %00100010
    .byte %10001000
    .byte %00100010

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01100101
    .byte %10011001
    .byte %00100110

    .byte %01010101
    .byte %01010110
    .byte %01011000
    .byte %01010010
    .byte %01011000
    .byte %01010010
    .byte %01001000
    .byte %00100010

    .byte %10101010
    .byte %10100010
    .byte %10000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %10101010
    .byte %00101010
    .byte %00001000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %10000000
    .byte %10100000
    .byte %10100000
    .byte %00100000
    .byte %10101000
    .byte %00101000
    .byte %10001010
    .byte %00100010

    .byte %00000010
    .byte %00000010
    .byte %00001000
    .byte %00001010
    .byte %00101000
    .byte %00101010
    .byte %10101000
    .byte %10100010

    .byte %10000000
    .byte %10100000
    .byte %10100000
    .byte %00101000
    .byte %10001010
    .byte %00101010
    .byte %10101000
    .byte %10100000

    .byte %00000000
    .byte %00000010
    .byte %00001010
    .byte %00101010
    .byte %10101000
    .byte %00101010
    .byte %00001000
    .byte %00000010

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %00100110
    .byte %00001100

    .byte %01010101
    .byte %01111111
    .byte %01110101
    .byte %01110111
    .byte %01110111
    .byte %01110101
    .byte %01111111
    .byte %01010101

    .byte %01010101
    .byte %11110101
    .byte %01010101
    .byte %11111101
    .byte %01011101
    .byte %01011101
    .byte %11111101
    .byte %01010101

    .byte %01010101
    .byte %11111101
    .byte %01011101
    .byte %11011101
    .byte %11011101
    .byte %01011101
    .byte %11111101
    .byte %01010101

    .byte %01010111
    .byte %01010111
    .byte %11111111
    .byte %11010111
    .byte %11010111
    .byte %01011111
    .byte %01110101
    .byte %01110101

    .byte %11011111
    .byte %01011101
    .byte %11111101
    .byte %11010101
    .byte %11010101
    .byte %11110101
    .byte %01011101
    .byte %01011111

    .byte %01010111
    .byte %01011101
    .byte %01010111
    .byte %01010101
    .byte %01011101
    .byte %01110101
    .byte %01110101
    .byte %01011111

    .byte %11110101
    .byte %01010101
    .byte %11110101
    .byte %01011101
    .byte %01010111
    .byte %01011101
    .byte %01110101
    .byte %11010101

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01110111
    .byte %11111111

    .byte %01010101
    .byte %01010111
    .byte %01010101
    .byte %01010111
    .byte %01010101
    .byte %01010111
    .byte %01010101
    .byte %01010111

    .byte %11010101
    .byte %01010101
    .byte %11010101
    .byte %01010101
    .byte %11010101
    .byte %01010101
    .byte %11010101
    .byte %01010101

    .byte %01110111
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %11011101

    .byte %01110101
    .byte %01011101
    .byte %01010111
    .byte %01111111
    .byte %11010111
    .byte %01011111
    .byte %01110101
    .byte %01010101

    .byte %01011101
    .byte %01110101
    .byte %11010101
    .byte %11111101
    .byte %11010111
    .byte %11110101
    .byte %01011101
    .byte %01010101

FONT_FIELD_moveRight:
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000

FONT_FIELD_moveLeft:
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000

    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000
    .byte %00001010
    .byte %10100000

    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %00101010
    .byte %00001100
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01010101
    .byte %01110111
    .byte %11111111

    .byte %11110101
    .byte %11111101
    .byte %11110101
    .byte %11111101
    .byte %11110101
    .byte %11111101
    .byte %11110101
    .byte %11111101

    .byte %01111111
    .byte %01011111
    .byte %01111111
    .byte %01011111
    .byte %01111111
    .byte %01011111
    .byte %01111111
    .byte %01011111

    .byte %11111101
    .byte %11110101
    .byte %11111101
    .byte %11110101
    .byte %11111101
    .byte %11110101
    .byte %11111111
    .byte %11111111

    .byte %01111111
    .byte %01011111
    .byte %01111111
    .byte %01011111
    .byte %01111111
    .byte %01011111
    .byte %11111111
    .byte %11111111

    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00001000
    .byte %00001000
    .byte %00001000
    .byte %00001000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101

    .byte %10001111
    .byte %00100011
    .byte %10001111
    .byte %00100011
    .byte %10001111
    .byte %00100011
    .byte %10001111
    .byte %00100011

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %10100101
    .byte %01010111

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010101
    .byte %01010111

    .byte %11110010
    .byte %11001010
    .byte %11110010
    .byte %11001010
    .byte %11110010
    .byte %11001010
    .byte %11110010
    .byte %11001010

FONT_GATE:
    .byte %11001100
    .byte %11001100
    .byte %11001100
    .byte %11001100
    .byte %11001100
    .byte %11001100
    .byte %11001100
    .byte %11001100

FONT_KEY:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00111100
    .byte %11000011
    .byte %00111100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11111111
    .byte %00110011

FONT_TREASURE:
    .byte %11111111
    .byte %00111111
    .byte %11001111
    .byte %11000011
    .byte %00110011
    .byte %00001111
    .byte %00000011
    .byte %00111111

    .byte %11111111
    .byte %11111100
    .byte %11110011
    .byte %11000011
    .byte %11001100
    .byte %11110000
    .byte %11000000
    .byte %11111100

FONT_TRAP_0_left:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010101
    .byte %01010101

FONT_TRAP_0_right:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010101
    .byte %01010101

FONT_TRAP_1:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010101
    .byte %01010101

FONT_TRAP_1_right:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010101
    .byte %01010101

FONT_TRAP_2:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010101
    .byte %01010101

FONT_TRAP_2_right:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010101
    .byte %01010101

FONT_TRAP_3:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010101
    .byte %01010101

FONT_TRAP_3_right:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010101
    .byte %01010101

FONT_MAIN_68_BULLET:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_ELEVATOR_0:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_ELEVATOR_1:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_ELEVATOR_2:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_ELEVATOR_3:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_DOOR_0:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_DOOR_1:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_DOOR_2:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_DOOR_3:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_ROPE_ANIM_0:
    .byte %00000100
    .byte %00000001
    .byte %00000100
    .byte %00000001
    .byte %00001100
    .byte %00000001
    .byte %00000100
    .byte %00000011

FONT_ROPE_ANIM_1:
    .byte %00000001
    .byte %00000100
    .byte %00000001
    .byte %00001100
    .byte %00000001
    .byte %00000100
    .byte %00000011
    .byte %00000100

FONT_ROPE_ANIM_2:
    .byte %00000100
    .byte %00000001
    .byte %00001100
    .byte %00000001
    .byte %00000100
    .byte %00000011
    .byte %00000100
    .byte %00000001

FONT_ROPE_ANIM_3:
    .byte %00000001
    .byte %00001100
    .byte %00000001
    .byte %00000100
    .byte %00000011
    .byte %00000100
    .byte %00000001
    .byte %00000100

FONT_TRAP_ACTIVE_0:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010101
    .byte %01010101

FONT_TRAP_ACTIVE_1:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %01010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %01010101
    .byte %01010101
