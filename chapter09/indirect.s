.data
target_pointer:
    .quad 0x0

.text
.globl start
start:
    # get the address of mytarget
    lea mytarget(%rip), %rax
    # store the address of mytarget in target_pointer
    movq %rax, target_pointer(%rip)

    # execute an indirect jump to the address stored in target_pointer
    jmp *target_pointer(%rip)
    
    # this line is not reached
    movq $12, %rdi

mytarget:
    # return the value 6
    movq $6, %rdi

finish:
    # set up exit syscall
    movq $0x2000001, %rax
    syscall