# this program reads two numbers separated by a space from the console
# and prints the first raised to the power of the second.
.data
prompt:
    .ascii "Enter two numbers separated by a space: \0"

scanf_format:
    .ascii "%d %d\0"

printf_format:
    .ascii "%d raised to the power of %d is %d.\n\0"

.text
.globl _main
_main:
    # four local variables
    # BASE - the base of the power
    # EXP - the exponent to raise the base to
    # STDOUT - the file descriptor for stdout
    # STDIN - the file descriptor for stdin
    enter $32, $0
.equ BASE, -0x8
.equ EXP, -0x10
.equ STDIN, -0x18
.equ STDOUT, -0x20
    movq $0, BASE(%rbp)
    movq $0, EXP(%rbp)
	
    # get pointer to standard input
    movq ___stdinp@GOTPCREL(%rip), %rax
    # dereference the pointer to get standard input
    movq (%rax), %rax
    # store the address of stdin as a local variable
	movq %rax, STDIN(%rbp)

    # repeat for standard output
	movq ___stdoutp@GOTPCREL(%rip), %rax
    movq (%rax), %rax
	movq %rax, STDOUT(%rbp)

    # print the prompt
	movq STDOUT(%rbp), %rdi
    lea prompt(%rip), %rsi
    xor %al, %al
    # call *_fprintf@GOTPCREL(%rip)
    call _fprintf

scan:
    # scan the numbers
    movq STDIN(%rbp), %rdi
    lea scanf_format(%rip), %rsi
    lea BASE(%rbp), %rdx
    lea EXP(%rbp), %rcx
    xor %al, %al
    call _fscanf

calc:
    # calculate result
    mov BASE(%rbp), %rdi
    mov EXP(%rbp), %rsi
    call _power

print:
    # print the result
    movq STDOUT(%rbp), %rdi
    lea printf_format(%rip), %rsi
    mov BASE(%rbp), %rdx
    mov EXP(%rbp), %rcx
    mov %rax, %r8
    xor %al, %al
    call _fprintf

exit:
    # exit
    xor %al, %al
    leave
    ret