BITS 32
global asm_main
%include "src/asm_io.inc"

section .data
    first_number  dd 13
    second_number dd 29
    result        dd 0
    result_text   db "The sum is: ", 0

section .text
asm_main:
    push ebp
    mov  ebp, esp

    mov  eax, [first_number]
    add  eax, [second_number]
    mov  [result], eax

    push dword result_text
    call print_string
    add  esp, 4

    push dword [result]
    call print_int
    add  esp, 4
    call print_nl

    xor  eax, eax
    leave
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
