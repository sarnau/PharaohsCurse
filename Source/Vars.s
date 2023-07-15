; ---------------------------------------------------------------------------
; Page Zero
; BASIC and Floating Point
; Used by Pharaoh's Curse for variables
; ---------------------------------------------------------------------------
    .zeropage
    .org $CB
SCORE:                      .res 2 ; Score in BCD format with digits in reverse order (4321)
unused_00_CD:               .res 1 ; Erased at launch, never read
unused_decrement_VBL_CE:    .res 1 ; Decremented during VBL IRQ, never read
                            .res 5 ; unused
XLEVELPTR:                  .res 2 ; Ptr to additional level data ($1E0 bytes after the beginning)
                            .res 2 ; unused
SND_PTR:                    .res 2 ; Ptr to frequency table when playing a sound effect
vTEMP1:                     .res 1
vTEMP2:                     .res 1
vTEMP3:                     .res 1
ELEVATOR_PTR:               .res 2 ; Ptr to the current elevator position on the screen
                            .res 5 ; unused
MULT_TMP:                   .res 2 ; 16-bit multiplication value
pDEST_PTR:                  .res 2 ; generic destination ptr
sSRC_PTR:                   .res 2 ; generic source ptr
                            .res 4 ; unused
vAudio_AUDF2_base:          .res 1
vAudio_AUDF3:               .res 1
vAudio_AUDC2_AUDC3:         .res 1
vAudio_AUDF2_60Hz_countDown: .res 1
vAudio_AUDC1:               .res 1
vWingedAvenger_Hunt_Timer:  .res 1
DOUBLE_YSPEED_FLAG:         .res 1
vPLAYER_STATE:              .res 1 ; PLAYER_STATE
SUBPIXEL_X:                 .res 1
SUBPIXEL_Y:                 .res 1
vELEVATOR_X:                .res 1
vELEVATOR_Y:                .res 1
vAudio_AUDC4:               .res 1
CURRENT_ROOM:               .res 1 ; the current room the player is in
vTemp_CurrentRoom:          .res 1 ; During game over, when cycling through levels
