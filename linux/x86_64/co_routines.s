.intel_syntax noprefix
.global _start
.text

CO_CA=2
S_CA=4*1024



_start:
    lea rdi, [counter]
    call co_routine
    lea rdi, [counter]
    call co_routine
    call exit

co_routine: 
    cmp byte ptr [ctx_count], CO_CA
    jg .over_flow_fail
    mov bl, [ctx_count]
    inc byte ptr [ctx_count]
    
    mov rax, [stack_end]
    
    mov [ctx_rsp+rbx*8], rax
    mov byte ptr [ctx_rbp+rbx*8], 0
    mov [ctx_rip+rbx*8], rdi
    ret
    
.over_flow_fail:
    lea rdi, [over_flow_fail_msg]
    mov rdx, [over_flow_fail_msg_count]
    call print

         
counter:
    push rbp
    mov rbp, rsp
    sub rsp, 16            
    mov byte ptr [rbp-8], 0

.loop:
    cmp byte ptr [rbp-8], 2
    jge .over
    movzx eax, byte ptr [rbp-8]  
    add al, '0'
    mov [rbp-16], al
    lea rdi, [rbp-16]        
    mov rdx, 1              
    call println
    add byte ptr[rbp-8], 1
    jmp .loop
.over:
    add rsp, 16
    pop rbp
    ret

print:
    mov rsi, rdi
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
ctx_rsp: .quad CO_CA
ctx_rbp: .quad CO_CA
ctx_rip: .quad CO_CA
ctx_count: .byte 0
over_flow_fail_msg: .asciz "To many co routines\n"
over_flow_fail_msg_count: .byte 20
stack_end: .quad stacks+CO_CA*S_CA
