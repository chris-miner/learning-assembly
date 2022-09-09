# compute the factorial of a number using the stack.  First push each 
# value we need to mulitply by onto the stack.  Then pop the stack and 
# mulitply until we get to zero.
.text
.equ NUMBER, 4
.equ INITIAL, 1

.globl start
start:
    mov $INITIAL, %ax
    mov $NUMBER, %cx

    # sentinel value to stop the multiplication loop
    push $0

# push 
pushloop:
    push %cx
    loop pushloop

# ax already contains the initial value of 1
mainloop:
    pop %bx
    cmp $0, %bx
    je end
    mul %bx
loopcontrol:
    jmp mainloop

end:
    mov %ax, %di
    mov $0x2000001, %rax
    syscall