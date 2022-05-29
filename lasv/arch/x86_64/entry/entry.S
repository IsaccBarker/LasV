.code16

.set BOOTS_PHYS_ADDR,      0x00010000
.set BOOTS_SEGMENT,        0x1000
.set BOOTS_SEGMENT_OFFSET, 0x0000

.text
    .global _setup32
    .global lasv_enter

_setup32:
    .asciz "foo"

    call lasv_enter

    hlt

.include "../shared/screen.S"
.include "../shared/vga.S"

