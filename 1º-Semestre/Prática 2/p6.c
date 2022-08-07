#include <stdio.h>

int main(){

    float vc, af, ad, vd, d;

    //inputs
    
    printf("Valor de compra: ");
    scanf("%f",&vc);
    printf("Ano de Fabricação: ");
    scanf("%f",&af);
    printf("Ano de Depreciação: ");
    scanf("%f",&ad);

    //processamento de dados
    //o valor depreciado do veículo é o valor de compra menos a depreciação
    d = ((ad - af) * vc) / 100;
    vd = vc - d;

    //output
    printf("O valor depreciado do veículo é de R$ %0.02f",vd);

    return 0;
}