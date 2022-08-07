//Juliana Alves Pacheco 2122082026


#include <stdio.h>

// a) Definição da estrutura data
 typedef unsigned int uint;
 
 typedef struct data{
     int dia, mes, ano;
 }t_data;

// b) Definição da estrutura turma
 //typedef unsigned int uint;
 typedef struct turma {
     char  nome[40], codigo[12];
     float numero_alunos;
     t_data data_inicio;
     char sala[7];
     
 }t_turma;
// c) Declaração de turma e solicitação de inserção de dados em turma, pelo usuário
int main() {
    
   t_turma turma;{
  
  printf("Dados da turma\n");
  
  printf("Coloque o nome:");
  scanf("%[^\n]%*c", turma.nome);
  
  printf("Coloque o código");
  scanf("%[^\n]%*c", turma.codigo);
  
  printf("Coloque o numero de alunos");
  scanf("%f", &turma.numero_alunos);
  scanf("%*c");
  
  printf("Início da aula\n");

  printf("dia do inicio da aula\n");
  scanf("%d%*c", &turma.data_inicio.dia);
  
  printf("mes da aula\n");
  scanf("%d%*c", &turma.data_inicio.mes);
  
   printf("ano  da aula\n");
  scanf("%d%*c", &turma.data_inicio.ano);
  
  printf("informe a sala\n");
  scanf("%[^\n]%*c", turma.sala);
   }

  // d) Modifique o valor número de sala utilizando ponteiro para t_turma.
  t_turma *ptr_turma = &turma;
  printf("Novo numero de sala\n");
  scanf("%[^\n]%*c", (*ptr_turma).sala);

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
    printf("Aula de APCII\n");
   if (apc_ii.numero_alunos > 40){
      printf("Turma JA4/3\n");
   } else if  (apc_ii.numero_alunos<=40 && apc_ii.numero_alunos>=10){
       printf("Turma JA1\n");
   }
     else if (apc_ii.numero_alunos <10){
         printf("Turma não definida\n");
     }
     
      
  

  return 0;
}