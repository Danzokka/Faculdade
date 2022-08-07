#include <stdio.h>
#include <math.h>

int main(){
    
    float altura, distancia, seno;

    //input
    printf("Distância percorrida em metros: ");
    scanf("%f",&distancia);
    printf("Angulação: ");
    scanf("%f",&seno);

    //processamento de dados

    if (seno > 45){
        printf("Insira um valor menor que 45º");
    }else{
        seno = seno /M_PI;
        seno = sin(seno);
        altura = distancia * seno;
        printf("O avião está a %0.02f metros do solo",altura);
    }
    return 0;
} 