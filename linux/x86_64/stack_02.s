.intel_syntax noprefix
.global _start
.text

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 4
    mov [rbp-4], dword ptr 0x111111
    sub rsp, 4
    mov [rbp-8], dword ptr 0x222222
    call func
    sub rsp, 4
    mov [rbp-12], dword ptr 0x333333
    mov rsp,rbp
    pop rbp
    ret


func:
    push rbp
    mov rbp, rsp
    sub rsp, 4
    mov [rbp-4], dword ptr 0x444444
    pop rbp
    ret


