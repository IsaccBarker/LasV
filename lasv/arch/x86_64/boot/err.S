error_out:
    .byte 0x0                               # The error code
    .word 0x0d0a                            # \n + \r

print_interupt_error_code:
    mov %ah, error_out
    lea error_out, %si

    call print_string

