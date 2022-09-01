.globl start
.data
# How many data elements we have
numberofnumbers: .quad 7

# The data elements themselves
mynumbers:
.quad 5, 20, 33, 80, 52, 10, 1

### This program will find the largest value in the array
.text
start:
    ### Initialize Registers ###
    # Put the number of elements of the array in %rcx
    movq numberofnumbers(%rip), %rcx

    # Put the address of the array in %rdx
    leaq mynumbers(%rip), %rdx

    # Use %rdi to hold the current-high value
    # Also use %rdi as our exit status code
    movq $0, %rdi

    ### Check Preconditions ###
    # If there are no numbers, stop
    cmp $0, %rcx
    je endloop

### Main Loop ###
myloop:
    # Get the next value of mynumbers indexed by %rcx with base %rdx
    # rcx goes from numberofnumbers to 1.  when rxc is zero we exit this loop.
    movq -8(%rdx,%rcx,8), %rax

    # If it is not bigger, go to the end of the loop
    cmp %rdi, %rax
    jbe loopcontrol
    # Otherwise, store this as the biggest element so far
    movq %rax, %rdi

loopcontrol:
    # Decrement %rcx and keep. exit loop if %rcx is zero
    loop myloop

### Cleanup and Exit ###
endloop:
    # We're done - rdi has the largest value exit with this status
    movq $0x2000001, %rax
    syscall
