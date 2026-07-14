BITS 32

global print_int
global print_string
global read_int
global read_string
global print_nl

extern printf
extern fflush
extern scanf
extern fgets
extern stdin

section .rodata
    format_int       db "%d", 0
    format_string    db "%s", 0
    format_read_int  db "%d", 0
    newline_string   db 10, 0

section .text

; void print_int(int value)
print_int:
    push ebp
    mov  ebp, esp
    push dword [ebp + 8]
    push dword format_int
    call printf
    add  esp, 8
    leave
    ret

; void print_string(const char *text)
print_string:
    push ebp
    mov  ebp, esp
    push dword [ebp + 8]
    push dword format_string
    call printf
    add  esp, 8

    ; Display prompts immediately before waiting for input.
    push dword 0
    call fflush
    add  esp, 4

    leave
    ret

; int read_int(void)
read_int:
    push ebp
    mov  ebp, esp
    sub  esp, 4
    lea  eax, [ebp - 4]
    push eax
    push dword format_read_int
    call scanf
    add  esp, 8
    cmp  eax, 1
    jne  .read_failed
    mov  eax, [ebp - 4]
    leave
    ret
.read_failed:
    xor  eax, eax
    leave
    ret

; char *read_string(char *buffer, int maximum_length)
; fgets is used so names may contain spaces. The trailing newline is removed.
read_string:
    push ebp
    mov  ebp, esp
    push dword [stdin]
    push dword [ebp + 12]
    push dword [ebp + 8]
    call fgets
    add  esp, 12
    test eax, eax
    jz   .string_done
    mov  edx, [ebp + 8]
.strip_newline:
    cmp  byte [edx], 0
    je   .string_done
    cmp  byte [edx], 10
    je   .replace_newline
    inc  edx
    jmp  .strip_newline
.replace_newline:
    mov  byte [edx], 0
.string_done:
    leave
    ret

; void print_nl(void)
print_nl:
    push dword newline_string
    call print_string
    add  esp, 4
    ret


section .note.GNU-stack noalloc noexec nowrite progbits
