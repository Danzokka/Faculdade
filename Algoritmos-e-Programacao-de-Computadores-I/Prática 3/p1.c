#include <stdio.h>

int main(){
    
    //Faça um programa em C que determine se um número inteiro lido é par ou ímpar.
    
    int num, input;

    printf("Digite um número: ");
    scanf("%i",&input);

    num = input % 2;

    if(num == 0){
        printf(" %i é um número par", input);
    }else{
        printf(" %i é um número ímpar",input);
    }

    return 0;
}

