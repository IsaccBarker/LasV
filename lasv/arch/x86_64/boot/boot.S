.code16

/* .set BOOT_IMAGE_ADDR, 0x7C00
.set BOOT_STACK_ADDR, 0x1800
.set SETUP_PHYS_ADDR, 0x7E00
.set SETUP_SEGMENT, 0x0800
.set SETUP_SEGMENT_OFFSET, 0x0000
.set MBR_CODE_AREA_2, 0x00E0 */

.set BOOT_IMAGE_ADDR,      0x7C00
.set SETUP_SEGMENT,        0x0800
.set SETUP_SEGMENT_OFFSET, 0x0000
.set MBR_CODE_AREA_2,      0x00E0
.set BOOT_PHYS_STACK_ADDR, 0x0700
.set MBR_TABLE_PHYS_ADDR,  0x2000 // Remember to replace elsewhere.
.set ENTRY_PHYS_ADDR,      0x7E00

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

	/* Clear screen and reset text mode cursor. */
	call clear_screen
	call reset_cursor
    call set_screen_style_boot

    /* TODO: Get the active parition and hope stage 2 is there. */
    call read_mbr_sector
    // call get_active_partition

	ljmp $0, $ENTRY_PHYS_ADDR

	/* Something went terribly wrong. * /
	jmp die */

die:
	hlt

.include "../shared/screen.S"
.include "../shared/vga.S"
.include "drive.S"
.include "mbr.S"

constrain_area_2:
    . = _start + 440

space_to_magic:
    . = _start + 510
    .byte 0x55
    .byte 0xaa

// . = _start + (SETUP_PHYS_ADDR - BOOT_IMAGE_ADDR)

