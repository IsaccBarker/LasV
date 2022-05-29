#include "../../shared/vga.h"

void
real_print_string(char* str)
{
    *((int*)0xb8000)=0x07690748;
    // asm volatile ("");
}

