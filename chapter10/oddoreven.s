#
# This program determines if the secret number is
# positive or negative, and prints out the appropriate
# message.  Orignally I thought I could use the jpe 
# instruction (jmp if parity), but it turns out that has
# nothing to do with odd/even parity.  Instead, I had to
# use a bitmask to determine if the number was odd or even.
#
.data
secret:
    .quad 0x23
odd:
    .ascii "The number is odd.\n"
.equ oddlen, .-odd
even:
    .ascii "The number is even.\n"
.equ evenlen, .-even

.text
.globl start
start:
    mov secret(%rip), %rax
    and $1, %rax
    jnz isodd
    jz iseven

isodd:
    movq $0x2000004, %rax
    movq $1, %rdi
    leaq odd(%rip), %rsi
    movq $oddlen, %rdx
    syscall
    jc error
    jmp end

iseven:
    movq $0x2000004, %rax
    movq $1, %rdi
    leaq even(%rip), %rsi
    movq $evenlen, %rdx
    syscall
    jc error
    jmp end

error:
    movq $0x2000001, %rax
    movq $-1, %rdi
    syscall

end:
    movq $0x2000001, %rax
    movq $0, %rdi
    syscall
