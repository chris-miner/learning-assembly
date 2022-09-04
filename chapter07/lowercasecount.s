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
    # Load two characters into ax
    movw (%rbx), %ax

lowcheck:
    # Check if the low byte is the null terminator
    cmpb $0, %al
    je end

    # Check if the low byte is a lowercase letter
    cmpb $'a', %al
    jb highcheck

    cmpb $'z', %al
    ja highcheck

    # Increment the number of lowercase characters
    incq %rdi

highcheck:
    # Check if the high byte is the null terminator
    cmpb $0, %ah
    je end

    # Check if the high byte is a lowercase letter
    cmpb $'a', %ah
    jb loopcontrol

    cmpb $'z', %ah
    ja loopcontrol

    # Increment the number of lowercase characters
    incq %rdi

loopcontrol:
    # Move to the next two characters
    addq $2, %rbx
    jmp mainloop

end:
    movq $0x2000001, %rax
    syscall

