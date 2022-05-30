.code16

.text
    .global _setup32

_setup32:
    call clear_screen
    call reset_cursor
    call set_screen_style_entry

    lea f, %si
    call print_string

    hlt

f:
    .asciz "LasV... the V doesn't stand for five!"

.include "../shared/screen.S"
.include "../shared/vga.S"

setup_id:
    . = _setup32 + 512

