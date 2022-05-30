.code16

.text
    .global clear_screen
    .global reset_cursor

clear_screen:
    push %bp
    mov %sp, %bp

    pusha

    mov $0x07, %ah
    mov $0x00, %al
    mov $0x07, %bh
    mov $0x00, %cx
    mov $0x18, %dh
    mov $0x4f, %dl

    int $0x10

    popa

    mov %bp, %sp
    pop %bp

    ret

reset_cursor:
    push %bp
    mov %sp, %bp

    pusha

    mov $0x00, %dh
    mov $0x00, %dl
    mov $0x02, %ah
    mov $0x00, %bh

    int $0x10

    popa

    mov %bp, %sp
    pop %bp

    ret

/* Video mode. We don't set it, but it's an option.
 *  http://vitaly_filatov.tripod.com/ng/asm/asm_023.1.html */

/* Screen color codes (from 0x0): Black, Blue, Green, Teal, Red */

set_screen_style_boot:
    mov $0x0B, %ah
    mov $0x00, %bh
    mov $0x01, %bl
    int $0x10

    ret

set_screen_style_entry:
    mov $0x0B, %ah
    mov $0x00, %bh
    mov $0x09, %bl
    int $0x10

    ret

set_screen_error:
    mov $0x0B, %ah
    mov $0x00, %bh
    mov $0x04, %bl
    int $0x10

    ret

