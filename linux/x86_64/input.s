.intel_syntax noprefix
.global _start
.text

_start:
lea r11, [str_len]
lea rdi, [buff]
push rdi
call input
pop rdi
call print_input
call exit



exit:
    mov rax, 60
    mov rdi, 1
    syscall

input:
mov rsi, rdi
mov rax, 0
mov rdi, 0
mov rdx, 1024
syscall
ret

print:
    mov rax, 0
    push rdi
    call str_len
    pop rdi
    mov r10, rdi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, r10
    syscall
    ret
    
str_len:
    mov bl, [rdi]
    cmp bl, 0
    je str_ret
    inc rdi
    inc rax
    jmp r11

str_ret:
    ret

print_input:
    mov rdx, rax #Because syscall return number of bytes written to the buffer in rax
    mov rsi, rdi
    mov rax, 1
    mov rdi, 1
    syscall
    ret


.data
buff: .skip 1024

