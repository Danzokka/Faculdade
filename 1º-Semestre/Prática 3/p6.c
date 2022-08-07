#include <stdio.h>

int main(){
    
    /*Faça um programa em C que liste todos os múltiplos de 3, entre 1 e 100.*/
    
    int x, multiplo_3;
    
    for(x=0; x <=100 ; ++x){
        multiplo_3 = x % 3;
        if(multiplo_3 == 0){
            printf("%d é múltiplo de 3", x);
        }
    }
    return 0;
}