#include <stdio.h>

/*Qual a diferença entre algoritmo iterativo e recursivo?
R: O algoritmo recursivo sempre chama a si mesmo,
já o iterativo nunca chama a si mesmo*/

//a
// seja n > 0 | n = 1 (Critério de Parada) | n * f(n-1) (Passo Recursivo)
int letra_a(int n){

    if(n == 1){
        return 1;
    }else{
        return(n * letra_a(n-1));
    }
}

//b
// seja n > 0 | n = 1 (Critério de Parada) | n + f(n-1) (Passo Recursivo)

int letra_b(int n){

    if(n == 1){
        return 1;
    }else{
        return(n + letra_b(n-1));
    }
}

//c
// seja n > 0 | n == 0 (Critério de Parada) | 3 + f(n-1) (Passo Recursivo)
int letra_c(int n){
    if(n == 0){
        return 2;
    }else{
        return(3 + letra_c(n-1));
    }
}

//d 
// seja n > 0 | n == 0 (Critério de Parada) | 2 * f(n-1) (Passo Recursivo)
int letra_d(int n){
    if(n == 0){
        return 3;
    }else{
        return(2 * letra_d(n-1));
    }
}

//e
// soma de pessoas + aperto anterior
// seja n > 0 | n == 1 (Critério de Parada) | 1 - n + f(n-1) (Passo Recursivo)
int letra_e(int n){
    if(n == 1){
        return 0;
    }else{
        return(n + letra_e(n-1) - 1);
    }
}


//outra maneira de resolver
int letra_e1(int n){
    if(n == 1){
        return 0;
    }else{
        return((n * (n-1)) / 2);
    }
}

int main(){
    printf("Teste 1: %d \n", letra_a(1));
    printf("Teste 2: %d \n", letra_b(2));
    printf("Teste 3: %d \n", letra_c(3));
    printf("Teste 4: %d \n", letra_d(4));
    printf("Teste 5: %d \n", letra_e(5));
    printf("Teste 6: %d \n", letra_e1(6));
}