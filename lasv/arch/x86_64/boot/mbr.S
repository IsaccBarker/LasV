.code16

.set MBR_TABLE_PARTITION_OFFSET,    0x01BE
.set MBR_TABLE_ENTRY_LEN,           0x0010
.set MBR_TABLE_LEN,                 0x0004

.text
    .global get_active_partition
    .global load_active_partition_metadata

get_active_partition:
    mov $(0x7C00 + 0x01BE), %bx             # Start/iterator.
    mov $0x80, %dx                          # Boot signature.
    mov $0x01FE, %cx                        # Final address.

    push %ax

.loop:
    mov (%bx), %ax
    movzx %al, %ax

    cmp %ax, %dx                            # Check if bootable.
    je .ok

    add $0x10, %bx                          # Move to next entry and see if we aren't at the end.
    cmp %bx, %cx
    jge .loop

    jmp .die                                # If we've looked through all four to no avail then we error.

.die:
    call .no_bootable_partitions_failure

.ok:
    # Cool sanity checks!
    #   Unsupported filesystem type checking.
    #   More?

    mov $0x1, %dx                           # TODO: Support filesystems other than FAT12.
    add $0x04, %bx                          # File type field offset into the partition entry.
    mov (%bx), %ax
    movzx %al, %ax

    cmp %ax, %dx                            # Detect if filesystem is FAT12.
    jne .unsupported_partition_format_failure

    sub $0x04, %bx                          # Go back to start of partition table entry.

    pop %ax

    ret

load_active_partition_metadata:
    # Load the right information into the right registers.
    # Something is seriously wrong in the MBR table that this
    # parses. I don't think anything is wrong with the code,
    # I manually checked and the MBR table entry literally
    # says the 20th head.
    # https://en.wikipedia.org/wiki/Master_boot_record#Partition_table_entries

    mov $0x0, %al
    mov %al, ACTIVE_PARTITION_DRIVE        # TODO: I think the only valid value here is 0 (for drive 0).

    add $0x01, %bx                          # Move to start of CHS address field (head first).
    mov (%bx), %al
    mov %al, ACTIVE_PARTITION_HEAD

    add $0x01, %bx                          # Next CHS field ("sector in bits 5–0; bits 7–6 are high bits of cylinder" -- wikipedia).
    mov (%bx), %al
    and $0xF, %al                           # 0b001111 mask to remove the high cylinder bits.
    mov %al, ACTIVE_PARTITION_SECTOR        # We're only loading the sector here, not the cylinder fragment, because we wouldn't be able to fit it into the BIOS call anyways.

    add $0x01, %bx                          # Next CHS field (other bits of the cylinder)
    mov (%bx), %al
    mov %al, ACTIVE_PARTITION_CYLINDER

    call convert_chs_lba

    ret

.no_bootable_partitions_failure:
    call set_screen_style_error

    lea .no_bootable_partitions, %si
    call print_string

    hlt

.unsupported_partition_format_failure:
    call set_screen_style_error

    lea .unsupported_partition_format, %si
    call print_string

    hlt

.no_bootable_partitions:
    .asciz "pt: nb"

.unsupported_partition_format:
    .asciz "pe: uf"

