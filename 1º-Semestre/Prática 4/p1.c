#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
    
    /*Faça um programa em C que preencha uma matriz com 10 números, 
    depois leia um número e localize a posição dele na matriz.*/
    
    int i, num, escolha;
    int v1, v2, v3, v4, v5, v6, v7, v8, v9, v10;

    srand(time(NULL));
    
    for(i = 1; i<=10; ++i){
        num = rand() % 1000;
        printf("%i. %i \n", i, num);
        if(i == 1){ 
            v1 = num;
        }else if(i == 2){
            v2 = num;
        }else if(i == 3){
            v3 = num;
        }else if(i == 4){
            v4 = num;
        }else if(i == 5){
            v5 = num;
        }else if(i == 6){
            v6 = num;
        }else if(i == 7){
            v7 = num;
        }else if(i == 8){
            v8 = num;
        }else if(i == 9){
            v9 = num;
        }else if(i == 10){
            v10 = num;
        }
    }

    printf("Escolha um dos valores\nEscolha: ");
    scanf("%i",&escolha);
    
    if(escolha == v1){
        printf("Você escolheu o 1º elemento");
    }else if(escolha == v2){
        printf("Você escolheu o 2º elemento");
    }else if(escolha == v3){
        printf("Você escolheu o 3º elemento");
    }else if(escolha == v4){
        printf("Você escolheu o 4º elemento");
    }else if(escolha == v5){
        printf("Você escolheu o 5º elemento");
    }else if(escolha == v6){
        printf("Você escolheu o 6º elemento");
    }else if(escolha == v7){
        printf("Você escolheu o 7º elemento");
    }else if(escolha == v8){
        printf("Você escolheu o 8º elemento");
    }else if(escolha == v9){
        printf("Você escolheu o 9º elemento");
    }else if(escolha == v10){
        printf("Você escolheu o 10º elemento");
    }    

    return 0;
}