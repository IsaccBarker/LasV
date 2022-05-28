.code16

.section .text

disk_read:
	/* store all register values */
	pusha
	push %dx

	/* Prepare data for reading the disk:
        al = number of sectors to read (1 - 128)
        ch = track/cylinder number
        dh = head number
        cl = sector number
    */
	mov $0x02, %ah
	mov %dh, %al
	mov $0x00, %ch
	mov $0x00, %dh
	mov $0x02, %cl
	int $0x13

	/* In case of read error show the message about it. */
	jc disk_read_error

	/* Check if we read expected count of sectors if not,
        show the message with error. */
	pop %dx
	cmp %al, %dh
	jne disk_read_error

	/* Restore register values and ret. */
	popa
	ret

disk_read_error:
    lea disk_read_error_msg, %si
	call print_string
	hlt

disk_read_error_msg:
    .asciz "Failed to read disk! "

