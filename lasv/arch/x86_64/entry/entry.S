.code16

.text
    .global _setup32
    .global lasv_enter

_setup32:
    call lasv_enter

    hlt

.include "../shared/screen.S"
.include "../shared/vga.S"

