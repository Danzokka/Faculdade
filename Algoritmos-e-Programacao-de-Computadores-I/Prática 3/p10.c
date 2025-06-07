#include <stdio.h>
#include <stdlib.h>

int main(){
    
    /*Faça um programa em C que leia um número decimal e o converta em binário (ex.: 9 => 1001)*/
    
    int num, bin[8], x;
    
    printf("Digite um número na base decimal para ser convertido: ");
    scanf("%d", &num);
    
    for(x = 7; x >= 0, x){
        if(num %2 == 0){
            bin[x] = 0;
        }else{
            bin[x] = 1;
        }
        num = num / 2;
    }
    for(x = 0; x < 8; x++){
        printf("%d" ,bin[x]);
    }

    return 0;
}