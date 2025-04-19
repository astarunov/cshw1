// gcc -mpreferred-stack-boundary=2 -z norelro -no-pie -fno-pic -g -fcf-protection=none -fno-stack-protector -m32 -    o retlib retlib.c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef BUF_SIZE
#define BUF_SIZE 12
#endif

const char shell[] = "/bin/sh";

void login() {
    char buffer[BUF_SIZE];

    scanf("%s",buffer);   
}


int main(int argc, char **argv) {
   printf("Try to get Shell!\n");
   printf("Can you get the system(%s)?\n", shell);

   login();

   return 1;
}
