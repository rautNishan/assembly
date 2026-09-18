.intel_syntax noprefix
.global _start
.text


_start:
    mov rax,12
    mov rdi, 0
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
    