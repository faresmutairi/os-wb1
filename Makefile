# Makefile for Worksheet 1
# Assumes src/ contains driver.c, asm files, and asm_io.asm/asm_io.inc

NASM = nasm
GCC = gcc
NASMFLAGS = -f elf32
CFLAGS = -m32 -c
LDFLAGS = -m32

SRCDIR = src
OBJS = $(SRCDIR)/driver.o $(SRCDIR)/asm_io.o

# list of asm programs
ASMS = task1 task1_2 name_repeat array_sum range_sum

all: $(ASMS)

# generic rule to build each program
# target names correspond to executables in src/
$(SRCDIR)/%.o: $(SRCDIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

# compile asm_io
$(SRCDIR)/asm_io.o: $(SRCDIR)/asm_io.asm
	$(NASM) $(NASMFLAGS) $(SRCDIR)/asm_io.asm -o $(SRCDIR)/asm_io.o

# compile driver
$(SRCDIR)/driver.o: $(SRCDIR)/driver.c
	$(GCC) $(CFLAGS) $(SRCDIR)/driver.c -o $(SRCDIR)/driver.o

# program rules
task1: $(SRCDIR)/task1.o $(SRCDIR)/asm_io.o $(SRCDIR)/driver.o
	$(GCC) $(LDFLAGS) $(SRCDIR)/driver.o $(SRCDIR)/task1.o $(SRCDIR)/asm_io.o -o $(SRCDIR)/task1

task1_2: $(SRCDIR)/task1_2.o $(SRCDIR)/asm_io.o $(SRCDIR)/driver.o
	$(GCC) $(LDFLAGS) $(SRCDIR)/driver.o $(SRCDIR)/task1_2.o $(SRCDIR)/asm_io.o -o $(SRCDIR)/task1_2

name_repeat: $(SRCDIR)/name_repeat.o $(SRCDIR)/asm_io.o $(SRCDIR)/driver.o
	$(GCC) $(LDFLAGS) $(SRCDIR)/driver.o $(SRCDIR)/name_repeat.o $(SRCDIR)/asm_io.o -o $(SRCDIR)/name_repeat

array_sum: $(SRCDIR)/array_sum.o $(SRCDIR)/asm_io.o $(SRCDIR)/driver.o
	$(GCC) $(LDFLAGS) $(SRCDIR)/driver.o $(SRCDIR)/array_sum.o $(SRCDIR)/asm_io.o -o $(SRCDIR)/array_sum

range_sum: $(SRCDIR)/range_sum.o $(SRCDIR)/asm_io.o $(SRCDIR)/driver.o
	$(GCC) $(LDFLAGS) $(SRCDIR)/driver.o $(SRCDIR)/range_sum.o $(SRCDIR)/asm_io.o -o $(SRCDIR)/range_sum

clean:
	rm -f $(SRCDIR)/*.o $(SRCDIR)/task1 $(SRCDIR)/task1_2 $(SRCDIR)/name_repeat $(SRCDIR)/array_sum $(SRCDIR)/range_sum

.PHONY: all clean
