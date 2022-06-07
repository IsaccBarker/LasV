.code16

.set MBR_TABLE_PARTITION_OFFSET,    0x01BE
.set MBR_TABLE_ENTRY_LEN,           0x0010
.set MBR_TABLE_LEN,                 0x0004

.text
    .global get_active_partition

/* Holy shit it works! */
get_active_partition:
    /* Start/iterator. */
    mov (_start + 0x01BE), %bl
    /* Boot signature. */
    mov $0x80, %bh
    /* Final address. */
    mov $0x01FE, %al

.loop:
    /* Check if bootable. */
    cmp %bl, %bh
    je .ok

    /* Move to next entry and see if we aren't at the end. */
    add $0x10, %bl
    cmp %bl, %al
    jge .loop

    /* If we've looked through all four to no avail then we error. */
    jmp .die

.die:
    call set_screen_style_error

    lea .no_bootable_partitions, %si
    call print_string

    hlt

.ok:
    /* Load all the right information into the right registers. */
    ret

.no_bootable_partitions:
    .asciz "pt: nb"

