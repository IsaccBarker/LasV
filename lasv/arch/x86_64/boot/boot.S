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
    call clear_screen
    call reset_cursor

    lea initializing_msg, %si
    call print_string

    mov $SETUP_PHYS_ADDR, %bx
    call disk_read

    lea stage2_load_done_msg, %si
    call print_string

    jmp SETUP_PHYS_ADDR

    call die

die:
    hlt

initializing_msg:
    .asciz "Bootstrapping stage 2... "

stage2_load_done_msg:
    .asciz "Sucessfully read stage 2. Jumping..."

.include "../shared/screen.S"
.include "../shared/vga.S"
.include "drive.S"

setup_id: .asciz "/BOOT/SETUP.BIN;1"
    . = _start + 510
    .byte 0x55
    .byte 0xaa

