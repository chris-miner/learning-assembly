.globl _main
.data
scanformat:
    .ascii "%499s\0"

outformat:
    .ascii "%s\n\0"

.text
.equ LOCAL_BUFFER, -8
_main:
    # allocate space for the buffer pointer
    enter $16, $0

    # allocate the memory buffer
    movq $500, %rdi
    call _malloc
    movq %rax, LOCAL_BUFFER(%rbp)

    # scan the string from stdin
    movq ___stdinp@GOTPCREL(%rip), %rdi
    movq (%rdi), %rdi
    leaq scanformat(%rip), %rsi
    movq LOCAL_BUFFER(%rbp), %rdx
    xor %al, %al
    call _fscanf

    # print the string to stdout
    movq ___stdoutp@GOTPCREL(%rip), %rdi
    movq (%rdi), %rdi
    leaq outformat(%rip), %rsi
    movq LOCAL_BUFFER(%rbp), %rdx
    call _fprintf

    # free the memory buffer
    movq LOCAL_BUFFER(%rbp), %rdi
    call _free

    # return
    xor %rax, %rax
    leave
    ret

