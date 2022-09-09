.data
string1:
    .ascii "This is the first string\n"
end1:
.equ length1, .-string1

string2:
    .ascii "This is the second string\n"
end2:
.equ length2, .-string2

.text
.globl start
    start:
    # write out the first string
    mov $0x2000004, %rax
    mov $1, %rdi
    lea string1(%rip), %rsi
    mov $length1, %rdx
    syscall
    jc error

    # write out the second string
    mov $0x2000004, %rax
    mov $1, %rdi
    lea string2(%rip), %rsi
    mov $length2, %rdx
    syscall
    jc error

end:
    mov $0, %rdi
    mov $0x2000001, %rax
    syscall

error:
    mov $1, %rdi
    mov $0x2000001, %rax
    syscall