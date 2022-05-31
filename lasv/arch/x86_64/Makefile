include ../../../base.mk

all:
	$(MAKE) -C boot BASE=$(BASE) all
	$(MAKE) -C entry BASE=$(BASE) all
	$(PROGRESS) "LD" "lasv.iso"
	cat $(BASE)/target/out/intermediate/* > "$(BASE)/target/out/lasv.bin"
	xorriso -as mkisofs -vv -R -b lasv.bin -no-emul-boot -V CR0S -v -o ../../../target/out/lasv.iso ../../../target/out/lasv.bin

