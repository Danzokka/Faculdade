#include <stdio.h>

void troca(int *x, int *y);

int main(){
    
    int blyat[2], v1, v2;

    printf("Insira o valor de X: ");
    scanf("%d", &v1);

    printf("Insira o valor de Y: ");
    scanf("%d", &v2);
    
    troca(&v1, &v2);
    
    return 0;
}

void troca(int *x, int *y){
    int x1 = *x;

    *x = *y;
    *y = x1;

}