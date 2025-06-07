#include <stdio.h>

int main(){
    
    /*Faça um programa em C que leia dez números e imprima o maior e o menor entre eles.*/
    
    int num, maior, menor, i;
    
    printf("Insira 10 números \n");
    printf("1º : ");
    scanf("%i", &num);
    
    maior = num;
    menor = num;

    for(i = 2; i<=10; ++i){
        printf("%i º: ", i);
        scanf("%i", &num);

        if(num>maior){
            maior = num;
        }else if(num<menor){
            menor = num;
        }
    }

    printf("\nO menor número digitado foi: %i", menor);
    printf("\nO maior número digitado foi: %i", maior);

    return 0;
}