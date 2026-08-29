.intel_syntax noprefix
.global _start
.text

_start:
    lea r11, [str_len]
    lea r10, [div_loop]
    mov rdi, 155
    call itoa
    call print_ln
    call exit

itoa:
    mov rbx, 10
    mov rax, rdi
    lea rcx, [buff]
    lea rdi, [buff+32]
    mov byte ptr [rdi], '\0'
    call div_loop
    ret


div_loop:
    mov rdx, 0
    dec rdi
    div rbx
    add rdx, '0'
    mov [rdi],dl
    cmp rax, 0
    je div_loop_exit
    jmp r10


div_loop_exit:
    ret

print:
    push rdi
    call str_len
    pop rdi
    mov r10, rdi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, r10
    syscall
    ret
    
print_ln:
    call print
    lea rsi, [new_line_buff]
    mov rdx, 1
    mov rax, 1
    mov rdi, 1
    syscall
    ret
    

str_len:
    mov bl, [rdi]
    cmp bl, '\0'
    je str_ret
    inc rdi
    inc rax
    jmp r11

str_ret:
    ret


exit:
    mov rax, 60
    mov rdi, 1
    syscall

.data
 buff: .skip 1024
 new_line_buff: .byte 10