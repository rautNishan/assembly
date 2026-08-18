
.intel_syntax noprefix
.global _start

_start:
    mov rax, 1
    mov rbx, 1
    add rax, rbx
    add rbx,rax
    sub rbx, 1
    inc rbx
    dec rbx
