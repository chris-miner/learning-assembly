/*
    chapter 14 exercise 1
    Write a program that takes a number of bytes from the user,
    allocates that amount of memory, null terminates it, and fills
    it with the letter 'a'.

    Then it should print the memory address of the allocated memory,
    and the contents of the memory.
*/
#include <stdio.h>

void *allocate(int);
void deallocate(void *);

int main()
{
    int bytes;
    fprintf(stdout, "Enter number of bytes to allocate: ");
    fscanf(stdin, "%d", &bytes);

    char *a = allocate(bytes);
    for (int i = 0; i < bytes; i++)
        a[i] = 'a';
    a[bytes - 1] = '\0';

    fprintf(stdout, "Allocated %d bytes at address %p\n", bytes, a);
    fprintf(stdout, "Contents: %s\n", a);
    deallocate(a);
    return 0;
}