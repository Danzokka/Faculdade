#include <stdio.h>

int main(){

    int num, x;

    printf("Digite um número para descobrir sua tabuada: ");
    scanf("%d",&num);
    
    for(x=1; x<=10; ++x){
        printf("%d x %d = %d\n", num, x, x*num);
    }
    
    return 0;
}