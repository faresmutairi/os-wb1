; task1.asm  (NASM, 32-bit)
; Adds two globals and prints result using asm_io.print_int

BITS 32
global asm_main
extern print_int
extern print_string
extern newline    ; if your asm_io provides newline; otherwise use print_string with "\n"

section .data
    num1 dd  13
    num2 dd   29
    res  dd 0
    msg  db "Result = ",0

section .text

asm_main:
    push    ebp
    mov     ebp, esp

    ; load numbers and add
    mov     eax, [num1]
    add     eax, [num2]
    mov     [res], eax

    ; print message (if asm_io.print_string exists)
    push    msg
    call    print_string
    add     esp, 4

    ; print result (print_int expects integer on stack)
    push    dword [res]
    call    print_int
    add     esp, 4

    ; newline - optional
    ; push newline ; uncomment if you have newline symbol
    ; call print_string
    ; add esp,4

    mov     eax, 0      ; return 0
    leave
    ret
