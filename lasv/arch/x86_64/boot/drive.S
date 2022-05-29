.code16

load_sector2:
    mov $2, %ah
    /* Number of sectors to read. */
    mov $1, %al
    /* Cylinder number. */
    mov $0, %ch
    /* Sector number. */
    mov $2, %cl
    /* Head number. */
    mov $0, %dh
    /* Drive number. */
    mov $0, %dl

    mov %cs, %bx
    mov %bx, %es
    mov noop, %bx

    int $0x13

    jc read_failure

    ret

read_failure:
    /* Print error. */
    pop %gs
    mov %gs, %si
    call print_string

    hlt

read_failure_msg:
    .asciz "Failed to read disk."

noop:

