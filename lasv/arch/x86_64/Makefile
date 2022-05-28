include ../../../base.mk

all:
	@$(MAKE) -C boot BASE=$(BASE) all
	@$(MAKE) -C entry BASE=$(BASE) all
	$(PROGRESS) "LD" "lasv.bin"
	@cat "$(BASE)/target/out/boot.bin" "$(BASE)/target/out/entry.bin" > "$(BASE)/target/out/lasv.bin"

