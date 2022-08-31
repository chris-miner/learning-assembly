# My first program. This is a comment.
.globl start
.text
start:
    movq $0x02000001, %rax
    movq $3, %rdi
    syscall