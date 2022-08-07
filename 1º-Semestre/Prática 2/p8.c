#include <stdio.h>
#include <math.h>

int main(){
    
    float x1, x2, y1, y2, distancia;
    
    //inputs
    printf("X1: ");
    scanf("%f",&x1);
    printf("X2: ");
    scanf("%f",&x2);
    printf("Y1: ");
    scanf("%f",&y1);
    printf("Y2: ");
    scanf("%f",&y2);
    
    //processamento de dados

    distancia = sqrt( pow(x2-x1,2) + pow (y2-y1, 2));

    //output

    printf("A distância entre esses pontos é %0.02f",distancia);

    return 0;
}