#include <stdio.h>
int main(){
    
    int seg, min, h, resto;

    printf("Tempo em segundos: ");
    scanf("%d",&seg);

    h = seg / 3600;
    resto = seg % 3600;
    min = resto / 60;
    seg = resto % 60;

    printf("Equivale a %d horas, %d minutos e %d segundos.",h,min,seg);
    
    
    return 0;
}