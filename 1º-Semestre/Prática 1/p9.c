#include <stdio.h>
int main(){
    
    int anos, meses, dias, tempo_dias;

    //inputs

    printf("Tempo em anos: ");
    scanf("%d",&anos);
    printf("Tempo em meses: ");
    scanf("%d",&meses);
    printf("Tempo em dias: ");
    scanf("%d",&dias);

    //processamento de dados

    tempo_dias =  (anos * 365) + (meses * 30) + dias;

    //output

    printf("%d anos, %d meses e %d dias equivalem a %d dias",anos, meses, dias, tempo_dias);
    
    return 0;
}