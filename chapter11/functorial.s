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
    # RDI = NUMBER.

    # local variables
    # this is gratuitous, but I'm doing it to use the stack for temporary storage
    enter $16, $0
.equ LOCAL_NUMBER, -8

    # When NUMBER is 0 or 1 return the base case (1).
    cmp $1, %rdi
    jbe base_case
    # when NUMBER is 2 or more return the recursive case (NUMBER * FACTORIAL(NUMBER - 1))
    ja recursive_case

base_case:
    mov $1, %rax
    jmp return

recursive_case:
    # stash the number on the stack and call factorial(number - 1)
    mov %rdi, LOCAL_NUMBER(%rbp)

    # call factorial on number - 1
    dec %rdi
    call factorial
 
    # mulitply the result (RAX) by the number we stashed earlier
    mulq LOCAL_NUMBER(%rbp)
 
 return:
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