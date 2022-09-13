# power takes two quad word unsigned arguments (RDI, RSI) and returns
# the result of raising the base (RDI) to the power of the exponent (RSI).
.globl _power

.text

_power:
    # RDI = BASE
    # RSI = EXPONENT
    # returns BASE^EXPONENT in RAX

    # local variables.
    # -8(%rbp) = counter (for loop) initialized to EXPONENT
    enter $16, $0

    # base to the power of 0 is 1
    mov $1, %rax

    # number of times to multiply base by itself
    mov %rsi, -8(%rbp)

mainloop:
    # multiply base by itself
    mulq %rdi

    # decrement counter
    decq -8(%rbp)
    jnz mainloop

    # return value already in rax
    leave
    ret
