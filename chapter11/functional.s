# an example of a function that returns a value
.text
.globl start
start:
    push %rbp
    mov %rsp, %rbp

    # Call the function
    # Step 1: Get the address of where to continue execution after the call
    lea next_instruction_address(%rip), %rbx
    # Step 2: Stash the address on the stack
    push %rbx
    # Step 3: "Call" the function
    jmp myfunction

next_instruction_address:
    # check the return value negative means failure
    cmp $0, %rax
    jae exit
    jb error

error:
    mov $-1, %rdi
    mov $0x2000001, %rax
    syscall

exit:
    mov %rax, %rdi
    mov $0x2000001, %rax
    syscall

myfunction:
    # step 1: stash previous stack frame pointer on the stack
    push %rbp

    # step 2: copy stack pointer to base pointer for a fixed reference *frame*
    mov %rsp, %rbp
    
    # step 3: allocate space for a local variable
    # we only need 8 bytes, but we need to align the stack to 16 bytes
    sub $16, %rsp

    # Alternatively, you can use enter for all three steps above
    # enter $8, $0

    # do some work
    movq $1, -8(%rbp)
    movq $2, %rcx
loop:
    addq $1, -8(%rbp)
    loop loop

    # Set the return value
    movq  -8(%rbp), %rax
    
leave:
    # Unwind stack frame
    # step 1: restore stack pointer
    mov %rbp, %rsp
    # step 2: restore base pointer
    pop %rbp

    # Alternatively, you can use leave for both steps above
    # leave

return:
    # finally return to caller
    # Step 1: recover the return address from the stack
    pop %rcx
    # Step 2: jump to the return address
    jmp *%rcx