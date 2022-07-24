.code16

.text
    .global check_lba_support
    .global load_active_parition
    .global convert_chs_lba

.set ACTIVE_PARTITION_HEAD,     0x0701
.set ACTIVE_PARTITION_SECTOR,   0x0702
.set ACTIVE_PARTITION_CYLINDER, 0x0703
.set ACTIVE_PARTITION_DRIVE,    0x0704

# https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
.set HEADS_PER_CYLINDER,        0x0705
.set SECTORS_PER_TRACK,         0x0706

.set ACTIVE_PARTITION_LBA,      0x0707

/* active_partition_disk_address_packet:
    .byte 0x10                              # Size of packet (0x10 or 0x18; 16 or 24 bytes)
    .byte 0x0                               # Reserved (0x00)
    .word 0x1                               # Number of blocks to transfer (Only 1 sector for us)
    .word ENTRY_PHYS_ADDR                   # Destination address
    .word 0x0                               # Offset
starting_lba:
    .long 0x0                               # Lower 32-bits of 48-bit starting LBA
    .long 0x0                               # Upper 16-bits of 48-bit starting LBA */

# Every BIOS since the mid-90's supports the LBA extension, but we might as well check anyways.
/* check_lba_support:
    mov $0x41, %ah
    mov $0x55aa, %bx
    mov $0x80, %dl

    int $0x13
    jc .lba_not_supported

    ret */

get_per_values:
    # Get how many headers there are per cylinder and how many sectors there are per track.
    mov $8, %ah
    mov $0x80, %dl

    int $0x13
    jc .per_values_int_failed

    add $0x1, %dh
    mov %dh, HEADS_PER_CYLINDER

    and $0x3f, %cl
    mov %cl, SECTORS_PER_TRACK

    ret

convert_chs_lba:
    # LBA = (C × HPC + H) × SPT + (S − 1)
    # https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
    # (C
    mov ACTIVE_PARTITION_CYLINDER, %ax

    # * HPC
    mov HEADS_PER_CYLINDER, %cl             # Chop off the sectors per track.
    mul %cl

    # + H)
    mov ACTIVE_PARTITION_HEAD, %cl
    movzx %cl, %cx
    add %cx, %ax

    # * SPT
    mov SECTORS_PER_TRACK, %cl
    mul %cl

    # + (S
    mov ACTIVE_PARTITION_SECTOR, %bx

    # - 1)
    sub $0x1, %bx

    add %bx, %ax
    mov %ax, ACTIVE_PARTITION_LBA

    ret

read_active_partition:
    push $0xffaa
    push $0x10 # $0x1000
    push $0x1
    push $ENTRY_PHYS_ADDR
    push $0x0
    push ACTIVE_PARTITION_LBA

    mov $0x42, %ah
    mov %sp, %ds
    mov $0x80, %dl

    # NOTE
    # Here, we want to get the address of the start of the disk address packet
    # on the stack, but for some reason you cannot dereference anything here.
    # You can do it earlier in the program, but not here. Figure out why this
    # is, and you will have cracked the code!

    hlt

    int $0x13
    jc .sector_read_failure

    # hlt

    # ret

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
    .asciz "sr: rf"

.lba_not_supported_msg:
    .asciz "lba: ns"

.per_values_int_failed_msg:
    .asciz "pv: ge"

