#include <stdio.h>
#include "Cilindro.h"

int main() {
    float raio, altura;
    
    printf("Digite o raio do cilindro: ");
    scanf("%f", &raio);
    
    printf("Digite a altura do cilindro: ");
    scanf("%f", &altura);
    
    /* Criação do cilindro */
    Cilindro* c = criar(raio, altura);
    
    if (c == NULL) {
        printf("Erro ao criar o cilindro!\n");
        return 1;
    }
    
    /* Exibição das propriedades do cilindro */
    printf("\n--- Propriedades do Cilindro ---\n");
    printf("Raio: %.2f\n", getRaio(c));
    printf("Altura: %.2f\n", getAltura(c));
    printf("Área da base: %.2f\n", areaBase(c));
    printf("Área lateral: %.2f\n", areaLateral(c));
    printf("Área total: %.2f\n", areaTotal(c));
    printf("Volume: %.2f\n", volume(c));
    
    /* Liberação da memória */
    destruir(c);
    
    return 0;
}