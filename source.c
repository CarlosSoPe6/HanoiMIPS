#include <stdio.h>
#include <stdlib.h>

int * a;
int * b;
int * c;
int stackA;
int stackB;
int stackC;
int size;

int stackPush(int ** tower, int data);
int stackPop(int ** tower);
void printTower(int * tower);
void hanoi(int n, int ** source, int ** target, int ** aux);

int main() {
    int * base;

    size = 20;

    // Crean los arreglos
    a = (int *) calloc(size, sizeof(int));
    b = (int *) calloc(size, sizeof(int));
    c = (int *) calloc(size, sizeof(int));
    base = c;

    // Init tower A
    for(int i = 0; i < size; i++){
        a[i] = size - i;
    }

    a += size;

    hanoi(size, &a, &c, &b);
    printf("Tower:\n");
    printTower(base);

    return 0; 
} 

/**
 * Recusrive call 
 * 
 */
void hanoi(int n, int ** source, int ** target, int ** aux){
    if(n > 0){
        hanoi(n - 1, source, aux, target);
        int d = stackPop(source);
        stackPush(target, d);
        hanoi(n - 1, aux, target, source);
    }
}

void printTower(int * tower){
    for(int j = 0; j < size; j++){
        printf("%d ", tower[j]);            
    }
    printf("\n");
}

int stackPush(int ** tower, int data){
    **tower = data;
    *tower = (*tower) + 1;
}

int stackPop(int ** tower){
    int ret;
    *tower = (*tower) - 1;
    ret = **tower;
    return ret;
}