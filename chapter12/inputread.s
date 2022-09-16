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
    # two local variables
    # the first is the base, the second is the exponent
    enter $16, $0
.equ BASE, -8
.equ EXP, -16
    movq $0, BASE(%rbp)
    movq $0, EXP(%rbp)

    # print the prompt
    lea prompt(%rip), %rdi
    mov $0, %rax
    call _printf

scan:
    # scan the numbers
    lea scanf_format(%rip), %rdi
    lea BASE(%rbp), %rsi
    lea EXP(%rbp), %rdx
    mov $0, %rax
    call _scanf

calc:
    # calculate result
    mov BASE(%rbp), %rdi
    mov EXP(%rbp), %rsi
    call _power

print:
    # print the result
    lea printf_format(%rip), %rdi
    mov BASE(%rbp), %rsi
    mov EXP(%rbp), %rdx
    mov %rax, %rcx
    mov $0, %rax
    call _printf

exit:
    # exit
    mov $0, %eax
    leave
    ret