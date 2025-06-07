#include <stdio.h>

int main(){
    
    /*Faça um programa em C que calcule o fatorial de um número inteiro.*/
    
    int input,fatorial, i;
    
    printf("Digite um número: ");
    scanf("%d",&input);

    fatorial = input;

    for (i = 1; i <= fatorial; i++)
    {
        fatorial = fatorial * i; 
    }
    printf("O Fatorial de %d é: %d",input, fatorial);
    
    return 0;
}