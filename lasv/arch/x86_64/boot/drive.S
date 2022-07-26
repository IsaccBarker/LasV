.code16

active_partition_head_w:
    .word
active_partition_sector_w:
    .word
active_partition_cylinder_w:
    .word
active_partition_lba_w:
    .word

# https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
heads_per_cylinder_w:
    .word
sectors_per_track_w:
    .word

.align 16
disk_address_packet:
    # .long (0x10 + 0x00 + 0x0001)             # 10 byte packet + always 0 + number of sectors ("Some Phoenix BIOSes are limited to a maximum of 127 sectors." -- wikipedia).
    .byte 0x10                              # Packet length, always 0x10 (16) for us.
    .byte 0x00                              # Always 0 (reserved?).
    .word 0x0001                            # Number of sectors.
    .word ENTRY_OFFSET_ADDR                 # Address to load into's offset.
    .word ENTRY_SEGMENT_ADDR                # Address to load into's segment.
    .long 0x0800                               # Lower 32-bits of 48-bit starting LBA.
    .long 0x0                               # Upper 16-bits of 48-bit starting LBA.

# Every BIOS since the mid-90's supports the LBA extension, but we might as well check anyways.
check_lba_support:
    mov $0x41, %ah
    mov $0x55aa, %bx
    mov $0x80, %dl

    int $0x13
    jc .lba_not_supported

    ret

get_per_values:
    # Get how many headers there are per cylinder and how many sectors there are per track.
    mov $8, %ah
    mov $0x80, %dl

    int $0x13
    jc .per_values_int_failed

    add $0x1, %dh
    mov %dh, heads_per_cylinder_w

    and $0x3f, %cl
    mov %cl, sectors_per_track_w

    ret

convert_chs_lba:
    # LBA = (C × HPC + H) × SPT + (S − 1)
    # https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
    # (C
    mov active_partition_cylinder_w, %ax

    # * HPC
    mov heads_per_cylinder_w, %cl             # Chop off the sectors per track.
    mul %cl

    # + H)
    mov active_partition_head_w, %cl
    movzx %cl, %cx
    add %cx, %ax

    # * SPT
    mov sectors_per_track_w, %cl
    mul %cl

    # + (S
    mov active_partition_sector_w, %bx

    # - 1)
    sub $0x1, %bx

    add %bx, %ax
    mov %ax, active_partition_lba_w

    ret

read_active_partition:
    # Offset
    mov $0x7d00, %si

    mov $0x42, %ah                          # Extended Read Sectors From Drives.
    mov $0x80, %dl                          # 0x80 stands for drive C:\

    int $0x13
    jc .sector_read_failure

    ret

.sector_read_failure:
    call set_screen_style_error

    lea .sector_read_failure_msg, %si
    call print_string

    hlt


.lba_not_supported:
    call set_screen_style_error

    lea .lba_not_supported_msg, %si
    call print_string

    hlt

.per_values_int_failed:
    call set_screen_style_error

    lea .per_values_int_failed_msg, %si
    call print_string

    hlt

.sector_read_failure_msg:
    .asciz "read error"

.lba_not_supported_msg:
    .asciz "no lba"

.per_values_int_failed_msg:
    .asciz "disk geom"

