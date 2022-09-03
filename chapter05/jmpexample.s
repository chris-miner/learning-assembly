.text
.globl start

# This program returns 7 rather than 15 because of the jump instruction
start:
    movq $7, %rdi
    jmp nextplace

    # These two instructions are skipped
    movq $8, %rbx
    addq %rbx, %rdi

nextplace:
    # exit(0)
    movq $0x02000001, %rax
    syscall
