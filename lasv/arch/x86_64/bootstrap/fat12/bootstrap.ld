OUTPUT_FORMAT(binary)

SECTIONS
{
	. = 0x7E55; /* 0x7E00 (load location) + 0x0020 (base BPB size) + 0x003E (FAT12/FAT16 EBR offset to boot code). */

	.text : {
		*(.text*)
	}

	.rodata : {
		*(.rodata*)
	}

	.data : {
		*(.data*)
	}

	.bss : {
		*(.bss*)
	}

	/DISCARD/ : {
		*(.comment*)
	}
}

