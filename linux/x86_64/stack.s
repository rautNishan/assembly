.intel_syntax noprefix
.global _start
.text

start:
call print_hi
call exit



exit: 
mov rax, 60
mov rdi, 0
syscall


print_hi:
mov rax, 1
mov rdi, 1
lea rsi, [hi]
mov rdx, 3
syscall
call print_bye
ret

print_bye:
mov rax, 1
mov rdi, 1
lea rsi, [bye]
mov rdx, 4
syscall
ret


.data
hi: .ascii "Hi\n"
bye: .ascii "Bye\n"

