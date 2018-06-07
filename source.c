#include <stdio.h>
#include <stdlib.h>

int * a;
int * b;
int * c;
int stackA;
int stackB;
int stackC;
int size;

int stackPush(int * tower, int data);
int stackPop(int * tower);
void printTower(int * tower);
void hanoi(int n, int * source, int * target, int * aux);

int main() {
    size = 20;

    // Crean los arreglos
    a = (int *) calloc(size, sizeof(int));
    b = (int *) calloc(size, sizeof(int));
    c = (int *) calloc(size, sizeof(int));
    
    // Crean los apuntadores del stack
    stackA = size;
    stackB = 0;
    stackC = 0;

    // Init tower A
    for(int i = 0; i < size; i++){
        a[i] = size - i;
    }

    printTower(a);
    printTower(b);
    printTower(c);

    hanoi(size, a, c, b);

    printTower(a);
    printTower(b);
    printTower(c);

    return 0; 
} 

/**
 * Recusrive call 
 * 
 */
void hanoi(int n, int * source, int * target, int * aux){
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

int stackPush(int * tower, int data){
    if(tower == a){
        tower[stackA] = data;
        stackA++;
    }else if(tower == b){
        tower[stackB] = data;
        stackB++;
    }else{
        tower[stackC] = data;
        stackC++;
    }
}

int stackPop(int * tower){
    int ret;
    if(tower == a){
        if(stackA != 0)
            stackA--;
        ret = tower[stackA];
        tower[stackA] = 0;
    }else if(tower == b){
        if(stackB != 0)
            stackB--;
        ret = tower[stackB];
        tower[stackB] = 0;
    }else{
        if(stackC != 0)
            stackC--;
        ret = tower[stackC];
        tower[stackC] = 0;
    }
    return ret;
}