# This program opens a file called "my-out.txt" and writes 
# two formated strings to the file.  Before exiting the file is closed.
.data
filename:
    .ascii "my-out.txt\0"
mode:
    .ascii "w\0"

format1:
    .ascii "The age of %s is %d.\n\0"
sallyname:
    .ascii "Sally\0"
sallyage:
    .quad 53

format2:
    .ascii "%d and %d are %s's favorite numbers.\n\0"
joshname:
    .ascii "Josh\0"
joshfavorite1:
    .quad 7
joshfavorite2:
    .quad 13

.text
.globl _main
_main:
    enter $16, $0
.equ FILE, -8

    # Open the file
    lea filename(%rip), %rdi
    lea mode(%rip), %rsi
    call _fopen

    # save the file pointer in a local variable
    mov %rax, FILE(%rbp)

    # write the first formatted string to the file
    mov FILE(%rbp), %rdi
    lea format1(%rip), %rsi
    lea sallyname(%rip), %rdx
    mov sallyage(%rip), %rcx
    # not passing floating point values to the function
    mov $0, %rax
    call _fprintf

    # write the second formatted string to the file
    mov FILE(%rbp), %rdi
    lea format2(%rip), %rsi
    mov joshfavorite1(%rip), %rdx
    mov joshfavorite2(%rip), %rcx
    lea joshname(%rip), %r8

    # not passing floating point values to the function
    mov $0, %rax
    call _fprintf

    # close the file
    mov FILE(%rbp), %rdi
    call _fclose
    # exit the program
    mov $0, %rax
    leave
    ret
