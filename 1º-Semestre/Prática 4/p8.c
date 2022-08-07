#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  
  /*Faça um programa em C que leia nome e telefone de 10 contatos,
  e depois imprima todos os contatos no formato "nome - (telefone)".*/
  
  struct{
    char nome[31];
    int numero;
  }contato[10];
  

  for (int i = 1 ; i <= 10; i++){
    
    printf("Nome: ");
    gets(contato[i].nome);


    printf("Telefone: ");
    scanf(" %d", &contato[i].numero);
    

  }
  
  for (int j = 1; j < 11; j++){
    printf("%s - %d \n", contato[j].nome, contato[j].numero);
  }
  
  return 0;
}