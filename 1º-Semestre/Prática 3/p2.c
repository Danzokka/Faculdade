#include <stdio.h>

int main(){
    
    /*Faça um programa em C que calcule o valor do desconto sobre um valor bruto lido com base na escala: 
    até de 100.00 aplica 1%; de 100.01 a 500.00 aplica 5%; acima de 500.00 aplica 10%.*/
    
    float valor_bruto, valor_desconto, valor_descontado;
    
    printf("Valor Bruto do produto: ");
    scanf("%f",&valor_bruto);

    if(valor_bruto < 100.01 ){
        valor_descontado = valor_bruto * 0.99;
        valor_desconto = valor_bruto - (valor_bruto * 0.99);
        printf("O valor do desconto é de %.2f", valor_desconto);
        printf("O valor do produto com desconto é de %.2f", valor_descontado);
    }else if (valor_bruto >= 100.01 || valor_bruto <= 500){
        valor_descontado = valor_bruto * 0.95;
        valor_desconto = valor_bruto - (valor_bruto * 0.95);
        printf("O valor do desconto é de %.2f", valor_desconto);     
        printf("O valor do produto com desconto é de %.2f", valor_descontado);   
    }else{
        valor_descontado = valor_bruto * 0.9;
        valor_desconto = valor_bruto - (valor_bruto * 0.9);
        printf("O valor do desconto é de %.2f \n", valor_desconto); 
        printf("O valor do produto com desconto é de %.2f", valor_descontado);
    }
    
    return 0;
}