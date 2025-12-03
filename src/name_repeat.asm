; name_repeat.asm
; Reads a name (string) and a count (int). If count in (50,100) prints "Welcome <name>" count times
; Assumes asm_io provides: read_string(buffer, maxlen), read_int, print_string, print_int

BITS 32
global asm_main
extern read_string
extern read_int
extern print_string
extern print_int

section .data
    prompt_name db "Enter your name: ",0
    prompt_count db "Enter number of times to print (must be >50 and <100): ",0
    too_small db "Error: number too small",10,0
    too_large db "Error: number too large",10,0
    welcome db "Welcome, ",0
    newline db 10,0

section .bss
    name_buf resb 128

section .text
asm_main:
    push ebp
    mov ebp, esp

    ; prompt name
    push prompt_name
    call print_string
    add esp,4

    ; read_string(name_buf, 127)
    push dword 127
    push dword name_buf
    call read_string
    add esp,8

    ; prompt count
    push prompt_count
    call print_string
    add esp,4

    ; read_int -> assume returns in eax
    call read_int
    mov ebx, eax   ; count

    ; check >50
    cmp ebx, 50
    jle .err_small

    ; check <100
    cmp ebx, 100
    jge .err_large

    ; loop: print "Welcome, " + name_buf ebx times
    mov ecx, ebx   ; counter

.print_loop:
    ; print welcome
    push welcome
    call print_string
    add esp,4

    ; print name
    push name_buf
    call print_string
    add esp,4

    ; newline
    push newline
    call print_string
    add esp,4

    loop .print_loop

    mov eax, 0
    leave
    ret

.err_small:
    push too_small
    call print_string
    add esp,4
    mov eax, 1
    leave
    ret

.err_large:
    push too_large
    call print_string
    add esp,4
    mov eax, 1
    leave
    ret
