#include <stdio.h>

int main(){

    float x, tf;
    
    //inputs
    printf("Temperatura em graus Celsius: ");
    scanf("%f",&x);

    //processamento de dados
    tf = x * (9/5) + 32;

    //output
    printf("%0.02f ºC equivale a %0.02f ºF",x,tf);
    
    
    return 0;
}