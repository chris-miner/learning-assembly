.globl start
.data

# our array of numbers
numbers:
    .quad 5, 20, 33, 80, 52, 10, 1

# the length of the array of numbers
length:
    .quad 7

.text
start:
    # initialize registers
    # number of items goes in the counter register
    # book's solution is to use 32-bit absolute addressing e.g. 'movq length, %rcx'
    # which is not supported in 64-bit mode.  At least on osx.
    movq length(%rip), %rcx

    # address of the array of numbers goes in the rbx register
    # book used different addressing e.g. 'movq $numbers, %rbx'
    # assembler didn't like this use of 32-bit absolute addressing 
    # so I tried 'movq $numbers(%rip), %rbx'  but it didn't work.
    # after some googling, lea is the instruction that does the same thing.
    lea numbers(%rip), %rbx

    # initialize our return value to zero
    movq $0, %rdi
    # If there are no numbers, we are finished.
    cmpq $0, %rcx
    je end

mainloop:
    # get the next value in the array pointed at by rbx
    movq (%rbx), %rax

    # compare to our existing value in rdi
    cmp %rdi, %rax
    # If the new value (rax) is below the existing value (rdi) continue.
    jbe loopcontrol

    # otherwise, update the existing value (rdi) to the new value (rax)
    movq %rax, %rdi

loopcontrol:
    # increment the pointer to the array of numbers by a quad-word
    addq $8, %rbx
    # decrement rcx and loop if there are more numbers to process
    loop mainloop
    
end:
    # return the largest value in rdi and exit
    movq $0x02000001, %rax
    syscall
