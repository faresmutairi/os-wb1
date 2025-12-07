# Worksheet 1 — An echo of Assembler
Student: fares almutairi 
Module: os
Date: 4th December 2025

## Repo structure
repo-name/
README.md
Makefile
src/
asm_io.inc
asm_io.asm
driver.c
task1.asm
task1_2.asm
name_repeat.asm
array_sum.asm
range_sum.asm


## How to build (on csctcloud)
1. Clone the repo to `csctcloud.uwe.ac.uk` (use SSH token if needed).
2. `cd` to repo root.
3. Run `make` (this builds all targets).
4. Run example program: `./src/task1`

## What I implemented
- **Task 1 (20%)**: `task1.asm` — adds two global integers and prints result using `print_string` and `print_int`.
  - Screenshot: (add screenshot)
  - Explanation: (brief explanation of register usage, calling print_int)
- **Task 1.2 (20%)**: `task1_2.asm` — reads two integers and prints sum.
- **Task 2 (20%)**:
  - `name_repeat.asm` — prompts for name and count, validates (50 < n < 100), prints `Welcome, <name>` n times or error.
  - `array_sum.asm` — creates array 1..100, sums it, prints result.
  - `range_sum.asm` — asks low & high indices, validates, sums that portion and prints.
- **Task 3 (20%)**: `Makefile` that builds all executables and a `clean` target.
- **Task 4 (40%)**: This README and screenshots and explanations. (Add screenshots showing the program running, and describe how it works.)

## Notes and assumptions
- The code uses functions supplied in `asm_io.asm`/`asm_io.inc` provided on Blackboard (print_int, print_string, read_int, read_string).
- Some small calling-convention details may differ depending on your version of `asm_io` (e.g., whether `read_int` returns value in `eax` or pushes on the stack). If you see different behavior, adjust accordingly.

## How to run each program
build just one program:

make task1
./src/task1

or build all:

make
./src/name_repeat



## Screenshots
- Add three screenshots:
  1. `task1` output
  2. `name_repeat` interaction
  3. `array_sum` output

## References
- PC Assembly Language (book)
- Lecture slides: Learning Unit 2


