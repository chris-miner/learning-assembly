# compute the factorial of a number
.text
.equ NUMBER, 5
.equ INITIAL, 1

.globl start
start:
    mov $INITIAL, %ax
    mov $NUMBER, %cx

mainloop:
    mul %cx
    loop mainloop

    mov %ax, %di
    mov $0x2000001, %rax
    syscall