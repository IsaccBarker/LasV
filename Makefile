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
	qemu-system-x86_64 -vga virtio -drive format=raw,file=target/out/lasv.dd

clean:
	rm -rf target
	$(PROGRESS) "Status" "Cleaned!"

