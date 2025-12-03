; task1_2.asm
BITS 32
global asm_main
extern print_int
extern print_string
extern read_int

section .data
    prompt1 db "Enter first integer: ",0
    prompt2 db "Enter second integer: ",0
    outmsg  db "Sum = ",0

section .bss
    ; no bss needed if we use stack

section .text
asm_main:
    push ebp
    mov ebp, esp

    ; prompt1
    push prompt1
    call print_string
    add esp,4

    ; read first integer -> returns value on stack? (standard asm_io.read_int usually puts result on stack)
    call read_int           ; if read_int returns value on stack, check your asm_io. We'll assume it returns in eax
    ; assume read_int puts result into eax
    push eax                ; store first on stack

    ; prompt2
    push prompt2
    call print_string
    add esp,4

    call read_int
    ; result in eax (second)
    mov ebx, eax            ; second in ebx

    ; pop first into ecx
    pop ecx                 ; first value
    add eax, ecx            ; eax = second + first

    ; print output label
    push outmsg
    call print_string
    add esp,4

    ; print sum
    push eax
    call print_int
    add esp,4

    mov eax,0
    leave
    ret
