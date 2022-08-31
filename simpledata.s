.globl start

.section __DATA, __data # alternative to .data directive
first_value:
    .quad 4
second_value:
    .quad 6
final_result:
    .quad 0

.section __TEXT, __text # alternative to .text directive
start:
    # load values from memory into registers
    movq first_value(%rip), %rbx
    movq second_value(%rip), %rcx

    # add the values
    addq %rbx, %rcx

    # store result in memory (final_result)
    movq %rcx, final_result(%rip)

    # pull result from memory and return it
    movq final_result(%rip), %rdi
    movq $0x02000001, %rax
    syscall