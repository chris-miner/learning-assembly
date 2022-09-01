# program to find the target number in the list and return 1 if found and 0 if not found
.globl start
.data
    length: .quad 7
    numbers: .quad 1, 2, 3, 4, 5, 6, 7
    target: .quad 3

.text
start:
    ## initialize variables
    # base address of array
    lea numbers(%rip), %rbx

    # index and loop counter
    movq length(%rip), %rcx

    # by default we assume the number is not found
    movq $0, %rdi

    # If no numbers, we are finished
    cmpq $0, %rcx
    je exit

loopstart:
    # load the current number
    # rcx goes from 7 to 1, but we need to load 6 to 0
    # so we subtract 1 qword from the address
    movq -8(%rbx, %rcx, 8), %rax

    # compare it to the target
    cmpq target(%rip), %rax
    # when not equal, continue searching
    jne loopend

    # otherwise, we found it and can exit
    movq $1, %rdi
    jmp exit

loopend:
    loop loopstart

exit:
    movq $0x2000001, %rax
    syscall
