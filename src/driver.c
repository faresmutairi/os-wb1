/* driver.c */
#include <stdio.h>

int attribute ((cdecl)) asm_main(void); /* provided by assembler */

int main(void) {
    return asm_main();
}
