OUTPUT_FORMAT(binary)
ENTRY(_setup32)

SECTIONS
{
	. = 0x7E00;

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

