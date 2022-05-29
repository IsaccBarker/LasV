.code16

.text
    .global print_char

/* print_string:
    push %bp
    mov %sp, %bp

    pusha

    mov $0x00, %bh
    mov $0x00, %bl
    mov $0x0e, %ah */

/* .print_char:
    lodsb

    cmp $0, %al
    je .done

    int $0x10
    jmp .print_char

.done:
    popa

    mov %bp, %sp
    pop %bp

    ret */

print_string:
    lodsb

    or %al, %al
    jz .done

    mov $0x0E, %ah
    int $0x10

    jmp print_string

.done:
   ret

