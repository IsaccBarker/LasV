include ../../../base.mk

all:
	$(MAKE) -C boot BASE=$(BASE) all
	$(MAKE) -C entry BASE=$(BASE) all
	$(PROGRESS) "LD" "lasv.dd"
	cat $(BASE)/target/out/intermediate/* > "$(BASE)/target/out/lasv.bin"

media:
	# Make the disk
	dd if=/dev/zero of=../../../target/out/lasv.dd bs=1M count=16
	sfdisk ../../../target/out/lasv.dd < ../../../.sfdiskrc
	dd if=../../../target/out/intermediate/boot.bin of=../../../target/out/lasv.dd conv=notrunc bs=440 count=1
	dd if=../../../target/out/intermediate/boot.bin of=../../../target/out/lasv.dd conv=notrunc bs=1 count=2 skip=510 seek=510
	# Make filesystem
	sudo losetup -o $$[2048*512] --sizelimit $$[8*1024*1024] -f ../../../target/out/lasv.dd
	sudo mkfs.fat -v -F 12 -n "BOOT" $(shell sudo losetup -f)
	sudo mount $(LV_LOOPBACK) ../../../mnt || echo "NOTE: Something failed. It may already be mounted, or did you forget to set the LV_LOOPBACK environment variable?"
	sudo mkdir -p ../../../mnt/boot
	sudo cp ../../../target/out/intermediate/entry.bin ../../../mnt/boot
	sudo umount ../../../mnt
	# Optional debug shit.
	echo "DISK INITIAL SECTOR."
	xxd -l 512 ../../../target/out/lasv.dd
	echo "FAT12 INITIAL SECTOR."
	sudo xxd -l 512 $(LV_LOOPBACK)
	sudo losetup -d $(shell sudo losetup -f)

