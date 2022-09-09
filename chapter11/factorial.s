# compute the factorial of a number using the stack.  First push each 
# value we need to mulitply by onto the stack.  Then pop the stack and 
# mulitply until we get to zero.
.text
.equ NUMBER, 4

.globl start
start:
    # sentinel value to stop the multiplication loop
    pushq $0

# push NUMBER ... 1 onto the stack
    movq $NUMBER, %rcx
pushvalues:
    pushq %rcx
    loop pushvalues

# set the result to 1
    movq $1, %rax
multiply:
    # get the value on the top of the stack
    popq %rbx

    # check for sentinel value
    cmpq $0, %rbx
    je end

    # multiply the value on the stack by the value in %ax
    mulq %rbx
    jmp multiply

end:
    movq %rax, %rdi
    movq $0x2000001, %rax
    syscall