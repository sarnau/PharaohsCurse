; ---------------------------------------------------------------------------
; Pharaoh's Curse Title Screen Font
; ---------------------------------------------------------------------------
	.res $4000 - * ; we need to align the PC to this address
.assert * = $4000, error, "Title font not at $4000"

FONT_TITLE:
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %11000000
    .byte %11110000
    .byte %11111100
    .byte %11101100
    .byte %11101100
    .byte %11101100
    .byte %11101100
    .byte %11101100

    .byte %00111111
    .byte %11111011
    .byte %11101011
    .byte %11111011
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011

    .byte %00111111
    .byte %11111011
    .byte %11101011
    .byte %11111111
    .byte %11000011
    .byte %00000000
    .byte %00000000
    .byte %00001010

    .byte %11000000
    .byte %11110000
    .byte %10111100
    .byte %10101100
    .byte %10101100
    .byte %10111100
    .byte %11110000
    .byte %11000000

    .byte %00001111
    .byte %00111111
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00111100
    .byte %11101011

    .byte %00000011
    .byte %00001110
    .byte %00111010
    .byte %00111010
    .byte %11101111
    .byte %11111100
    .byte %11110000
    .byte %11110000

    .byte %11111100
    .byte %10101111
    .byte %11111111
    .byte %11000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %11000000
    .byte %10110000
    .byte %00101100
    .byte %00001011
    .byte %00001111
    .byte %00111111
    .byte %11111011

    .byte %00001111
    .byte %00111110
    .byte %00111010
    .byte %00111010
    .byte %00111010
    .byte %00111110
    .byte %00001111
    .byte %00000000

    .byte %11111111
    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %00000000
    .byte %11000000
    .byte %10110000
    .byte %11111100

    .byte %00000000
    .byte %10110000
    .byte %10110000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %11111111
    .byte %00111011
    .byte %00001110
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111011

    .byte %11111111
    .byte %11101011
    .byte %11000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %11111100
    .byte %11101100
    .byte %11101100
    .byte %11101100
    .byte %11111100
    .byte %00111100
    .byte %00001100
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %00000100
    .byte %01010100
    .byte %01000000
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %00000100
    .byte %00010100
    .byte %00000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %01010100
    .byte %00000100
    .byte %00000100

    .byte %00111111
    .byte %00111011
    .byte %00111011
    .byte %00111011
    .byte %00111111
    .byte %00111100
    .byte %00110000
    .byte %00000000

    .byte %00111010
    .byte %00001110
    .byte %00000011
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000011
    .byte %00000000

    .byte %11000000
    .byte %11000000
    .byte %11110000
    .byte %10110000
    .byte %11110000
    .byte %11000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010100
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010100
    .byte %00000100
    .byte %00000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010000
    .byte %00000000
    .byte %00010000
    .byte %00000000

    .byte %11100000
    .byte %11110000
    .byte %00111000
    .byte %00111110
    .byte %00001111
    .byte %00000011
    .byte %00000000
    .byte %00000000

    .byte %00000011
    .byte %00001111
    .byte %00111110
    .byte %11111010
    .byte %10101010
    .byte %10111111
    .byte %11110000
    .byte %00000000

    .byte %10101111
    .byte %10101100
    .byte %10111100
    .byte %11110000
    .byte %11000000
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00001111
    .byte %00111110
    .byte %00001111
    .byte %00000000
    .byte %00000000

    .byte %00000101
    .byte %00010000
    .byte %01000101
    .byte %01000100
    .byte %01000100
    .byte %01000101
    .byte %00010000
    .byte %00000101

    .byte %01000000
    .byte %00010000
    .byte %01000100
    .byte %00000100
    .byte %00000100
    .byte %01000100
    .byte %00010000
    .byte %01000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010100
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010100
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000000
    .byte %01000000
    .byte %01000000
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010000
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %01010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000000
    .byte %01010000
    .byte %01000000
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000000
    .byte %01010000
    .byte %01000000
    .byte %01000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000000
    .byte %01000001
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %01010100
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000100
    .byte %00000100
    .byte %00000100
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01000100
    .byte %01010000
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01000000
    .byte %01000000
    .byte %01000000
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01010100
    .byte %01010100
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000000
    .byte %01010100
    .byte %01010100
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %01010100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010100
    .byte %01000000
    .byte %01000000

    .byte %11110000
    .byte %11111100
    .byte %11101100
    .byte %11101100
    .byte %11111100
    .byte %11110000
    .byte %11000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %01000100
    .byte %01010000
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00010100
    .byte %01000000
    .byte %00010000
    .byte %00000100
    .byte %01010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01010100
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %00010000

    .byte %00000000
    .byte %00000000
    .byte %00000100
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %01000100
    .byte %00010000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %01010100
    .byte %01010100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %00010000
    .byte %01000100
    .byte %01000100

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %01000100
    .byte %01000100
    .byte %01010100
    .byte %00000100
    .byte %01010100

    .byte %11111100
    .byte %00001111
    .byte %11000011
    .byte %00000000
    .byte %11000000
    .byte %11111111
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %11000000
    .byte %11110000
    .byte %10111100
    .byte %10111100
    .byte %11110000
    .byte %00000000
    .byte %00000000

    .byte %00111010
    .byte %00111010
    .byte %00111110
    .byte %00111111
    .byte %00001111
    .byte %00000000
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %11000000
    .byte %11100011
    .byte %11111111
    .byte %00000000
    .byte %00000000

    .byte %00000000
    .byte %00110000
    .byte %00001100
    .byte %00111100
    .byte %11110000
    .byte %11000000
    .byte %00000000
    .byte %00000000

    .byte %10000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
