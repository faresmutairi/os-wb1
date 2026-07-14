BITS 32
global asm_main
%include "src/asm_io.inc"

section .data
    result_text db "The sum of numbers 1..100 is: ", 0

section .bss
    numbers resd 100

section .text
asm_main:
    push ebp
    mov  ebp, esp
    push ebx
    push esi

    xor  ecx, ecx
.fill_array:
    cmp  ecx, 100
    jge  .begin_sum
    lea  eax, [ecx + 1]
    mov  [numbers + ecx * 4], eax
    inc  ecx
    jmp  .fill_array

.begin_sum:
    xor  ecx, ecx
    xor  esi, esi
.sum_array:
    cmp  ecx, 100
    jge  .show_result
    add  esi, [numbers + ecx * 4]
    inc  ecx
    jmp  .sum_array

.show_result:
    push dword result_text
    call print_string
    add  esp, 4
    push esi
    call print_int
    add  esp, 4
    call print_nl

    pop  esi
    pop  ebx
    xor  eax, eax
    leave
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
