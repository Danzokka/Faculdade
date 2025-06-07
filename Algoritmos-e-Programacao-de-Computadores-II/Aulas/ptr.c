#include <stdio.h>

int main(){
    
    //Escreva um algoritmo que percorra uma string e imprima o comprimento dessa string

    char str[300];
    int contador = 0, i = 0;

    printf("Insira uma string: ");
    scanf("%s", str);

    while ((str + i) != '\0'){
        
        contador = contador + 1;
        i = i + 1;
    
    }
    
    printf("O comprimento da string é: %d", contador);

    return 0;
}