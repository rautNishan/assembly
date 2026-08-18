.intel_syntax noprefix
.global _start
_start:
    mov rax, 0
    mov rbx, rax
    inc rbx

    add rbx, rax
    mov rcx, rbx
    add rcx, rbx

    mov rsi, rcx
    add rsi,rbx

    mov rdi, rsi
    add rdi, rcx

    mov r8, rdi
    add r8, rsi

    mov r9, r8
    add r9, rdi