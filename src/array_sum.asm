; array_sum.asm
; Creates array of 1..100, sums and prints result
BITS 32
global asm_main
extern print_int
extern print_string

section .data
    msg db "Sum of 1..100 = ",0

section .bss
    arr resd 100    ; reserve 100 dwords

section .text
asm_main:
    push ebp
    mov ebp, esp

    ; initialize array: arr[i] = i+1
    mov ecx, 0
.init_loop:
    cmp ecx, 100
    jge .init_done
    mov eax, ecx
    add eax, 1
    mov [arr + ecx*4], eax
    inc ecx
    jmp .init_loop
.init_done:

    ; sum array
    xor esi, esi    ; sum in esi (32-bit)
    mov ecx, 0
.sum_loop:
    cmp ecx, 100
    jge .sum_done
    mov eax, [arr + ecx*4]
    add esi, eax
    inc ecx
    jmp .sum_loop
.sum_done:

    ; print message
    push msg
    call print_string
    add esp,4

    ; print sum (in esi)
    push esi
    call print_int
    add esp,4

    mov eax, 0
    leave
    ret
