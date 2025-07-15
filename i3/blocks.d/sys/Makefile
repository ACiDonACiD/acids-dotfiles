# blocks.d/Makefile
# ───────────────────────────────────────────────────
# Build C source files in src/ into executables in bin/
# Usage:
#   make         # compile all
#   make bin     # ensure bin/ directory exists
#   make debug   # build with debug flags (-g -O0)
#   make release # build with -O3 and strip symbols
#   make clean   # remove all binaries

include ./config.mk

# Locate all .c source files under src/
SRC     := $(wildcard src/*.c)
# Map each src/foo.c -> bin/foo (drop .c extension)
BIN     := $(patsubst src/%.c, bin/%,$(SRC))

# Default target: build all binaries
all: $(BIN)

# Compile rule for each C file
bin/%: src/%.c | bin
	$(CC) $(CFLAGS) -o $@ $<
	chmod +x $@

# Ensure bin/ exists
bin:
	mkdir -p bin

# Debug build: no optimization, include debug symbols
debug: CFLAGS := -g -O0 -Wall -Wextra
debug: clean all

# Release build: high optimization, strip symbols
release: CFLAGS := -O3 -Wall -Wextra
release: clean all
	@echo "Stripping binaries with $(STRIP)..."
	@$(STRIP) bin/*

# Clean up all generated binaries
clean:
	rm -f bin/*

.PHONY: all clean debug release bin
