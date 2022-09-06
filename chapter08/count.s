# count the number of true bits in a register

.data
value:
    .byte 0b10101110 

.text
.globl start
start:
    # initialize values
    movb value(%rip), %al
    movb $8, %cl

mainloop:
    # compare the lowest bit to 1
    testb $0b00000001, %al
    jz loopcontrol

    incb %dil

loopcontrol:
    # rotate the register right one bit
    rorb $1, %al
    loop mainloop

finish:
    movq $0x2000001, %rax
    syscall