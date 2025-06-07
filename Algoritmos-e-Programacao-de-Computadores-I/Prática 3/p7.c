#include <stdio.h>
#include <math.h>

int main(){
    
    /*Escrever um programa em C que liste os 10 primeiros números da série de Fibonacci.*/
    
    int a, b, f, i;

    a = 0;
    b = 1;

    for (i = 1; i <= 10; ++i){
        if(i == 1){
            printf("%d \n", a);
        }else if(i == 2){
            printf("%d \n", b);
        }else{
            f = a + b;
            a = b;
            b = f;
            
            printf("%d \n",f);
                        
        }
    }
    return 0;
}