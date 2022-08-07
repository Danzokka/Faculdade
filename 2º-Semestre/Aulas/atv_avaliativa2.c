// Aluno: Rafael Dantas Boeira - 2122082004

#include <stdio.h>

// a) Definição da estrutura data
typedef struct data
{
    int dia;
    int mes;
    int ano;
}t_data;


// b) Definição da estrutura turma
typedef struct turma
{
    char nome[30];
    char codigo[10];
    float numero_alunos;
    char sala[5];
    t_data data_inicio;
}t_turma;


int main() {

  // c) Declaração de turma e solicitação de inserção de dados em turma, pelo usuário
  t_turma turma;{
      printf("Insira o nome da turma: ");
      scanf("%[^\n]%*c", turma.nome);
      printf("Insira o código da turma: ");
      scanf("%[^\n]%*c", turma.codigo);
      printf("Insira o numero de alunos: ");
      scanf("%f", &turma.numero_alunos);
      scanf("%*c");
      printf("Ano de início: ");
      scanf("%d%*c", &turma.data_inicio.ano);
      printf("Mês de início: ");
      scanf("%d%*c", &turma.data_inicio.mes);
      printf("Dia de início: ");
      scanf("%d%*c", &turma.data_inicio.dia);
      printf("Insira a sala: ");
      scanf("%[^\n]%*c", turma.sala);
  }

  // d) Modifique o valor número de sala utilizando ponteiro para t_turma.
  t_turma *ptr_turma = &turma;
  printf("\nInsira um novo número de sala: ");
  scanf("%[^\n]%*c", (*ptr_turma).sala);
  printf("\nA nova turma é %s\n", turma.sala);

  // e) Escreva o código para verificar qual será a sala de apc_ii ou se não haverá turma aberta.
  
  t_turma apc_ii = {
    .codigo = "T1",
    .nome = "APC II",
    .numero_alunos = 35,
    .data_inicio = {
      .dia = 15,
      .mes = 03,
      .ano = 2022
    },
  };
  
  if (apc_ii.numero_alunos > 40) {
    printf("\nSua turma está na sala JA4/3!");
  } else if (apc_ii.numero_alunos >= 10apc && _ii.numero_alunos <= 40) {
    printf("\nSua turma está na sala JA1!");
  } else if (apc_ii.numero_alunos < 10) {
    printf("\nNão há alunos o suficiente para abrir uma turma!"); 
  } else {
    printf("Formato não encontrado!");
  }
  return 0;
}