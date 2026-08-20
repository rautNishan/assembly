.intel_syntax noprefix
.global _start
_start:
    mov rax, [reg16]
    lea rbx, [reg16]
    add rbx,8
    mov rcx, [rbx]

    mov rax, 0x01
    lea rbx,[mem]

    mov rcx,[mem]
    lea rax,[mem2]
    mov rbx,[mem]
    add rax,8
    mov rdx,[rax]
    

.data
reg16: .quad 0x12345678
reg17: .quad 0xaaaaaaaa
mem: .quad 0x01
mem2: .quad 0x375a02ffc0d713, 0xa4cdce6be193550