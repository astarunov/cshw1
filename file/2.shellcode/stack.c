// gcc -z execstack -fno-stack-protector -m32 -no-pie -g -o stack stack.c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef BUF_SIZE
#define BUF_SIZE 100
#endif

void dump_to_buffer()
{
    char buffer[BUF_SIZE];
    /* This also can be checked by gdb */
    printf("Address of buffer[] inside bof():  0x%.8x\n", (unsigned)buffer);

    gets(buffer);       
}

int main(int argc, char **argv)
{
    printf("Could you get shell for me?\n");
    printf("I need your help\n");
	dump_to_buffer();

    printf("Unfortunatly, return successfully :(\n");
    return 1;
}
