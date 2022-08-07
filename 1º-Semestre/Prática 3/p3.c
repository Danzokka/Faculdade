#include <stdio.h>

int main(){
    
    /*Faça um programa em C que imprima um qualitativo associado a uma nota lida conforme a tabela: 
    1 = Ruim; 2 = Insuficiente; 3 = Suficiente, 4 = Bom, 5 = Ótimo
    E imprima Nota inválida nos demais casos.*/
    
    int nota;

    printf("Nota: ");
    scanf("%d",&nota);

    if(nota == 1){
        printf("Nota Ruim");
    }else if(nota == 2){
        printf("Nota Insuficiente");
    }else if(nota == 3){
        printf("Nota Suficiente");
    }else if(nota == 4){
        printf("Nota Boa");
    }else if(nota == 5){
        printf("Nota Ótima");
    }else{
        printf("Nota Inválida!!");
    }
    return 0;
}