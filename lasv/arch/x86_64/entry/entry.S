.code16

.text
    .global _setup32

_setup32:
    call clear_screen
    call reset_cursor
    call set_screen_style_entry

    lea introduction_msg, %si
    call print_string

    /* What we need (https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html),
     *      section 3.6:
     *  - Memory information
     *  - BIOS boot device
     *  - Boot command line
     *  - Modules
     *  - ELF symbols
     *  - Memory map
     *  - Boot loader name
     *  - APM table
     *  - VBE information
     *  - Framebuffer information
     *  - (EFI stuff that we are skipping, BIOS only)
     *  - SMBIOS tables
     *  - RSDP (v1 and v2)
     *  - Networking information
     *  - Image load base physical address
     */

    hlt

introduction_msg:
    .ascii "LasV bootloader, authored Milo Banks 2022"
    .byte 0x0D, 0x0A
    .byte 0x0D, 0x0A
    .ascii "If you are reading this message, LasV has successfully read a disk"
    .byte 0x0D, 0x0A
    .ascii "sector, and loaded in stage 2 (entry). Since LasV is exclusively BIOS"
    .byte 0x0D, 0x0A
    .ascii "compatable, this means you are either running on legacy hardware (BIOS)"
    .byte 0x0D, 0x0A
    .ascii "or you are using legacy compatability mode (via UEFI). This may"
    .byte 0x0D, 0x0A
    .ascii "interfere with things, but it *should* be fine."
    .byte 0x0D, 0x0A
    .byte 0x0D, 0x0A
    .ascii "LasV will soon detect hardware information (as soon as this message"
    .byte 0x0D, 0x0A
    .ascii "is printed), and then pass it on via Multiboot v2.0."
    .byte 0x0D, 0x0A
    .byte 0x0D, 0x0A
    .ascii "Only ELF executables in a BTRFS filesystem are supported."
    .byte 0x00

.include "../shared/screen.S"
.include "../shared/vga.S"
.include "./real/memory.S"
.include "./real/bootdevice.S"
.include "./real/modules.S"
.include "./real/elfsymbols.S"
.include "./real/apm.S"
.include "./real/vbe.S"
.include "./real/framebuffer.S"
.include "./real/smbios.S"
.include "./real/rsdp.S"
.include "./real/network.S"

