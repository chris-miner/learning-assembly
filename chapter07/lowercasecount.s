# Count the number of lowercase characters in the string
.global start
.data
mytext:
    .ascii "abc\0"
    .byte 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70, 0x71, 0x72, 0x73, 0x74, 0
    .ascii "This is a string of characters.\0"

.text
start:
    # Load the address of the string into rbx
    leaq mytext(%rip), %rbx

    # Load the current number of lc characters into rdi
    movq $0, %rdi

mainloop:
    # Load the current character into al
    movb (%rbx), %al

    # Check if the current character is the null terminator
    cmpb $0, %al
    je end

    # Check if the current character is a lowercase letter
    cmpb $'a', %al
    jb notlowercase

    cmpb $'z', %al
    ja notlowercase

lowercase:
    # Increment the number of lowercase characters
    incq %rdi

notlowercase:
    incq %rbx
    jmp mainloop

end:
    movq $0x2000001, %rax
    syscall

