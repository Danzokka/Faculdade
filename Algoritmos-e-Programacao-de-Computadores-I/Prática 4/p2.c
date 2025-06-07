#include <stdio.h>

int main(){
  
  //Faça um programa em C que leia as notas de 10 alunos, calcule a média da turma e contabilize quantos alunos estão com a nota acima da média.

  float num = 0, media = 0, soma = 0;
  int i, aprovado = 0;

  printf("Insira as 10 notas \n");

  for(i = 1; i<=10; ++i){
    printf("%i º aluno: ", i);
    scanf("%f", &num);

    if(num < 0 || num > 10){
      printf("Número inválido \nInsira outro número entre 0 a 10 \n");
      i = i-1;
      num = 0;
    }

    soma = soma + num;

    if(num >= 5){
      aprovado = aprovado + 1;
    }

  }  
  
  media = soma/10;

  printf("A média da turma é: %.2f \n", media);
  printf("A turma teve %i alunos aprovados.", aprovado);
  
  return 0;
}