.text
.globl start
start:
    # load up 25 in the accumulator
    movq $25, %rax
    jmp thelabel

somewhere:
    # move the accumulator value (11) to rdi for exit status
    movq %rax, %rdi
    jmp anotherlabel

label1:
    # add rbx (30) to rax (25) storing 55 in rax
    addq %rbx, %rax
    # move 5 into the bx register
    movq $5, %rbx
    jmp here

labellabel:
    syscall

anotherlabel:
    # exit with the value in rdi (11)
    movq $0x02000001, %rax
    jmp labellabel

thelabel:
    # move 25 from the accumulator to rbx
    movq %rax, %rbx
    jmp there

here:
    # divide rax (55) by rbx (5) storing the result in rax (11)
    divq %rbx
    jmp somewhere

there:
    # add 5 to the 25 in rbx
    addq $5, %rbx
    jmp label1

anywhere:
    jmp thelabel