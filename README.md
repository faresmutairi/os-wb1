#Worksheet  1 — An echo of Assembler
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
- **Task 1 (20%)**: This program loads two global integers, adds them together using basic register operations, and prints the result using print_int.
  - **Example output:**
 ``` The sum is: 42
- **Task 1.2 (20%)**: `task1_2.asm` — This program reads two integers from the user using read_int, adds them together, and prints the result.
- **Example output:**
```Enter first number: 10
Enter second number: 20
Result = 30```

- **Task 2 (20%)**:
  - `name_repeat.asm` — This program asks the user for their name and for a repeat count.
It validates that the number is between 50 and 100.
If the number is valid, it prints Welcome, <name> the given number of times.
Otherwise, it prints an error message.
Enter your name: Fares
Enter repetition count: 55
Welcome, Fares
...
  - `array_sum.asm` — creates array 1..100, sums it, prints result.
  The sum of numbers 1..100 is: 5050
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



## References
- PC Assembly Language (book)
- Lecture slides: Learning Unit 2


