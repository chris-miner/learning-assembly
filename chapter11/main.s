# This program calculates the result raising a base to a power using a function.
# the power function is defined as power(base, power) and implemented in power.s
.globl _main
.text

# define some constants
.equ BASE, 3
.equ POWER, 4

_main:    
    mov $BASE, %rdi
    mov $POWER, %rsi
    call _power
    
    mov %rax, %rdi
    call _exit
    

# takes one parameter and uses that as the exit code.
_exit:
    enter $0, $0
    mov $0x2000001, %rax
    # exit with the value in rdi
    syscall