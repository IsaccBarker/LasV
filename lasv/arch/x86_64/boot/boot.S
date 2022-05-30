.code16

.set BOOT_IMAGE_ADDR, 0x7C00
.set BOOT_STACK_ADDR, 0x1800
.set SETUP_PHYS_ADDR, 0x8000
.set SETUP_SEGMENT, 0x0800
.set SETUP_SEGMENT_OFFSET, 0x0000

.text
    .global _start
    .global lasv_find_and_boot_elf

_start:
    ljmp $0, $_setup16

_setup16:
    cli

	xorw %ax, %ax
	movw %ax, %ss
	movw %ax, %ds
	movw %ax, %es

	movw $BOOT_STACK_ADDR, %sp

	/* Clear screen and reset text mode cursor. */
	call clear_screen
	call reset_cursor

    call lasv_find_and_boot_elf

    /* call load_sector2

	ljmp $0, $SETUP_PHYS_ADDR

	/* Something went terribly wrong. * /
	jmp die */

die:
	hlt

.include "../shared/screen.S"
.include "../shared/vga.S"

setup_id:
    . = _start + 510
    .byte 0x55
    .byte 0xaa

// . = _start + (SETUP_PHYS_ADDR - BOOT_IMAGE_ADDR)

