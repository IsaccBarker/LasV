#include "enter.h"
#include "../shared/screen.h"
#include "real/vga.h"

void
lasv_enter()
{
    clear_screen();
    reset_cursor();

    real_print_string(0x00);
}

