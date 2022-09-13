# This program calculates the result raising a base to a power using a function.
.equ BASE, 3
.equ POWER, 4

.text
.globl start
start:
    # no local variables
    enter $0, $0
    
    mov $BASE, %rdi
    mov $POWER, %rsi
    call power
    
    mov %rax, %rdi
    call exit

# power takes two quad word unsigned arguments (RDI, RSI) and returns
# the result of raising the base (RDI) to the power of the exponent (RSI).
power:
    # no local variables
    enter $0, $0

    # base to the power of 0 is 1
    mov $1, %rax
    # number of times to multiply base by itself
    mov %rsi, %rcx
loop:
    mul %rdi
    loop loop

    # return value already in rax
    leave
    ret

# takes one parameter and uses that as the exit code.
exit:
    enter $0, $0
    mov $0x2000001, %rax
    # exit with the value in rdi
    syscall