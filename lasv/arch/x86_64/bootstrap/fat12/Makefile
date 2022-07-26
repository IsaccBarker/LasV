include ../../../../../base.mk

DEPS =
OBJ = bootstrap.o

all: $(OBJ)
	$(PROGRESS) "LD" "bootstrap.bin ($(OBJ))"
	$(CC) -T bootstrap.ld -o "$(BASE)/target/out/intermediate/bootstrap.bin" -ffreestanding -O2 -nostdlib $(BASE)/target/obj/bootstrap-*.o -lgcc

%.o: %.S $(DEPS)
	$(PROGRESS) "AS" "$<"
	$(AS) -o "$(BASE)/target/obj/bootstrap-$@" $< $(ASFLAGS)

%.o: %.c $(DEPS)
	$(PROGRESS) "CC" "$<"
	$(CC) -S -o "$(BASE)/target/intermediate/$(shell basename $<.s)" $< -m16 -std=gnu99 -ffreestanding -O2 -Wall -Wextra $(CFLAGS)
	$(AS) -o "$(BASE)/target/obj/bootstrap-$(shell basename $@)" "$(BASE)/target/intermediate/$(shell basename $<.s)" $(ASFLAGS)
