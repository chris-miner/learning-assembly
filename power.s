# calculate pow(rbx, rcx) rbx^rcx
.text
.globl start
start:
    # set up variables
    movq $15, %rbx # base
    movq $4, %rcx # power

    # initialize result to 1
    movq $1, %rax

    # loop through power (rcx)
loop:
    # check if power is 0
    addq $0, %rcx
    jz end

    # rax = rax * rbx
    mulq %rbx

    # decrement power (rcx)
    decq %rcx
    jmp loop

# exit with result in %rax
end:
    movq %rax, %rdi
    movq $0x02000001, %rax
    syscall