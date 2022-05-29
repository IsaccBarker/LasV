include ../../../../base.mk

DEPS =
OBJ = entry.o enter.o real/vga.c

all: $(OBJ)
	$(PROGRESS) "LD" "entry.bin"
	@$(CC) -T entry.ld -o "$(BASE)/target/out/entry.bin" -ffreestanding -O2 -nostdlib "$(BASE)"/target/obj/entry-*.o -lgcc

%.o: %.S $(DEPS)
	$(PROGRESS) "AS" "$<"
	@$(AS) -o "$(BASE)/target/obj/entry-$@" $< $(ASFLAGS)

%.o: %.c $(DEPS)
	$(PROGRESS) "CC" "$<"
	@$(CC) -S -o "$(BASE)/target/intermediate/$<.s" $< -std=gnu99 -ffreestanding -O2 -Wall -Wextra $(CFLAGS)
	@$(AS) -o "$(BASE)/target/obj/entry-$@" "$(BASE)/target/intermediate/$<.s" $(ASFLAGS)
