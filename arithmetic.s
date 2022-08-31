.text
.global start
start:
    # put 3 in rdi (destination index register)
    movq $3, %rdi
    
    # move rdi to rax (accumulator register)
    # now both registers have 3 in them
    movq %rdi, %rax

    # add 3 and 3 and put result in rax (6)
    addq %rdi, %rax
    
    # multiply 3 by 6 (rax) and put result in rax (18)
    mulq %rdi
    
    # put 2 in rdi
    movq $2, %rdi

    # add rdi(2) and rax(18) and put result in rax (20)
    addq %rdi, %rax

    # put 4 in rdi
    movq $4, %rdi

    # multiply rax(20) by 4 and put result in rax (80)
    mulq %rdi

    # move rax(80) to rdi as a return value
    movq %rax, %rdi
    
    # exit system call in rdi
    movq $0x02000001, %rax
    syscall
