#include "mbr.h"

/** Looks for the active MBR parition and gets the head and cylinder.
 * Doesn't look for anything else, we can't afford that!
 *  https://en.wikipedia.org/wiki/Master_boot_record
 *  https://wiki.osdev.org/Partition_Table */
void
__attribute__((section("__get_entry_data"))) get_entry_data()
{
    asm volatile (".asciz \"foo\"");
    /* The parition table is in the same place for generic and standard
     * MBR structures (0x01BE). Same thing can't be said for other stuff,
     * such as NEWLDR, AST/NEC MS-DOS, Ontrack Disk Manager flavoured MBR. */

}
