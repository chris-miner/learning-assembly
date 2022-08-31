.text
.globl start
start:
    mov $0b1101, %rdi
    mov $0x02000001, %rax
    syscall