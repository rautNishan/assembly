.intel_syntax noprefix
.global _start
.text
_start:
    lea r12, [loop]
    lea rdi, [str1]
    call print
    call exit

print:
    call str_len
    mov rdx, rax
    mov rsi, rdi
    mov rax, 1
    mov rdi, 1

    syscall
    ret

str_len:
    mov rax, rdi
    call loop
    ret

loop:
    mov bl, [rax]
    cmp bl, 0
    je str_len_exit  #This is never added in our call stack so ret in str_len_exit will directly go back to print because we have used call str_len over there
                     #je is a jump command and does not push any thing on our stack
    inc rax
    inc r10
    jmp r12

str_len_exit:
    mov rax, r10
    int3
    ret


exit:
    mov rax, 60
    mov rdi, 1
    syscall

.data
    str1: .asciz "Hi this is hero nishan\n"
