# My first program. This is a comment.
.globl start
.text
start:
    movq $0x2000001, %rax   # system call number for exit
    movq $3, %rdi           # exit code
    syscall
    