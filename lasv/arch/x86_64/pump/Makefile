include ../../../../base.mk

DEPS =
OBJ = pump.o

all: $(OBJ)
	$(PROGRESS) "LD" "pump.bin ($(OBJ))"
	$(CC) -T pump.ld -o "$(BASE)/target/out/intermediate/pump.bin" -ffreestanding -O2 -nostdlib $(BASE)/target/obj/pump-*.o -lgcc

%.o: %.S $(DEPS)
	$(PROGRESS) "AS" "$<"
	$(AS) -o "$(BASE)/target/obj/pump-$@" $< $(ASFLAGS)

%.o: %.c $(DEPS)
	$(PROGRESS) "CC" "$<"
	$(CC) -S -o "$(BASE)/target/intermediate/$(shell basename $<.s)" $< -m16 -std=gnu99 -ffreestanding -O2 -Wall -Wextra $(CFLAGS)
	$(AS) -o "$(BASE)/target/obj/pump-$(shell basename $@)" "$(BASE)/target/intermediate/$(shell basename $<.s)" $(ASFLAGS)
