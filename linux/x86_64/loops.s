.intel_syntax noprefix
.global _start
.text

_start:
    #lea r11, [loop] 
    lea r11, [whileloop]
    jmp whileloop
    #jmp loop
    
loop:
    inc r10
    cmp r10, 3
    je print
    jmp r11
    
whileloop:
   inc r10
   cmp r10, 3
   je print
   jmp r11

print:
    mov rax, 1
    mov rdi, 1
    lea rsi, [s1]
    mov rdx, 9
    syscall
    jmp exit

exit:
    mov rax, 60
    mov rdi, 0
    syscall

.data
s1: .ascii "rax is 3\n"
