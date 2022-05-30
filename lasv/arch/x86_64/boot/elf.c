/**
 * A stripped down ELF parser for fitting in a boot sector.
 * It doesn't read a file system; it reads ahead on the disk
 * until it finds the magic number, then parses, and then runs.
 */

#include "elf.h"

void
lasv_boot_elf(void)
{
    // *(int *)0 = '9';

    /* if (*(char*)(0x7E01) == 'E') {
        asm volatile ("call clear_screen");
    } */
}

