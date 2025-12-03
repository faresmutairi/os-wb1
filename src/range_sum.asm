; range_sum.asm
; Asks user for low and high indices (1..100), validates, sums arr[low..high]
BITS 32
global asm_main
extern read_int
extern print_string
extern print_int

section .data
    prompt_low db "Enter low index (1..100): ",0
    prompt_high db "Enter high index (1..100): ",0
    err_range db "Invalid range",10,0
    result_msg db "Result = ",0

section .bss
    arr resd 100

section .text
asm_main:
    push ebp
    mov ebp, esp

    ; initialize arr 1..100
    mov ecx, 0
.init_loop:
    cmp ecx,100
    jge .init_done
    mov eax, ecx
    add eax,1
    mov [arr + ecx*4], eax
    inc ecx
    jmp .init_loop
.init_done:

    ; prompt low
    push prompt_low
    call print_string
    add esp,4
    call read_int
    mov esi, eax    ; low

    ; prompt high
    push prompt_high
    call print_string
    add esp,4
    call read_int
    mov edi, eax    ; high

    ; validate 1 <= low <= high <=100
    cmp esi, 1
    jl .err
    cmp edi, esi
    jl .err
    cmp edi, 100
    jg .err

    ; sum from low to high inclusive
    mov ecx, esi
    xor ebx, ebx    ; sum in ebx
.sum_loop:
    cmp ecx, edi
    jg .sum_done
    mov eax, [arr + (ecx-1)*4] ; arr index ecx corresponds to value ecx
    add ebx, eax
    inc ecx
    jmp .sum_loop

.sum_done:
    ; print result
    push result_msg
    call print_string
    add esp,4
    push ebx
    call print_int
    add esp,4
    mov eax, 0
    leave
    ret

.err:
    push err_range
    call print_string
    add esp,4
    mov eax, 1
    leave
    ret
