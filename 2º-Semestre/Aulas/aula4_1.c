#include <stdio.h>


typedef struct pet{
    char nome[30];
    unsigned int idade;
    char raca[30];
    char sexo[30];
}t_pet;


int main(){

    t_pet pet;{
        printf("Insira o nome do seu Pet: ");
        scanf("%s", pet.nome);
        printf("Insira a idade do seu Pet: ");
        scanf("%d", &pet.idade);
        printf("Insira a raça do seu Pet: ");
        scanf("%s", pet.raca);
        printf("Insira o sexo do seu Pet: ");
        scanf("%s", pet.sexo);
    }

    printf("O nome do seu pet é %s,\nSua idade é %d anos,\nA raça do seu pet é %s,\nO sexo do seu pet é %s", pet.nome, pet.idade, pet.raca, pet.sexo);


  return 0;
} 