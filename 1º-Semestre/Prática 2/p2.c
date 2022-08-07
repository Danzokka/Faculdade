#include <stdio.h>

int main(){
    
    int a, b, resto, quociente;

    //inputs
    printf("Dividendo: ");
    scanf("%d",&a);
    printf("Divisor: ");
    scanf("%d",&b);

    //processamento de dados    
    quociente = a / b;
    resto = a % b;
    
    //output
    printf("A divisão entre %d e %d tem quociente %d e resto %d",a,b,quociente,resto);

    return 0;
}