BITS 32
global asm_main
%include "src/asm_io.inc"

section .data
    first_prompt  db "Enter first integer: ", 0
    second_prompt db "Enter second integer: ", 0
    result_text   db "Result = ", 0

section .text
asm_main:
    push ebp
    mov  ebp, esp
    push ebx

    push dword first_prompt
    call print_string
    add  esp, 4
    call read_int
    mov  ebx, eax

    push dword second_prompt
    call print_string
    add  esp, 4
    call read_int
    add  ebx, eax

    push dword result_text
    call print_string
    add  esp, 4
    push ebx
    call print_int
    add  esp, 4
    call print_nl

    pop  ebx
    xor  eax, eax
    leave
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
