include ../../../../base.mk

DEPS = elf.h
OBJ = boot.o elf.o

all: $(OBJ)
	$(PROGRESS) "LD" "boot.bin"
	$(CC) -T boot.ld -o "$(BASE)/target/out/intermediate/boot.bin" -ffreestanding -O2 -nostdlib "$(BASE)"/target/obj/boot-*.o -lgcc

%.o: %.S $(DEPS)
	$(PROGRESS) "AS" "$<"
	$(AS) -o "$(BASE)/target/obj/boot-$@" $< $(ASFLAGS)

%.o: %.c $(DEPS)
	$(PROGRESS) "CC" "$<"
	$(CC) -S -o "$(BASE)/target/intermediate/$<.s" $< -std=gnu99 -ffreestanding -Os -s -fdelete-null-pointer-checks -Wall -Wextra $(CFLAGS)
	$(AS) -o "$(BASE)/target/obj/boot-$@" "$(BASE)/target/intermediate/$<.s" $(ASFLAGS)
