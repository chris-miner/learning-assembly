# This program calculates the result raising a base to a power using a function.
# the power function is defined as power(base, power) and implemented in power.s
.globl start
.text

# define some constants
.equ BASE, 3
.equ POWER, 4

start:    
    mov $BASE, %rdi
    mov $POWER, %rsi
    call power
    
    mov %rax, %rdi
    call exit
    

# takes one parameter and uses that as the exit code.
exit:
    enter $0, $0
    mov $0x2000001, %rax
    # exit with the value in rdi
    syscall