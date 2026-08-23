.intel_syntax noprefix
.global _start
_start:
    mov rax,1 #syscall write
    mov rdi,1 #Terminal stdout
    lea rsi, [hellostring]
    mov rdx, 6

    lea rsi, [helloworld]
    mov rdx, 14
    syscall
    mov rax, 60
    mov rdi, 0
    syscall

.data
hellostring: .byte 'H', 'e', 'l', 'l', 'o','\n'
helloworld: .ascii "Hello World! \n"