// gcc -fno-stack-protector -m32 -no-pie -g -o stack stack.c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifndef BUF_SIZE
#define BUF_SIZE 100
#endif

void login(char *str)
{
    char buffer[BUF_SIZE];
    unsigned int *framep;

    strcpy(buffer, str);       
}

void authenticated() 
{
    printf("Congratulations!\n");
    printf("You passed the first level\n");
    exit(0); 
}

int main(int argc, char **argv)
{
    char input[1000];
    FILE *badfile;

    badfile = fopen("badfile", "r"); 
    int length = fread(input, sizeof(char), 1000, badfile);

    printf("Can you beat me?\n");
    
	login(input);

    printf("Unfortunately, return successfully :(\n");
    return 1;
}
