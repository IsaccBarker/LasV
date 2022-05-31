include ../../../../base.mk

DEPS =
OBJ = entry.o

all: $(OBJ)
	$(PROGRESS) "LD" "entry.bin ($(OBJ))"
	$(CC) -T entry.ld -o "$(BASE)/target/out/intermediate/entry.bin" -ffreestanding -O2 -nostdlib $(BASE)/target/obj/entry-*.o -lgcc

%.o: %.S $(DEPS)
	$(PROGRESS) "AS" "$<"
	$(AS) -o "$(BASE)/target/obj/entry-$@" $< $(ASFLAGS)

%.o: %.c $(DEPS)
	$(PROGRESS) "CC" "$<"
	$(CC) -S -o "$(BASE)/target/intermediate/$(shell basename $<.s)" $< -m16 -std=gnu99 -ffreestanding -O2 -Wall -Wextra $(CFLAGS)
	$(AS) -o "$(BASE)/target/obj/entry-$(shell basename $@)" "$(BASE)/target/intermediate/$(shell basename $<.s)" $(ASFLAGS)
