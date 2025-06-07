#include <stdio.h>
#include <math.h>
int main(){
    
    float a, b, c, delta, x1, x2, d;

    printf("A: ");
    scanf("%f",&a);
    printf("B: ");
    scanf("%f",&b);
    printf("C: ");
    scanf("%f",&c);

    delta = (b*b) - (4 * (a*c));

    d = sqrt(delta);

    x1 = (-b + d) / (2*a);

    x2 = (-b - d) / (2*a);

    printf("O delta da equação é %0.02f \n",delta);
    
    if (delta < 0){
        printf("A equação não possui raizes reais.");
    }else{
        printf("X1: %0.02f \n",x1);
        printf("X2: %0.02f \n",x2);
    }
    return 0;
}