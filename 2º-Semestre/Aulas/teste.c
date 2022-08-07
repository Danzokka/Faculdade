#include <stdio.h>

// a) Definição da estrutura data
typedef struct data
{
    int dia;
    int mes;
    int ano;
}t_data;

typedef struct depressao
{
  int idade;
  char genero[30];
  char curso[300];
  int escala_alcolatra; // vai de 1 a 10
  t_data data_nascimento;
}t_depressao;


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
 /*
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
  printf("\nO novo numéro de sala é %s\n", turma.sala);

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
    printf("\nSua turma está na sala JA4/3!\n");
  } else if (apc_ii.numero_alunos <= 40) {
    printf("\nSua turma está na sala JA1!\n");
  } else if (apc_ii.numero_alunos <= 10) {
    printf("\nNão há alunos o suficiente para abrir uma turma!\n"); 
  } else {
    printf("\nFormato não encontrado!\n");
  }
*/

  socorro();

  return 0;
}

int socorro(){

/* 
typedef struct depressao
{
  int idade;
  char genero[30];
  char curso[300];
  int escala_alcolatra; // vai de 1 a 10
}t_depressao;*/ 
  
  t_depressao geral;{
    printf("Insira a sua idade: "); 
    scanf("%d%*c", &geral.idade); // 18 ----> "18\n" | %d -> 18 | %*c ~> \n, mas ele deleta esse \n
    printf("Escala_Alcolatra: ");
    scanf("%d%*c", &geral.escala_alcolatra);
    for(int i = 0; geral.escala_alcolatra < 5 || geral.escala_alcolatra > 10; i++){
      printf("Insira um valor de 1 a 10: \n")/
      scanf("%d%*c", &geral.escala_alcolatra);
    }
    printf("Insira o seu curso: ");
    scanf("%[^\n]%*c", geral.curso);
    printf("Insira o seu genero: ");
    scanf("%[^\n]%*c", geral.genero);

    printf("Insira a sua data de nascimento: ");
    scanf(" %d / %d / %d", &geral.data_nascimento.dia, &geral.data_nascimento.mes, &geral.data_nascimento.ano);


  }


  t_depressao *ptr_depressao = &geral;

  printf("Voce eh alcolatra assim mesmo? Coloque o seu verdadeiro nivel: ");
  scanf("%d%*c", &ptr_depressao->escala_alcolatra);
  
  printf("A sua idade: %d\nGrau de Alcolismo: %d/10\nSeu genero: %s\nSeu curso: %s", geral.idade, geral.escala_alcolatra, geral.genero, geral.curso);
  printf(" %d/%d/%d", geral.data_nascimento.dia, geral.data_nascimento.mes, geral.data_nascimento.ano);



  return 0;
}