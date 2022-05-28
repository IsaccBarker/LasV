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
    cli

	xorw %ax, %ax
	movw %ax, %ss
	movw %ax, %ds
	movw %ax, %es

	movw $BOOT_STACK_ADDR, %sp

	/* Save disk drive. */

	movb %dl, boot_params_disk_drive

	/* Clear screen and reset text mode cursor. */
	call clear_screen
	call reset_cursor

	lea initializing_msg, %si
	call print_string

	/* Load the Primary Volume Descriptor into memory. */
	call read_pvd

 	/* Load BOOT directory. */
	lea setup_id, %ax
	movw $SETUP_SEGMENT, %di
	call read_entry

	ljmp $0, $SETUP_PHYS_ADDR

	/* Something went terribly wrong. */
	jmp die

die:
	hlt

boot_params:

/* This struct contains boot relevant informations */

boot_params_disk_drive: 
	.byte   0x0

a20_error_msg:
	.asciz  "Could not enable A20 line"

initializing_msg:
    .asciz "Bootstrapping stage 2... "

.include "../shared/screen.S"
.include "../shared/vga.S"
.include "drive.S"

setup_id: .asciz "/BOOT/SETUP.BIN;1"
    . = _start + 510
    .byte 0x55
    .byte 0xaa

