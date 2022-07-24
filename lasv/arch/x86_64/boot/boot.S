.code16

.set BOOT_IMAGE_ADDR,           0x7C00
.set SETUP_SEGMENT,             0x0800
.set SETUP_SEGMENT_OFFSET,      0x0000
.set BOOT_PHYS_STACK_ADDR,      0x0700
.set ENTRY_PHYS_ADDR,           0x7E00

.text
    .global _start

_start:
    ljmp $0, $_setup16

_setup16:
    cli

    xorw %ax, %ax
    movw %ax, %ss
    movw %ax, %ds
    movw %ax, %es

    movw $BOOT_PHYS_STACK_ADDR, %sp

    # call clear_screen
    # call reset_cursor
    call set_screen_style_boot

    # call check_lba_support
    call get_per_values

    call get_active_partition               # TODO: Get the active parition and hope stage 2 is there.
    call load_active_partition_metadata
    call read_active_partition

    hlt

    ljmp $0, $ENTRY_PHYS_ADDR

    hlt                                     # Something went terribly wrong.

.include "../shared/screen.S"
.include "../shared/vga.S"
.include "drive.S"
.include "mbr.S"
.include "fat.S"

.constrain_area_2:
    . = _start + 440

.space_to_magic:
    . = _start + 510
    .byte 0x55
    .byte 0xaa

// . = _start + (SETUP_PHYS_ADDR - BOOT_IMAGE_ADDR)

