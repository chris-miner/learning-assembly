# Functions to allocate and deallocate memory.  Initially, none of this worked
# for a couple reasons:
# 
# First, it was based on a deprecated syscall, brk(0x2000045).  This syscall
# is deprecated in the sense that it doesn't exist anymore as something you can
# invoke via the syscall instruction.  However, you can still call sbrk as a
# library function, and it will work.
# 
# Second, the register usage (rdx, rsi, rcx) assumed we were using the syscall
# instruction and these registers would have been preserved.  RCX isn't preserved
# by either a syscall instruction or a function call.  So I don't think that would
# have worked anyhow.  These registers have been swapped out for r12, r13, and r14.

# register usage:
#   r12 - Size of memory to allocate
#   r13 - pointer to memory being examined
#   r14 - copy of memory_end
.data
memory_start:
    .quad 0
memory_end:
    .quad 0

.text
#define HEADER_SIZE 16
#define HDR_IN_USE_OFFSET 0
#define HDR_SIZE_OFFSET 8

#define BRK_SYSCALL 0x2000045

.globl _allocate
_allocate:
    # Save the amount requested into %r12
    movq %rdi, %r12
    # Actual amount needed is actually larger
    addq $16, %r12
    # If we haven't initialized, do so
    cmpq $0, memory_start(%rip)
    je allocate_init

allocate_continue:
    movq memory_start(%rip), %r13
    movq memory_end(%rip), %r14

allocate_loop:
    # If we have reached the end of memory
    # we have to allocate new memory by # moving the break.
    cmpq %r13, %r14
    je allocate_move_break

    # is the next block available?
    cmpq $0, 0(%r13)
    jne try_next_block

    # is the next block big enough?
    cmpq %r12, 8(%r13)
    jb try_next_block

    # This block is great!
    # Mark it as unavailable
    movq $1, 0(%r13) # Move beyond the header
    addq $16, %r13

    # Return the value
    movq %r13, %rax
    ret

    try_next_block:
    # This block didn't work, move to the next one
    addq 8(%r13), %r13
    jmp allocate_loop

.globl _deallocate
_deallocate:
    # Free is simple - just mark the block as available
    movq $0, 0 - 16(%rdi)
    ret

allocate_init:
    # find program break
    xor %rdi, %rdi
    # mov $BRK_SYSCALL, %rax
    # syscall
    call _sbrk

    # current break is start and end of our memory
    mov %rax, memory_start(%rip)
    mov %rax, memory_end(%rip)
    jmp allocate_continue

allocate_move_break:
    # Old break is saved in %r8 to return to user
    movq %r14, %r8

    # Calculate where we want the new break to be # (old break + size)
    movq %r14, %rdi
    addq %r12, %rdi
    # Save this value
    movq %rdi, memory_end(%rip)

    # Tell Linux where the new break is
    # movq $BRK_SYSCALL, %rax
    # syscall
    call _sbrk

    # Address is in %r8 - mark size and availability
    movq $1, 0(%r8)
    movq %r12, 8(%r8)

    # Actual return value is beyond our header
    addq $16, %r8
    movq %r8, %rax
    ret