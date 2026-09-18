.intel_syntax noprefix
.global _start
.text

CO_CA=10
S_CA=4*1024

_start:
    lea rsp,[stacks]
    call counter
    call exit

counter:
    push rbp
    mov rbp, rsp
    sub rsp, 16            
    mov byte ptr [rbp-8], 0
.loop:
    cmp byte ptr [rbp-8], 10
    jge .over
    movzx eax, byte ptr [rbp-8]  
    add al, '0'
    mov [rbp-16], al
    lea rsi, [rbp-16]        
    mov rdx, 1              
    call println
    add byte ptr[rbp-8], 1
    jmp .loop
.over:
    add rsp, 16
    pop rbp
    ret

print:
    mov rax, 1
    mov rdi, 1
    syscall
    ret
    
println:
call print
mov rax, 1
mov rdi, 1
lea rsi, [new_line]
syscall
ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall
    
.data
new_line: .byte 10
stacks: .skip CO_CA*S_CA