# All of this is getting uncomfortably slow...
# TODO: Switch to non-recursive makefiles.

include base.mk

BASE="$(shell pwd)"

all:
	mkdir -p "$(BASE)/mnt"
	mkdir -p "$(BASE)/target"
	mkdir -p "$(BASE)/target/obj"
	mkdir -p "$(BASE)/target/out"
	mkdir -p "$(BASE)/target/out/intermediate"
	mkdir -p "$(BASE)/target/intermediate"
	$(MAKE) -C lasv BASE="$(BASE)" all
	$(PROGRESS) "Status" "Done!"

media:
	$(MAKE) -C lasv/arch/$(ARCH) BASE="$(BASE)" media

run: all
	qemu-system-x86_64 -vga virtio -drive id=disk,format=raw,file=target/out/lasv.dd,if=none -device ahci,id=ahci -device ide-hd,drive=disk,bus=ahci.0

clean:
	rm -rf target
	rm -rf mnt/*
	$(PROGRESS) "Status" "Cleaned!"

