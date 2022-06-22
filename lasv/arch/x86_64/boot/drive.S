.code16

/* read_fat_sector:
    /* Read one sector. * /
    mov $1, %al
    /* Disk number. * /
    mov $0, %dl
    /* Address to load into. * /
    mov $ENTRY_PHYS_ADDR, %bx

    call read_sector

    ret */

/* http://www.bioscentral.com/misc/biosint13.htm */
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
    call set_screen_style_error

    lea sector_read_failure_msg, %si
    call print_string

    hlt

sector_read_failure_msg:
    .asciz "ds: rf"

