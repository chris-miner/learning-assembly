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

    # initialize the current time
    movq $0x2000074, %rax       # sys call number for SYS_gettimeofday (116)
    leaq curtime(%rip), %rdi    # 1st and only parameter is a pointer to curtime
    syscall
    jb error

    # add 5 seconds to the start time and stash in rbx
    movq curtime(%rip), %rbx
    addq $5, %rbx

    movq $0x2000074, %rax       # sys call number for SYS_gettimeofday (116)
    leaq curtime(%rip), %rdi    # 1st and only parameter is a pointer to curtime
    syscall
    jb error


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
