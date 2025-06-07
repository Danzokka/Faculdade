#include <stdio.h>

int main(){

    float l, c, h;

    //inputs
    printf("Largura: ");
    scanf("%f",&l);
    printf("Comprimento: ");
    scanf("%f",&c);

    //processamento de dados
    
    h = (l * c)/10000;
    
    //output
    printf("A área em hectares é %0.02f m^2",h);
    
    return 0;
}