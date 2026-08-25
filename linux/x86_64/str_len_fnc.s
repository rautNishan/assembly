.intel_syntax noprefix
.global _start
.text
_start:
    lea r10, [str_len]
    lea rsp, [str1]
    lea rdi, [str1]

str_len: #;arg order [RDI, RSI, RDX, RCX, R8, R9]
    mov bl, [rdi]
    cmp bl, 0
    je str_rtn
    inc rcx
    inc rdi
    jmp r10
    #;RAX is return
    
str_rtn:
    mov rax, rcx
    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall



.data
    str1: .ascii "First\0"
    str2: .asciz "Second" ;#asciz automatically add null turminator
    str3: .string "Third"
