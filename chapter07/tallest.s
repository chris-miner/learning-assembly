.globl start
.data
# In the book this is all in another file called persondata.s
# You can do that under linux, but not under macos.  The constants
# are misunderstood to be regular variables, rather than constants.
# So the assembler treats HEIGHT_OFFSET as an address (0x10) rather than
# a value (16).  So we have to put it all in one file.
# person record and fields
.globl PERSON_RECORD_SIZE
.equ PERSON_RECORD_SIZE, 0x28

.globl WEIGHT_OFFSET, HAIR_OFFSET, HEIGHT_OFFSET, AGE_OFFSET
.equ WEIGHT_OFFSET, 0x00
.equ SHOE_SIZE_OFFSET, 0x08
.equ HAIR_OFFSET, 0x10
.equ HEIGHT_OFFSET, 0x18
.equ AGE_OFFSET, 0x20

# array of person records
.globl people, numpeople
people:
    .quad 200, 10, 2, 74, 20
    .quad 280, 12, 2, 72, 44 # author
    .quad 225, 13, 3, 73, 54 # me
    .quad 150, 8, 1, 68, 30
    .quad 250, 14, 3, 75, 24
    .quad 250, 10, 2, 70, 11
    .quad 180, 11, 5, 69, 65
endpeople:

numpeople:
    .quad (endpeople - people) / PERSON_RECORD_SIZE 

.text
start:
    # initialize registers
    # base address of people array in %rbx
    leaq people(%rip), %rbx

    # record count in %rcx
    movq numpeople(%rip), %rcx

    # tallest yet found in %rdi
    movq $0, %rdi

    # pre-check loop
    cmpq $0, %rcx
    je finish

mainloop:
    # %rbx holds base address of people array
    # move value of current person height into %rax
    # movq HEIGHT_OFFSET(%rbx), %rdx
    movq HEIGHT_OFFSET(%rbx), %rax

    # compare to tallest yet found
    cmpq %rax, %rdi
    jge endloop

    # new tallest found
    movq %rax, %rdi

endloop:
    addq $PERSON_RECORD_SIZE, %rbx
    loop mainloop
    
finish:
    movq $0x2000001, %rax
    syscall

