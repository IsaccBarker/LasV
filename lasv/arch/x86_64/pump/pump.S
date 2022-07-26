.code16

_start:
    call clear_screen
    call reset_cursor
    call set_screen_style_entry

    lea introduction_msg, %si
    call print_string

    hlt

introduction_msg:
    .asciz "Helo, pump!"

.include "../shared/screen.S"
.include "../shared/vga.S"

