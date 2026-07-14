BITS 32
global asm_main
%include "src/asm_io.inc"

section .data
    name_prompt  db "Enter your name: ", 0
    count_prompt db "Enter repetition count (50 to 100): ", 0
    welcome_text db "Welcome, ", 0
    small_error  db "Error: the number must be at least 50.", 10, 0
    large_error  db "Error: the number must be at most 100.", 10, 0

section .bss
    name_buffer resb 128

section .text
asm_main:
    push ebp
    mov  ebp, esp
    push ebx
    push esi

    push dword name_prompt
    call print_string
    add  esp, 4
    push dword 128
    push dword name_buffer
    call read_string
    add  esp, 8

    push dword count_prompt
    call print_string
    add  esp, 4
    call read_int
    mov  ebx, eax

    cmp  ebx, 50
    jl   .too_small
    cmp  ebx, 100
    jg   .too_large

    xor  esi, esi
.print_loop:
    cmp  esi, ebx
    jge  .success
    push dword welcome_text
    call print_string
    add  esp, 4
    push dword name_buffer
    call print_string
    add  esp, 4
    call print_nl
    inc  esi
    jmp  .print_loop

.success:
    xor  eax, eax
    jmp  .finish

.too_small:
    push dword small_error
    call print_string
    add  esp, 4
    mov  eax, 1
    jmp  .finish

.too_large:
    push dword large_error
    call print_string
    add  esp, 4
    mov  eax, 1

.finish:
    pop  esi
    pop  ebx
    leave
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
