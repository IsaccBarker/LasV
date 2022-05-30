.code16

/* This isn't generalized because it doesn't need to be.
 *  http://www.bioscentral.com/misc/biosint13.htm*/
load_sector_2:
    mov $2, %ah
    /* Stage 2 is in the next sector. */
    mov $1, %al
    /* Cylinder number. */
    mov $0, %ch
    /* Sector number. */
    mov $2, %cl
    /* Head number. */
    mov $0, %dh
    /* Disk number. */
    mov $0, %dl
    /* Magic "more memory than we can give you!" register. */
    mov $0, %ax
    mov %ax, %es
    /* Address to load into. */
    mov $SETUP_PHYS_ADDR, %bx

    int $0x13

    jc sector_read_failure

    ret

sector_read_failure:
    call set_screen_error

    lea sector_read_failure_msg, %si
    call print_string

    /* mov %ah, MISC_ADDR
    lea MISC_ADDR, %si*/
    movzx %ah, %si
    call print_string

    hlt

sector_read_failure_msg:
    .asciz "Failed to read disk sector: "

