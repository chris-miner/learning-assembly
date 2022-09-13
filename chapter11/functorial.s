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
.equ RESULT, -8

    # base case - the number is 0 or 1. return 1
    mov $1, %rax
    cmp $1, %rdi
    jbe factorial_end
    
    # compound case - the number is greater than 1.
    # stash the number and call factorial(number - 1)
    mov %rdi, RESULT(%rbp)

    # call factorial on number - 1
    dec %rdi
    call factorial
 
    # RAX has the result of the recursive call
    # mulitply the result of the recursive call by the number
    mulq RESULT(%rbp)
 
 factorial_end:
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