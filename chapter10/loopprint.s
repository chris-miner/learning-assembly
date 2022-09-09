# this program loops ten times alternatingly prints
# one of two messages
.data
messages:
    .quad hello, bye

hello:
    .ascii "Hello\n\0"
bye:
    .ascii "Goodbye\n\0"


.text
.globl start
start:
    # we have registers 12 through 15 available for use
    # initialize loop counter to 10 and count down to 1
    mov $10, %r12

    # load the address of the messages array into %r13
    lea messages(%rip), %r13


mainloop:
    # set message index (odd or even)
    mov %r12, %r14
    and $1, %r14

    # Calculate length of current message
    # Search string for null terminator
    mov (%r13, %r14, 8), %rdi   # message address
    mov $0, %rax                # null terminator byte
    mov $-1, %rcx               # max number of bytes to search
    repne scasb
    dec %rdi                    # back up to end of message

    # subtract start of message from end of message to get length
    mov (%r13, %r14, 8), %rax
    subq %rax, %rdi
    mov %rdi, %r15              # message length

    # print message
    mov $0x2000004, %rax
    mov $1, %rdi
    mov (%r13, %r14, 8), %rsi
    mov %r15, %rdx
    syscall
    jc err

loopcontrol:
    # decrement loop counter
    dec %r12
    jnz mainloop    # loop 10–1 times

end:
    mov $0x2000001, %rax
    mov $0x0, %rdi
    syscall

err:
    mov $0x2000001, %rax
    mov $0x1, %rdi
    syscall