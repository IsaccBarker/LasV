.code16

; http://www.bioscentral.com/misc/biosint13.htm
read_sector:
    mov $2, %ah             ; Read 'command'/'opcode'.

    mov $0, %ax             ; Magic "more memory than we can give you!" register.
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

