.code16

.set MBR_TABLE_PARTITION_OFFSET,    0x01BE
.set MBR_TABLE_ENTRY_LEN,           0x0010
.set MBR_TABLE_LEN,                 0x0004

.text
    .global get_active_partition

/* Holy shit it works! */
get_active_partition:
    /* Start/iterator. */
    mov (_start + 0x01BE), %di

.loop:
    /* Check if bootable. */
    cmp $0x80, (%di)
    je .ok

    /* Move to next entry and see if we aren't at the end. */
    add $0x10, %di
    cmp $0x01FE, %di
    jge .loop

    /* If we've looked through all four to no avail then we error. */
    jmp .die

.die:
    call set_screen_style_error

    lea .no_bootable_partitions, %si
    call print_string

    hlt

.ok:
    /* Load the right information into the right registers. */
    /* Head */
    add $0x01, %di
    mov (%di), %dl

    push %dx
    mov %sp, %si
    call print_string

    /* First sector. */
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

.no_bootable_partitions:
    .asciz "pt: nb"

