.text
.globl start
start:
    jmp third

first:
    movw $0b0000000100000010, %bx   # 16 bit value is a word
    addb %bh, %bl                   # add high byte to low byte (1+2) and store in low byte
    movb $0, %bh                   # clear high byte

    movq %rbx, %rdi                 # push result into return value
    movq $0x02000001, %rax         # exit trap
    syscall

second:
    movw $0b0000000100000010, %cx   # 16 bit value is a word
    addb %ch, %cl                   # add high byte to low byte (1+2) and store in low byte
    # movb $0, %ch                   # clear high byte
    
    movw %cx, %di                 # push result into return value
    # this seems like is should return 259, but it returns 3
    # exit codes are one byte.  So clearning high byte is not necessary
    # but is more explicit

    movq $0x02000001, %rax         # exit trap
    syscall

third:
    movb $1, %al                   # set low byte to 1
    movb $2, %bl                   # set low byte to 2
    addb %al, %bl                  # add low bytes (1+2) and store in low byte


    movw %bx, %di                  # no high/low bite on di register, so we move a word
    movq $0x02000001, %rax         # exit trap
    syscall

fourth:
    movq $5, %ax
    movq $0x02000001, %rax         # exit trap
    syscall