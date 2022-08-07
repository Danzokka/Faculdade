#include <stdio.h>
#include <string.h>

int main(){
  
  /*Faça um programa em C que leia uma string e a imprima em maísculo e em minúsculo.*/
  
  char str[100];
  
  printf("Escreva uma frase: ");
  gets(str);

  strupr(str);
  
  printf("A sua frase em maiúsculo é: %s",str);
   
  strlwr(str);
  
  printf("\nA sua frase em minúsculo é: %s",str);  
  
  return 0;
}