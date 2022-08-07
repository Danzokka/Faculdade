#include <stdio.h>

int main(){
    
    int d, valor_absoluto;

    printf("Insira os dados yey: ");
    scanf("%d", &d);
    
    valor_absoluto = Abs(d);

    printf("Valor absoluto de %d eh %d", d, valor_absoluto);
    
    return 0;
}

int Abs(int x){
    
    int v_abs;

    if(x <= 0){
        v_abs = -x;
    }
    
    return v_abs;
}