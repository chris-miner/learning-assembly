# searches string for null-terminator, returns the length of the string.
.data

mystring:
    .ascii "This is my string\0"

.text
.globl start
start:
    # load the address of mystring
    leaq mystring(%rip), %rdi

    # we want to find the null terminator byte
    movb $0, %al

    # set the max number of characters to search
    # this ends up being the largest unsigned 64-bit integer (2^64 - 1)
    movq $-1, %rcx

    # repeat scasb (scan a string? a byte a time) until we find
    # the null terminator byte (%al)
    repne scasb

    # rdi now points to the byte after the null terminator
    decq %rdi

    # rdi - $mystring = length of string
    lea mystring(%rip), %rax
    subq %rax, %rdi

finish:
    movq $0x2000001, %rax
    syscall