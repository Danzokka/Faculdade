#include <stdio.h>

int main(){
    
    float h, p, imc;
    
    //input
    printf("Altura: ");
    scanf("%f",&h);
    printf("Peso: ");
    scanf("%f",&p);

    //processamento de dados

    imc = p / (h*h);

    //output
    printf("O seu IMC é %0.02f",imc);
    
    return 0;
}