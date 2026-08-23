.intel_syntax noprefix
.global _start
.text

start:
    lea r15, [callstack]
    lea rsp, [callstack]
    lea rax, [return]
    mov [r15],rax
    add r15, 8
    jmp print_hi
    jmp return

return: 
    jmp exit

exit: 
    mov rax, 60
    mov rdi, 0
    syscall


print_hi:
    mov rax, 1
    mov rdi, 1
    lea rsi, [hi]
    mov rdx, 3
    syscall

    lea rax, [continue_hi]
    mov [r15],rax
    add r15, 8
    jmp print_bye

continue_hi:
    sub r15, 8
    jmp [r15]

print_bye:
    mov rax, 1
    mov rdi, 1
    lea rsi, [bye]
    mov rdx, 4
    syscall
    sub r15, 8
    jmp [r15]



.data
    hi: .ascii "Hi\n"
    bye: .ascii "Bye\n"

    callstack: .skip 4096, 0xF
