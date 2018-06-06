#include <stdio.h>
#include <stdlib.h>

int * a;
int * b;
int * c;
int stackA;
int stackB;
int stackC;

void hanoi();

int main() 
{
    int size = 5;

    a = (int *) calloc(size, sizeof(int));
    b = (int *) calloc(size, sizeof(int));
    c = (int *) calloc(size, sizeof(int));
    
//Hola

    stackA = 4;
    stackB = 0;
    stackC = 0;

    for(int i = 0; i < size; i++){
        a[i] = size - i;
    }

    hanoi();

    return 0; 
} 