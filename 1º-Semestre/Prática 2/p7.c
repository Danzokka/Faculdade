#include <stdio.h>

int main(){
    
    float valor_hora_trabalho, horas_trabalhadas, salario_bruto, salario_liquido;
    
    printf("Valor hora de trabalho: ");
    scanf("%f",&valor_hora_trabalho);
    printf("Total de Horas trabalhadas: ");
    scanf("%f",&horas_trabalhadas);
    
    //processamento de dados
    
    salario_bruto = valor_hora_trabalho * horas_trabalhadas;
    salario_liquido = (valor_hora_trabalho * horas_trabalhadas) * (1 - 0.25 - 0.11);

    //output
    printf("Salário Bruto: R$ %0.02f",salario_bruto);
    printf("Salário Liquido: R$ %.02f",salario_liquido);

    return 0;
}