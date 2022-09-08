# this program prints out the string in the variable "msg"
.data
msg:
    .ascii "Hello World!\n"
.equ msglen, . - msg

.text
.globl start
start:
    movq $0x2000004, %rax # sys_write
    movq $1, %rdi # stdout
    leaq msg(%rip), %rsi
    movq $msglen, %rdx
    syscall
    jc error
    jnc finish

finish:
    movq $0x2000001, %rax # exit
    movq $0, %rdi
    syscall

error:
    movq $0x2000001, %rax # exit
    movq $1, %rdi
    syscall