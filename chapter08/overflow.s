.data
first:
    .byte 127
second:
    .byte 127

.text
.globl start
start:
    movb first(%rip), %al
    movb second(%rip), %ah
    movb $0, %dil

    addb %al, %ah
    
    jno finish
    movb $1, %dil

finish:
    movq $0x2000001, %rax
    syscall