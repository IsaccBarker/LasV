.code16

.set MBR_TABLE_PARTITION_OFFSET,    0x01BE
.set MBR_TABLE_ENTRY_LEN,           0x0010
.set MBR_TABLE_LEN,                 0x0004

.text
    .global get_active_partition

; Holy shit it works!
get_active_partition:
    mov (0x7C00 + 0x01BE), %bl              ; Start/iterator.
    mov $0x80, %bh                          ; Boot signature.
    mov $0x01FE, %al                        ; Final address.

.loop:
    cmp %bl, %bh                            ; Check if bootable.
    je .ok

    add $0x10, %bl                          ; Move to next entry and see if we aren't at the end.
    cmp %bl, %al
    jge .loop

    jmp .die                                ; If we've looked through all four to no avail then we error.

.die:
    call bootable_partitions_failure

.ok:
    /* Load the right information into the right registers. */
    /* add $0x02, %di
    mov (%di), %ax

    jmp . */

    /* add $0x01, %bl
    mov %bl, %cl
    shrb $0x2, %cl */

    /* Cylinder number. Technically, this is stored as a 10 bit number
     * in the table with the upper two bits of the second byte of the
     * CHS (the third byte being the rest obviously), but we are fitting
     * it into a 8 bit register for the BIOS interupt, so it doesn't
     * really matter.
     * TODO: Does it matter? */
    /* add $0x01, %bl
    mov %bl, %ch */

    ret

bootable_partitions_failure:
    call set_screen_style_error

    lea .no_bootable_partitions, %si
    call print_string

    hlt

.no_bootable_partitions:
    .asciz "pt: nb"

