.intel_syntax noprefix
.global _start
.text

_start:
    lea rdi, [str1]
    lea rsi, [str2]
    call strcmp
    cmp rax, 0
    je matchfnc
    jne notmatch

matchfnc:
    lea rdi, [match]
    call print
    call exit

notmatch:
    lea rsp, [not_match]
    lea rdi,[not_match]
    call print
    call exit

strcmp:
    mov al, [rdi]
    mov dl, [rsi]
    cmp al,dl
    jne .strcmp_ret
    cmp al, 0
    je .strcmp_ret
    inc rdi
    inc rsi
    jmp strcmp
        .strcmp_ret:
            sub al, dl
            ret


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
    
.data
    str1: .asciz "hey sir is there any thing"
    str2: .asciz "hey"
    not_match: .asciz "String is not equal"
    match: .asciz "String are equal"