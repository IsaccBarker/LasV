#ifndef ELF_H
#define ELF_H

#include <stdint.h>

/* https://man7.org/linux/man-pages/man5/elf.5.html */

/** Quote,
 * The ELF header is described by the type Elf32_Ehdr or Elf64_Ehdr.
 */
typedef struct {
    unsigned char e_ident[16];
    uint16_t e_type;
    uint16_t e_machine;
    uint32_t e_version;
    uint64_t e_entry;
    uint64_t e_phoff;
    uint64_t e_shoff;
    uint32_t e_flags;
    uint16_t e_ehsize;
    uint16_t e_phentsize;
    uint16_t e_phnum;
    uint16_t e_shentsize;
    uint16_t e_shnum;
    uint16_t e_shstrndx;
} Elf64_Ehdr;

/** Quote,
 * An executable or shared object file's program header table is an
 *      array of structures, each describing a segment or other
 *      information the system needs to prepare the program for
 *      execution.  An object file segment contains one or more sections.
 *      Program headers are meaningful only for executable and shared
 *      object files.  A file specifies its own program header size with
 *      the ELF header's e_phentsize and e_phnum members.  The ELF
 *      program header is described by the type Elf32_Phdr or Elf64_Phdr
 *      depending on the architecture.
 */
typedef struct {
    uint32_t p_type;
    uint32_t p_flags;
    uint64_t p_offset;
    uint64_t p_vaddr;
    uint64_t p_paddr;
    uint64_t p_filesz;
    uint64_t p_memsz;
    uint64_t p_align;
} Elf64_Phdr;

/** Quote,
 * A file's section header table lets one locate all the file's
 *     sections.  The section header table is an array of Elf32_Shdr or
 *     Elf64_Shdr structures.  The ELF header's e_shoff member gives the
 *     byte offset from the beginning of the file to the section header
 *     table.  e_shnum holds the number of entries the section header
 *     table contains.  e_shentsize holds the size in bytes of each
 *     entry.
 *
 *     A section header table index is a subscript into this array.
 *     Some section header table indices are reserved: the initial entry
 *     and the indices between SHN_LORESERVE and SHN_HIRESERVE.  The
 *     initial entry is used in ELF extensions for e_phnum, e_shnum, and
 *     e_shstrndx; in other cases, each field in the initial entry is
 *     set to zero.  An object file does not have sections for these
 *     special indices.
 */
typedef struct {
    uint32_t sh_name;
    uint32_t sh_type;
    uint64_t sh_flags;
    uint64_t sh_addr;
    uint64_t sh_offset;
    uint64_t sh_size;
    uint32_t sh_link;
    uint32_t sh_info;
    uint64_t sh_addralign;
    uint64_t sh_entsize;
} Elf64_Shdr;

/** NOTE: We are skipping a bunch of stuff that we don't need, as we can't afford to give a shit
 * about it. Literally!
 *  Reallocations
 *  Dynamic tags
 *  Notes
 * We just ignore these sections, and don't err on them. This is because we still want to incorperate
 * debug symbols and whatnot into stage 2, but we obviously don't care about them when we are loading
 * it in.
 */

#endif /* ELF_H */

