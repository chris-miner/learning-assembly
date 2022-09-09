# Print out a string 10 times.  I could have used r12 directly for
# the loop counter, decremented it myself in loopcontrol, manually
# did the conditional loop.  However, I wanted to highlight the fact
# that rcx (and r11) are clobbered by any syscall.
.data
msg:
    .ascii "Hello World\n"
msgend:
.equ len, . - msg


.text
.globl start
start:
    # set up loop counter used by loop instruction
    mov $10, %rcx

mainloop:
    mov $0x2000004, %rax
    mov $1, %rdi
    lea msg(%rip), %rsi
    mov $len, %rdx
    mov %rcx, %r12         # preserve rcx which is clobbered by syscall
    syscall
    mov %r12, %rcx         # restore rcx which was clobbered by syscall
    jc err
    loop mainloop

end:
    mov $0x2000001, %rax
    mov $0, %rdi
    syscall

err:
    mov $0x2000001, %rax
    mov $1, %rdi
    syscall
