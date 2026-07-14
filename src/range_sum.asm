BITS 32
global asm_main
%include "src/asm_io.inc"

section .data
    low_prompt  db "Enter low index (1..100): ", 0
    high_prompt db "Enter high index (1..100): ", 0
    result_text db "Range sum = ", 0
    range_error db "Error: expected 1 <= low <= high <= 100.", 10, 0

section .bss
    numbers resd 100

section .text
asm_main:
    push ebp
    mov  ebp, esp
    push ebx
    push esi
    push edi

    xor  ecx, ecx
.fill_array:
    cmp  ecx, 100
    jge  .read_range
    lea  eax, [ecx + 1]
    mov  [numbers + ecx * 4], eax
    inc  ecx
    jmp  .fill_array

.read_range:
    push dword low_prompt
    call print_string
    add  esp, 4
    call read_int
    mov  esi, eax

    push dword high_prompt
    call print_string
    add  esp, 4
    call read_int
    mov  edi, eax

    cmp  esi, 1
    jl   .invalid
    cmp  edi, esi
    jl   .invalid
    cmp  edi, 100
    jg   .invalid

    mov  ecx, esi
    dec  ecx
    xor  ebx, ebx
.sum_range:
    cmp  ecx, edi
    jge  .show_result
    add  ebx, [numbers + ecx * 4]
    inc  ecx
    jmp  .sum_range

.show_result:
    push dword result_text
    call print_string
    add  esp, 4
    push ebx
    call print_int
    add  esp, 4
    call print_nl
    xor  eax, eax
    jmp  .finish

.invalid:
    push dword range_error
    call print_string
    add  esp, 4
    mov  eax, 1

.finish:
    pop  edi
    pop  esi
    pop  ebx
    leave
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
