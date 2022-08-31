# calculate pow(rbx, rcx) rbx^rcx
.text
.globl start
start:
    # set up variables
    movq $3, %rbx # base
    movq $3, %rcx # power

    # initialize result to 1
    movq $1, %rax

    # loop through power (rcx)
loop:
    # exit program if power is 0
    cmpq $0, %rcx           # sets zero flag if power is 0
    je end                  # jump to end if zero flag is set

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