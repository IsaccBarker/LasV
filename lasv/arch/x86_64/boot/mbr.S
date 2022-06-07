.code16

.set MBR_TABLE_ENTRY_LEN, 0x0010
.set MBR_TABLE_LEN,       0x0004

.text
    .global get_active_partition

get_active_partition:
    pusha
    mov $MBR_TABLE_PHYS_ADDR, %cl

/* Scan the text tabke entry. */
.mbr_scan_look:
    /* Increase the iterator so it points to the new
     * location of the next table entry. */
    add $MBR_TABLE_ENTRY_LEN, %cl

    /* Detect if the entry is maked as active. */
    cmp %cl, 0x1
    je .mbr_scan_done

    /* Detect if there are still more table entries to process.
     * If not, fail. */
    cmp $(MBR_TABLE_PHYS_ADDR+(MBR_TABLE_LEN * MBR_TABLE_ENTRY_LEN)), %cl
    je .mbr_scan_look

.mbr_scan_failed:
    call set_screen_error
    hlt

.mbr_scan_done:
    popa
    ret

aurora:
    .asciz "a"

