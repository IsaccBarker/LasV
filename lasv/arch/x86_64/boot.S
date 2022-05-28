.code16

.set BOOT_IMAGE_ADDR, 0x7C00
.set BOOT_STACK_ADDR, 0x1800
.set SETUP_PHYS_ADDR, 0x8000
.set SETUP_SEGMENT, 0x0800
.set SETUP_SEGMENT_OFFSET, 0x0000

.text
    .global _start

_start:
    ljmp $0, $_setup16

_setup16:
    call reset_hard_drive
    call clear_screen
    call reset_cursor

    lea initializing_msg, %si
    call print_string

    call die

die:
    hlt

initializing_msg:
    .asciz  "Initializing LasV (Lassa Mammarenavirus)..."

.include "screen.S"
.include "vga.S"

setup_id: .asciz "/BOOT/SETUP.BIN;1"
    . = _start + 510
    .byte 0x55
    .byte 0xaa

