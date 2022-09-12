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
    # check the return code
    cmp $0, %rax
    je exit
    jne error

error:
    mov $0x2000001, %rax
    mov $1, %rdi
    syscall

exit:
    mov $0x2000001, %rax
    mov $0, %rdi
    syscall

myfunction:
    # step 1: stash previous stack frame pointer on the stack
    push %rbp

    # step 2: copy stack pointer to base pointer for a fixed reference *frame*
    mov %rsp, %rbp
    
    # step 3: allocate space for a local variable
    sub $8, %rsp

    # Alternatively, you can use enter for all three steps above
    # enter $8, $0

    # do some work
    movq $1, -8(%rbp)
    mov -8(%rbp), %rax
    mov $1, %rcx
loop:
    add $1, %rax
    loop loop

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
    # Step 1: set the return value (success)
    mov $0, %rax
    # Step 2: recover the return address from the stack
    pop %rcx
    # Step 3: jump to the return address
    jmp *%rcx