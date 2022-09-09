# compute the factorial of a number using the stack.  First push each 
# value we need to mulitply by onto the stack.  Then pop the stack and 
# mulitply until we get to zero.
.text
.equ NUMBER, 4
.equ INITIAL, 1

.globl start
start:
    # sentinel value to stop the multiplication loop
    push $0

# push NUMBER ... 1 onto the stack
    mov $NUMBER, %cx
pushloop:
    push %cx
    loop pushloop

# set the result to 1
    mov $INITIAL, %ax
mainloop:
    # get the value on the top of the stack
    pop %bx

    # check for sentinel value
    cmp $0, %bx
    je end

    # multiply the value on the stack by the value in %ax
    mul %bx
    jmp mainloop

end:
    mov %ax, %di
    mov $0x2000001, %rax
    syscall