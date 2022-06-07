include ../../../base.mk

all:
	$(MAKE) -C boot BASE=$(BASE) all
	$(MAKE) -C entry BASE=$(BASE) all
	$(PROGRESS) "DISK" "lasv.iso"
	cat $(BASE)/target/out/intermediate/* > "$(BASE)/target/out/lasv.bin"
	dd if=/dev/zero of=../../../target/out/lasv.iso bs=1M count=128
	sfdisk ../../../target/out/lasv.iso < ../../../.sfdiskrc
	dd if=../../../target/out/intermediate/boot.bin of=../../../target/out/lasv.iso conv=notrunc bs=440 count=1
	dd if=../../../target/out/intermediate/boot.bin of=../../../target/out/lasv.iso conv=notrunc bs=1 count=2 skip=510 seek=510

