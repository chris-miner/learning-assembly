# power takes two quad word unsigned arguments (RDI, RSI) and returns
# the result of raising the base (RDI) to the power of the exponent (RSI).
.globl power

.text

power:
    # power takes two quad word unsigned arguments (RDI, RSI) and returns
    # the result of raising the base (RDI) to the power of the exponent (RSI).
    # no local variables
    enter $0, $0

    # base to the power of 0 is 1
    mov $1, %rax
    # number of times to multiply base by itself
    mov %rsi, %rcx
loop:
    mul %rdi
    loop loop

    # return value already in rax
    leave
    ret
