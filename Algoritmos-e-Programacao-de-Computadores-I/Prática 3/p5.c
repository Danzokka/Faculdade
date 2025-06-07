#include <stdio.h>

int main(){
    
    /*Faça um programa em C que leia um ano
    e verifique se ele é bissexto (é múltiplo de 4 e não é múltiplo de 100, ou é múltiplo de 400)*/
    
    int ano;

    printf("Insira um ano: ");
    scanf("%i",&ano);

    if(ano % 100 != 0 && ano % 4 == 0 || ano % 400 == 0){
        printf("O Ano é Bissexto");
    }else{
        printf("O Ano NÃO é Bissexto");
    }
    
    return 0;
}