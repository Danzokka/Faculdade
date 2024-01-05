#include <stdio.h>
#include <stdlib.h>

typedef struct no
{
    int info; // elemento da lista
    struct no *prox;
} t_no;

typedef struct lista
{
    t_no *primeiro;
    t_no *ultimo;
} t_fila;

void enfileira(t_fila *fila, int item)
{ // insere um nó no fim da lista.
    t_no *no = malloc(sizeof(t_no));

    if (no != NULL)
    {
        no->info = item;
        no->prox = NULL;

        if (fila->primeiro == NULL)
        {
            fila->primeiro = no;
        }
        else
        {
            fila->ultimo->prox = no;
        }
        fila->ultimo = no;
    }
    else
    {
        printf("Erro ao inserir! \n");
    }
}

t_no *desenfileira(t_fila *fila)
{ // retira um nó início da lista e o retorna.

    if (fila->primeiro == NULL)
    { // restrições
        printf("Fila vazia!\n");
        return NULL;
    }

    t_no *primeiro = fila->primeiro;
    t_no *prox = fila->primeiro->prox;

    free(fila->primeiro);

    fila->primeiro = prox;

    return primeiro;
}