#include <stdio.h>

int main(){
    
    float a,b,c,ma;

    //inputs
    printf("Número 1: ");
    scanf("%f",&a);
    printf("Número 2: ");
    scanf("%f",&b);
    printf("Número 3: ");
    scanf("%f",&c);
    
    //processamento de dados

    ma = (a + b + c) / 3;
    
    //output
    printf("A média aritmética de %0.2f, %0.2f e %0.2f é %0.02f", a, b, c, ma);

    return 0;
}