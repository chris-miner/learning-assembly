# this program calls the abs function in the standard library.
# it takes a number as an argument and returns the absolute value of that number.
# the abs function is a built-in function in the standard library.
# Note that on osx, you can't statically link against the standard (system) library.
# to assemble/link this program you have to do something like this:
# as -g -o abscall.o abscall.s
# ld -o abscall abscall.o -lSystem -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
# this will link against the system library, which is the libSystem.dylib
# Alternatively, you can use:
# clang -g -o abscall abscall.s
.text
.equ NUMBER, -5

# Using _main here because we can't statically link against the standard library.
# This means we have to use a shared (dynamically loaded on osx) standard library.
# With a shaed library, we need to let start (defined elsewhere) run certain 
# setup functions before executing our program.  Start is still the entry point,
# and our program, the _main function, will be called.
.globl _main
_main:
    mov $NUMBER, %rdi
    call _abs

    # Return value is in rax.  Since we are dynamically linked, and were
    # called from the system lib start function, we can use ret instead
    # of setting up a exit syscall.  The system library will take care of 
    # exiting, cleaning up, etc. and returing the value in rax to the shell.
    ret