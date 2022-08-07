#include <stdio.h>




int main(){

    int x1 , y1, restao;
    printf("Insira 2 numeros: ");
    scanf("%d %d", &x1, &y1); // 0  0
    restao = multiplo(&x1, &y1);

    if(restao == 0){
        printf("%d nao eh multiplo de %d \n", x1, y1);
    }else if(restao == 1){
        printf("%d eh multiplo de %d \n", x1, y1);
    }

    return 0;
}

int multiplo(int *x, int *y){
    //int x1 = *x, y1 = *y;
    int resto = *x % *y;

    if(resto != 0){
        return 0;
    }else{
        return 1;
    }
}