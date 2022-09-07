# This program waits 5 seconds and exits.
.data
# variable to hold the currrent time
curtime:
    .quad 0x0

.text
.globl start
start:
    # initialize the current time
    movq $0x2000074, %rax       # sys call number for SYS_gettimeofday (116)
    leaq curtime(%rip), %rdi    # 1st and only parameter is a pointer to curtime
    syscall
    jc error

    # add 5 seconds to the start time and stash in rbx
    # we don't want to use any of the kernel interface registers for this.
    # So no %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, and %r11
    # We can use any of rbx, r12, r13, r14, r15
    movq curtime(%rip), %rbx
    addq $5, %rbx

mainloop:
    # repeatedly check current time
    movq $0x2000074, %rax
    leaq curtime(%rip), %rdi    # rdi says where to store the time value (curtime)
    syscall
    jc error

    # If the current time is less than the end time, loop
    cmpq %rbx, curtime(%rip)
    jb mainloop

end:
    movq $0, %rdi
    movq $0x2000001, %rax
    syscall

error:
    movq $0x2000001, %rax
    syscall
