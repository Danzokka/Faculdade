#include <stdio.h>

int main(){

    int input, ascii;
    
    printf("Digite um número: ");
    scanf("%d",&input);

    if (input <= 127){
        printf("%d equivale a %c na tabela ASCII",input,input);
    } else {
        printf("Coloque um valor menor que 128");
    }
    return 0;
}