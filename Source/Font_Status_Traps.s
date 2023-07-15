; ---------------------------------------------------------------------------
; Pharaoh's Curse Status Line B/W Font, see FONT_1C00 enum
; ---------------------------------------------------------------------------
;.assert * = $1C00, error, "Status Line Font not at $1C00"
	.org $1C00

FONT_BASE_1C00:
    .byte %00111100
    .byte %01111110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %01111110
    .byte %00111100

    .byte %00011000
    .byte %00111000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00111100

    .byte %00111000
    .byte %01101100
    .byte %00001100
    .byte %00011000
    .byte %00110000
    .byte %01100000
    .byte %01111000
    .byte %01111100

    .byte %01111110
    .byte %01000110
    .byte %00001100
    .byte %00011000
    .byte %00001100
    .byte %00000110
    .byte %01001110
    .byte %01111100

    .byte %00011000
    .byte %00111100
    .byte %01101100
    .byte %01101100
    .byte %01111110
    .byte %00001100
    .byte %00001100
    .byte %00011100

    .byte %01111110
    .byte %01100010
    .byte %01100000
    .byte %01100000
    .byte %00011000
    .byte %00000110
    .byte %01100110
    .byte %01111100

    .byte %00111100
    .byte %01100110
    .byte %01100000
    .byte %01111100
    .byte %01100110
    .byte %01100110
    .byte %01111110
    .byte %00111100

    .byte %01111110
    .byte %01111110
    .byte %01001100
    .byte %00011100
    .byte %00111000
    .byte %00110000
    .byte %00110000
    .byte %00110000

    .byte %00111100
    .byte %01100110
    .byte %01111110
    .byte %00111100
    .byte %01100110
    .byte %01100110
    .byte %01111110
    .byte %00111100

    .byte %00111100
    .byte %01100110
    .byte %01100110
    .byte %01100110
    .byte %00111110
    .byte %00000110
    .byte %01100110
    .byte %00111100

FONT_BASE_1C00_CROWN:
    .byte %00000000
    .byte %00000000
    .byte %01011010
    .byte %10100101
    .byte %10100101
    .byte %01111110
    .byte %00111100
    .byte %01111110
FONT_BASE_1C00_PLAYER:
    .byte %00011100
    .byte %00011100
    .byte %00001000
    .byte %00111110
    .byte %01011101
    .byte %01010101
    .byte %00010100
    .byte %00110110

    .byte %00111000
    .byte %00111000
    .byte %01010100
    .byte %01010100
    .byte %01101100
    .byte %00111000
    .byte %00111000
    .byte %00101000

FONT_BASE_1C00_TREASURE___:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
FONT_BASE_1C00_TREASURE__X:
    .byte %00000000
    .byte %00000000
    .byte %00100000
    .byte %01110000
    .byte %01010000
    .byte %00100000
    .byte %00000000
    .byte %00000000
FONT_BASE_1C00_TREASURE_X_:
    .byte %00000000
    .byte %00000000
    .byte %00000010
    .byte %00000111
    .byte %00000101
    .byte %00000010
    .byte %00000000
    .byte %00000000
FONT_BASE_1C00_TREASURE_XX:
    .byte %00000000
    .byte %00000000
    .byte %00100010
    .byte %01110111
    .byte %01010101
    .byte %00100010
    .byte %00000000
    .byte %00000000

FONT_BASE_1C00_GAMEOVER:
    .byte %01111101
    .byte %01100101
    .byte %01100001
    .byte %01100001
    .byte %01101101
    .byte %01100101
    .byte %01111101
    .byte %00000000

    .byte %11110110
    .byte %00110101
    .byte %00110101
    .byte %11110100
    .byte %00110100
    .byte %00110100
    .byte %00110100
    .byte %00000000

    .byte %11101111
    .byte %01101100
    .byte %01101100
    .byte %01101110
    .byte %01101100
    .byte %01101100
    .byte %01101111
    .byte %00000000

    .byte %00011111
    .byte %00010011
    .byte %00010011
    .byte %00010011
    .byte %00010011
    .byte %00010011
    .byte %10011111
    .byte %00000000

    .byte %01001101
    .byte %01001101
    .byte %01001101
    .byte %01001101
    .byte %01101101
    .byte %01101101
    .byte %00111001
    .byte %00000000

    .byte %11100111
    .byte %10000100
    .byte %10000100
    .byte %11000111
    .byte %10000100
    .byte %10000100
    .byte %11110100
    .byte %00000000

    .byte %10000000
    .byte %10000000
    .byte %10000000
    .byte %10000000
    .byte %11000000
    .byte %11000000
    .byte %11000000
    .byte %00000000

FONT_BASE_1C00_18_WINGED_AVENGER:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11100111
    .byte %01100110
    .byte %00111100
    .byte %00011000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11100111
    .byte %01111110
    .byte %00011000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11100111
    .byte %00111100
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11111111
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %01111110
    .byte %11100111
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

FONT_BASE_1C00_ARROW_RIGHT:
    .byte %00000000
    .byte %00100000
    .byte %10010000
    .byte %01010000
    .byte %01111111
    .byte %01010000
    .byte %10010000
    .byte %00100000

FONT_BASE_1C00_ARROW_LEFT:
    .byte %00000000
    .byte %00000100
    .byte %00001001
    .byte %00001010
    .byte %11111110
    .byte %00001010
    .byte %00001001
    .byte %00000100

    .byte %00111110
    .byte %01001001
    .byte %01001001
    .byte %00110110
    .byte %00111110
    .byte %00101010
    .byte %00100010
    .byte %00000000

FONT_TRAP_0_ANIM:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %01010100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %00010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %00000100
    .byte %01010000
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %00010000
    .byte %00000101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000001
    .byte %00000100
    .byte %00010000
    .byte %01000011
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %00010000
    .byte %00000100
    .byte %11000001
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %00010011
    .byte %00010011
    .byte %01000011
    .byte %01000011
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11000100
    .byte %11000100
    .byte %11000001
    .byte %11000001
    .byte %01010101

FONT_TRAP_1_ANIM:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010111
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
    .byte %00000000
    .byte %01010000
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11000101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00001100
    .byte %01000011
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11001100
    .byte %11110001
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00001100
    .byte %00000011
    .byte %00000000
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11001100
    .byte %11110000
    .byte %11000001
    .byte %01010101

FONT_TRAP_2_ANIM:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010000
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00110000
    .byte %01001100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %00110000
    .byte %00111101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %00110000
    .byte %00110000
    .byte %00001100
    .byte %00001111
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11110000
    .byte %11110000
    .byte %00111100
    .byte %00111100
    .byte %01010101

    .byte %00111111
    .byte %11000011
    .byte %11000000
    .byte %11110000
    .byte %00111100
    .byte %00111111
    .byte %00000011
    .byte %01010101

    .byte %00000000
    .byte %11000000
    .byte %11110000
    .byte %11110000
    .byte %11111100
    .byte %11111100
    .byte %11111100
    .byte %01010101

FONT_TRAP_3_ANIM:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00110000
    .byte %11000000
    .byte %00010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %00001100
    .byte %00000000
    .byte %00000000
    .byte %00010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %00110000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010101
    .byte %01010101

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00001100
    .byte %00000011
    .byte %01010100
    .byte %01010101
