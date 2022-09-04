.text
.globl start
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
    addq $32, %rbx
    loop mainloop
    
finish:
    movq $0x2000001, %rax
    syscall

.data

# In the book this is all in another file called persondata.s
# You can do that under linux, but not under macos.  The constants
# are misunderstood to be regular variables, rather than constants.
# So the assembler treats HEIGHT_OFFSET as an address (0x10) rather than
# a value (16).  So we have to put it all in one file.
# person record and fields
.globl PERSON_RECORD_SIZE
.equ PERSON_RECORD_SIZE, 32

.globl WEIGHT_OFFSET, HAIR_OFFSET, HEIGHT_OFFSET, AGE_OFFSET
.equ WEIGHT_OFFSET, 0
.equ HAIR_OFFSET, 8
.equ HEIGHT_OFFSET, 16
.equ AGE_OFFSET, 24

# array of person records
.globl people, numpeople
people:
    .quad 200, 2, 74, 20
    .quad 280, 2, 72, 44 # author
    .quad 225, 3, 73, 54 # me
    .quad 150, 1, 68, 30
    .quad 250, 3, 75, 24
    .quad 250, 2, 70, 11
    .quad 180, 5, 69, 65
endpeople:

numpeople:
    .quad (endpeople - people) / PERSON_RECORD_SIZE 
