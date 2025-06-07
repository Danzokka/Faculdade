#include <stdio.h>
#include <ctype.h>

int main(){
    
    /*Faça um programa em C que leia uma tecla pressionada e 
    determine se ela é uma letra, um dígito ou um caractere especial.*/
    
    char input;

    printf("Pressione uma tecla: ");
    input = getchar();

    if(isalpha(input)){
        printf("Você inseriu uma letra");
    }else if(isdigit(input)){
        printf("Você inseriu um número");
    }else if(ispunct(input)){
        printf("Você inseriu um caractere especial");
    }    
    
    return 0;
}