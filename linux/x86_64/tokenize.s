.intel_syntax noprefix
.global _start
.text

_start:
    lea rdi, [input_buff]
    push rdi
    call read_line
    pop rdi
    mov byte ptr [rdi+rax], 0
    lea rsi, [tokens]
    call tokenize
    call exit

print:
    push rdi
    call str_len
    pop rdi
    mov rsi, rdi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall 
    ret

str_len:
    mov rbx, 0
    mov rsi, rdi
    call str_len_loop
    ret

str_len_loop:
    mov al, [rsi]
    cmp al, 0
    je str_len_exit
    inc rsi
    inc rbx
    jmp str_len_loop



str_len_exit:
    mov rax, rbx
    ret 


exit: 
    mov rax, 60
    mov rdi, 0
    syscall
    ret

read_line:
    mov rsi, rdi
    mov rax, 0
    mov rdi, 0
    mov rdx, 1024
    syscall
    ret

memview:
    mov r14, rsp
    lea rsp, [input_buff]
    int3 
    mov rsp, r14
    ret

tokenize:
    mov r15, rsi
    call tokenize_loop
    call memview 
    ret

tokenize_loop:
    call skipwhite
    mov [r15],rdi
    add r15, 8
    call memview
    call findspace
    call memview
    inc rdi
    cmp byte ptr [rdi], 0
    je tokenize_ret
    jmp tokenize_loop


tokenize_ret:
    ret

findspace:
    cmp byte ptr [rdi],0x20
    je findspace_ret
    cmp byte ptr [rdi], 0
    je findspace_ret
    inc rdi
    jmp findspace

findspace_ret:
    mov byte ptr [rdi], 0
    ret

skipwhite:
    cmp byte ptr [rdi], 0x20
    je skipwhite.advance
    ret
        skipwhite.advance:
        inc rdi
        jmp skipwhite

.data
input_buff: .skip 128, 0xff
tokens: .skip 128