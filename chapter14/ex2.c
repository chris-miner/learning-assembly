/*
    This program takes a number of bytes from the user, allocates that
    ampoint of memory, null terminates it, and fills it with the letter
    'a'.  Then it prints the memory address of the allocated memory, and
    the contents of the memory.  Finally, the memory is released and the
    process is repeated until the user types -1 as the memory size.
 */

#include <stdio.h>
#include <stdbool.h>

void *allocate(int);
void deallocate(void *);

int main()
{
    while (true)
    {
        int bytes;
        fprintf(stdout, "Enter number of bytes to allocate: ");
        fscanf(stdin, "%d", &bytes);
        if (bytes == -1)
            break;

        char *a = allocate(bytes);
        for (int i = 0; i < bytes; i++)
            a[i] = 'a';
        a[bytes - 1] = '\0';

        fprintf(stdout, "Allocated %d bytes at address %p\n", bytes, a);
        fprintf(stdout, "Contents: %s\n", a);
        deallocate(a);
    }

    return 0;
}