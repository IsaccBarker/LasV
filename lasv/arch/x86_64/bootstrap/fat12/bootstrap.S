.code16

# Skip over the parts of the BPB before the bootstrap code area.
# https://wiki.osdev.org/FAT#BPB_.28BIOS_Parameter_Block.29

_start:
    .long 0x90909090
    call clear_screen
    call reset_cursor
    call set_screen_style_entry

    lea introduction_msg, %si
    call print_string

    hlt

introduction_msg:
    .asciz "Hello, bootstrap!"

.include "../../shared/screen.S"
.include "../../shared/vga.S"

