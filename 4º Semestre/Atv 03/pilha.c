#include <stdio.h>
#include <stdlib.h>

typedef struct no
{
    int info; // elemento da lista
    struct no *prox;
} t_no;
typedef struct lista
{
    t_no *topo;
} t_pilha;

void empilha(t_pilha *pilha, int item)
{ // insere um nó no topo da lista
    t_no *no = malloc(sizeof(t_no));
    no->info = item;
    no->prox = pilha->topo;
    pilha->topo = no;
}

t_no *desempilha(t_pilha *pilha)
{ // retira um nó do topo da lista e o retorna
    t_no *no;

    if (pilha->topo == NULL)
    {
        printf("A pilha está vazia! \n");
        return NULL;
    }

    no = pilha->topo;
    t_no *prox = pilha->topo->prox;
    free(pilha->topo);
    pilha->topo = prox;

    return no;
}

t_no *topo(t_pilha *pilha)
{
    if (pilha->topo == NULL)
    {
        printf("A pilha está vazia! \n");
        return NULL;
    }

    t_no *no = pilha->topo;

    return no;
}