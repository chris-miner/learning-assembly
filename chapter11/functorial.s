# program to calculate the factorial of a number using a function
.equ INPUT_NUMBER, 5

.text
.globl start
start:
    enter $0, $0
    mov $INPUT_NUMBER, %rdi
    call factorial

    # exit with result as status code
    mov %rax, %rdi
    call exit

factorial:
    # This function takes one argument and returns the factorial of that number.
    # RDI = number to calculate factorial of.

    # local variables
    # this is gratuitous, but I'm doing it to use the stack for temporary storage
    enter $16, $0
.equ COUNTER, -8

    mov $1, %rax
    mov %rdi, COUNTER(%rbp)

loop:
    mulq COUNTER(%rbp)
    decq COUNTER(%rbp)
    jne loop

    # return the result
    # RAX = result
    leave
    ret


exit:
    enter $0, $0
    # RDI is already set by the caller
    mov $0x2000001, %rax
    syscall
    # this code is never reached
    leave
    ret