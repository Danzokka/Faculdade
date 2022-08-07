#include <stdio.h>
int main(){
    
    int base, altura, area;
    printf("Base: ");
    scanf("%d",&base);
    printf("Altura: ");
    scanf("%d",&altura);

    area = (base * altura) / 2;

    printf("A área desse triangulo é: %d",area);

}