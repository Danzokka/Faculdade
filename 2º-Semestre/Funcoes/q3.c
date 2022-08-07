#include <stdio.h>

float Max(float x, float y, float w);

int main(){
    
    float maiorzao, v1, v2, v3;

    printf("Insira o valor de X: ");
    scanf("%f", &v1);

    printf("Insira o valor de Y: ");
    scanf("%f", &v2);

    printf("Insira o valor de W: ");
    scanf("%f", &v3);
    
    maiorzao = Max(v1, v2, v3);

    printf("O maior valor eh %f", maiorzao);
    
    return 0;
}

float Max(float x, float y, float w){
    float maior;
    if (x > y && x > w){
        maior = x;
    }else if(y > x && y > w){
        maior = y;
    }else{
        maior = w;
    }
    return maior;
}