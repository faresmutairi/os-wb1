NASM := nasm
CC := gcc

NASMFLAGS := -f elf32 -g -F dwarf
CFLAGS := -m32 -Wall -Wextra -O0 -g -fno-pie
LDFLAGS := -m32 -no-pie

SRCDIR := src
PROGRAMS := task1 task1_2 name_repeat array_sum range_sum
COMMON_OBJECTS := $(SRCDIR)/driver.o $(SRCDIR)/asm_io.o

.DEFAULT_GOAL := all

.PHONY: all clean test check-tools $(PROGRAMS)

all: check-tools $(PROGRAMS)

check-tools:
	@command -v $(NASM) >/dev/null || { echo "Error: nasm is not installed"; exit 1; }
	@command -v $(CC) >/dev/null || { echo "Error: gcc is not installed"; exit 1; }

$(PROGRAMS): %: $(SRCDIR)/%.o $(COMMON_OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $(SRCDIR)/$@

$(SRCDIR)/%.o: $(SRCDIR)/%.asm $(SRCDIR)/asm_io.inc
	$(NASM) $(NASMFLAGS) $< -o $@

$(SRCDIR)/asm_io.o: $(SRCDIR)/asm_io.asm
	$(NASM) $(NASMFLAGS) $< -o $@

$(SRCDIR)/driver.o: $(SRCDIR)/driver.c
	$(CC) $(CFLAGS) -c $< -o $@

test: all
	@echo "task1:" && ./src/task1
	@echo "task1_2:" && printf "10\n20\n" | ./src/task1_2
	@echo "array_sum:" && ./src/array_sum
	@echo "range_sum:" && printf "10\n20\n" | ./src/range_sum
	@echo "name_repeat lower boundary (50):" && printf "Fares\n50\n" | ./src/name_repeat | grep -c "Welcome, Fares" | grep -qx 50
	@echo "name_repeat upper boundary (100):" && printf "Fares\n100\n" | ./src/name_repeat | grep -c "Welcome, Fares" | grep -qx 100
	@echo "name_repeat invalid low (49):" && out=$$(mktemp); if printf "Fares\n49\n" | ./src/name_repeat > $$out; then rm -f $$out; echo "FAIL: 49 was accepted"; exit 1; fi; grep -q "at least 50" $$out; rm -f $$out
	@echo "name_repeat invalid high (101):" && out=$$(mktemp); if printf "Fares\n101\n" | ./src/name_repeat > $$out; then rm -f $$out; echo "FAIL: 101 was accepted"; exit 1; fi; grep -q "at most 100" $$out; rm -f $$out

clean:
	rm -f $(SRCDIR)/*.o $(addprefix $(SRCDIR)/,$(PROGRAMS))
