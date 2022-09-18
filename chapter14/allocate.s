# Functions to allocate and deallocate memory.  Unfortunately, none of this works
# because it is based on a deprecated syscall, brk(0x2000045).  People suggest
# using mmap instead, but I don't think it is a plug and play alternative.
# register usage:
#   RDX - Size of memory to allocate
#   RSI - pointer to memory being examined
#   RCX - copy of memory_end
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
    # Save the amount requested into %rdx
    movq %rdi, %rdx
    # Actual amount needed is actually larger
    addq $HEADER_SIZE, %rdx
    # If we haven't initialized, do so
    cmpq $0, memory_start(%rip)
    je allocate_init

allocate_continue:
    movq memory_start(%rip), %rsi
    movq memory_end(%rip), %rcx

allocate_loop:
    # If we have reached the end of memory
    # we have to allocate new memory by # moving the break.
    cmpq %rsi, %rcx
    je allocate_move_break

    # is the next block available?
    cmpq $0, HDR_IN_USE_OFFSET(%rsi)
    jne try_next_block

    # is the next block big enough?
    cmpq %rdx, HDR_SIZE_OFFSET(%rsi)
    jb try_next_block

    # This block is great!
    # Mark it as unavailable
    movq $1, HDR_IN_USE_OFFSET(%rsi) # Move beyond the header
    addq $HEADER_SIZE, %rsi

    # Return the value
    movq %rsi, %rax
    ret

    try_next_block:
    # This block didn't work, move to the next one
    addq HDR_SIZE_OFFSET(%rsi), %rsi
    jmp allocate_loop

.globl _deallocate
_deallocate:
    # Free is simple - just mark the block as available
    movq $0, HDR_IN_USE_OFFSET - HEADER_SIZE(%rdi)
    ret

allocate_init:
    # find program break
    xor %rdi, %rdi
    mov $BRK_SYSCALL, %rax
    syscall

    # current break is start and end of our memory
    mov %rax, memory_start(%rip)
    mov %rax, memory_end(%rip)
    jmp allocate_continue

allocate_move_break:
    # Old break is saved in %r8 to return to user
    movq %rcx, %r8

    # Calculate where we want the new break to be # (old break + size)
    movq %rcx, %rdi
    addq %rdx, %rdi
    # Save this value
    movq %rdi, memory_end(%rip)

    # Tell Linux where the new break is
    movq $BRK_SYSCALL, %rax
    syscall

    # Address is in %r8 - mark size and availability
    movq $1, HDR_IN_USE_OFFSET(%r8)
    movq %rdx, HDR_SIZE_OFFSET(%r8)

    # Actual return value is beyond our header
    addq $HEADER_SIZE, %r8
    movq %r8, %rax
    ret