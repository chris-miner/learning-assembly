# calculate pow(rbx, rcx) rbx^rcx
.text
.globl start
start:
    # set up variables
    movq $3, %rbx # base
    movq $3, %rcx # current exponent count

    # initialize accumulated result to 1
    movq $1, %rax

    # If exponent is 0, we are finished
    cmpq $0, %rcx 
    je end

powerloop:
    # multiply accumulated result by base
    mulq %rbx

    # decrement exponent count (rcx) and loop if not 0
    loop powerloop

# exit with result in %rax
end:
    movq %rax, %rdi
    movq $0x02000001, %rax
    syscall