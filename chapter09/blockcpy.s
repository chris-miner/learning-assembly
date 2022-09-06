# copy source array to destination.  Here we have two arrays
# of quad-word integers, and we want to copy the source array
# to the destination array.  We use the "rep movsq" instruction
# to do this.  The "rep" prefix tells the processor to repeat
# the instruction as many times as specified by the "*cx"
# register.
.data
src:
    .quad 9, 23, 55, 1, 3

dst:
    .quad 0, 0, 0, 0, 0

.text
.globl start
start:
    leaq src(%rip), %rsi
    leaq dst(%rip), %rdi

    movq $5, %rcx
    rep movsq

finish:
    # load the exit code into rax
    movq $0x2000001, %rax
    syscall