# Archecture
ARCH ?= x86_64

# C compiler
CFLAGS ?=
CC ?= gcc

# GAS assembler.
ASFLAGS ?=
AS ?= as

# Linker
LDFLAGS ?=
LD ?= ld

# What kind of build do we do (debug/release)?
BUILD_MODE=debug

# ---

# Rust like style.
# TODO: Open to changes, doesn't fit very well aethestically as of now.
PROGRESS := @printf "  \\033[1;32m%8s\\033[0m  \\033[1;m%s\\033[0m\\n"

