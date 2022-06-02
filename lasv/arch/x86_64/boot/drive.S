.code16

read_entry_sector:
    /* Read one sector. */
    mov $1, %al
    /* Cylinder number. */
    mov $0, %ch
    /* Sector number. */
    mov $2, %cl
    /* Head number. */
    mov $0, %dh
    /* Disk number. */
    mov $0, %dl
    /* Address to load into. */
    mov $ENTRY_PHYS_ADDR, %bx

    call read_sector

    ret

read_mbr_sector:
    /* Read one sector. */
    mov $1, %al
    /* Cylinder number. */
    mov $0, %ch
    /* The MBR header is in the first sector. */
    mov $1, %cl
    /* Head number. */
    mov $0, %dh
    /* Disk number. */
    mov $0, %dl
    /* Address to load into. */
    mov $MBR_PHYS_ADDR, %bx

    call read_sector

    ret

/* This isn't generalized because it doesn't need to be.
 *  http://www.bioscentral.com/misc/biosint13.htm*/
read_sector:
    /* Read. */
    mov $2, %ah

    /* Magic "more memory than we can give you!" register. */
    mov $0, %ax
    mov %ax, %es

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
    .asciz "ds: rf"

