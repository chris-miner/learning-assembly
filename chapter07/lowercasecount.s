# Count the number of lowercase characters in the string
.global start
.data
mytext:
    .byte 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70, 0x71, 0x72, 0x73, 0x74, 0
    .ascii "This is a string of characters.\0"
    .ascii "abc\0"

.text
start:
    # Load the address of the string into rbx
    leaq mytext(%rip), %rbx

    # Load the current number of lc characters into rdi
    movq $0, %rdi

mainloop:
    # Load two characters into ax
    movq (%rbx), %rax

    # loop over the two characters
    mov $8, %rcx
checkloop:
    # Check if the low byte is the null terminator
    cmpb $0, %al
    je end

    # Check if the low byte is a lowercase letter
    cmpb $'a', %al
    jb checkloopcontrol

    cmpb $'z', %al
    ja checkloopcontrol

    # Increment the number of lowercase characters
    incq %rdi

checkloopcontrol:
    # x86 is little endian so we are going to rotate right to get the next character
    # rotating left would potentially skip the null terminator.
    rorq $8, %rax
    loop checkloop

mainloopcontrol:
    # Move to the next two characters
    addq $8, %rbx
    jmp mainloop

end:
    movq $0x2000001, %rax
    syscall

