include ../../../base.mk

all:
	$(MAKE) -C boot BASE=$(BASE) all
	$(MAKE) -C entry BASE=$(BASE) all
	$(PROGRESS) "LD" "lasv.iso"
	mkisofs -R -b boot.bin -no-emul-boot -V CR0S -v -o ../../../target/out/lasv.iso ../../../target/out/intermediate

