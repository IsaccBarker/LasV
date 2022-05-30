/**
 * A stripped down ELF parser for fitting in a boot sector.
 * It doesn't read a file system; it reads ahead on the disk
 * until it finds the magic number, then parses, and then runs.
 */

#include "elf.h"

#pragma GCC push_options
#pragma GCC optimize ("O0")
void
lasv_find_and_boot_elf(void)
{
    /* Elf64_Header* file_header = (Elf64_Header*) 0x8000;
    file_header->e_type = 3; */
    Elf64_Ehdr file_header;
    file_header.e_type = 3;
}
#pragma GCC pop_options

