include base.mk

BASE="$(shell pwd)"

all:
	mkdir -p "$(BASE)/target"
	mkdir -p "$(BASE)/target/obj"
	mkdir -p "$(BASE)/target/out"
	mkdir -p "$(BASE)/target/out/intermediate"
	mkdir -p "$(BASE)/target/intermediate"
	$(MAKE) -C lasv BASE="$(BASE)" all
	$(PROGRESS) "Status" "Done!"

run: all
	qemu-system-x86_64 -vga virtio -m 512 -boot d -cdrom target/out/lasv.iso

clean:
	rm -rf target
	$(PROGRESS) "Status" "Cleaned!"

