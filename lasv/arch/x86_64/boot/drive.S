.code16

load_elf_header_sector:
    /* It would appear that setting some of these registers is verbose, as
     * the device, track, etc... that we want to read from is already populated.
     * I've left these in here for debugging purposes, so that when things work
     * I'll delete them and see what breaks.
     * If they are still here and the bootloader is functional, it's because I've
     * forgotten.
     * https://stackoverflow.com/questions/8840033/calculating-head-cylinder-track-and-sector-for-bios-interrupt-13h */

    mov $2, %ah
    /* The elf header is 110 bytes (or at least the fixed part of it is).
     * This fits inside of a single sector, so we only load one at first. */
    mov $1, %al
    /* Cylinder number. */
    mov $0, %ch
    /* Sector number. */
    mov $2, %cl
    /* Head number. */
    mov $0, %dh
    /* Drive number. */
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
    movzx %ah, %si
    call print_string
    lea sector_read_failure_msg, %si
    call print_string

    hlt

sector_read_failure_msg:
    .asciz "sre"

