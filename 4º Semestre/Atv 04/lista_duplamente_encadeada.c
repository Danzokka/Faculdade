#include <stdio.h>
#include <stdlib.h>

typedef struct no
{
    int info; // elemento da lista
    struct no *prox;
    struct no *anterior;
} t_no;

typedef struct lista
{
    t_no *primeiro;
    t_no *ultimo;
    int comprimento;
} t_lista;

t_lista iniciar_lista(){
    t_lista lista;
    lista.comprimento = 0;
    lista.primeiro = NULL;
    lista.ultimo = NULL;
    return lista;
}

void inserir_inicio(t_lista *lista, int item)
{

    t_no *no = malloc(sizeof(t_no));
    if (no != NULL)
    {
        no->info = item;
        no->prox = NULL;
        no->anterior = NULL;
    }

    if (no == NULL)
    {
        printf("Erro ao inserir novo nó!\n");
        return;
    }

    // Caso a Lista esteja Vazia
    if (lista->primeiro == NULL)
    {
        lista->comprimento++;
        lista->primeiro = no;
        lista->ultimo = no;
    }
    else
    {
        lista->comprimento++;
        no->prox = lista->primeiro;
        no->anterior = NULL;
        lista->primeiro = no;
    }
}

void inserir_fim(t_lista *lista, int item)
{

    t_no *no = criar_no(item);

    if (no == NULL)
    {
        printf("Erro ao inserir novo nó!\n");
        return;
    }

    // Caso a Lista esteja Vazia
    if (lista->primeiro == NULL)
    {
        lista->comprimento++;
        lista->primeiro = no;
        lista->ultimo = no;
    }
    else
    { // Ir pro último nó da Lista para colocar esse nó na Frente,
        // Sendo o Prox = NULL e o Anterior = ultimo
        lista->comprimento++;
        no->anterior = lista->ultimo;
        no->prox == NULL;
        lista->ultimo = no;
    }
}

void inserir_ordenado(t_lista *lista, int item)
{
    //Desafio
}

void deletar_inicio(t_lista *lista, int item)
{
    if (lista->primeiro == NULL)
    {
        printf("Não é possível deletar item - Lista vazia!\n");
        return;
    }

    t_no *prox = lista->primeiro->prox;
    prox->anterior = NULL;
    free(lista->primeiro);
    lista->primeiro = prox;
    lista->comprimento--;
}

void deletar_fim(t_lista *lista, int item)
{
    if (lista->primeiro == NULL)
    {
        printf("Não é possível deletar item - Lista vazia!\n");
        return;
    }

    t_no *aux = lista->ultimo->anterior;
    aux->prox = NULL;
    lista->comprimento--;
    lista->ultimo = aux;
}

void deletar_lista(t_lista *lista)
{
    if (lista->primeiro == NULL)
    {
        printf("Não é possível deletar item - Lista vazia!\n");
        return;
    }

    t_no *aux = lista->ultimo->anterior;
    while(aux != NULL){
        free(aux->prox);
        aux = aux->anterior;
        lista->comprimento--;
    }
    lista->primeiro = aux;
    lista->ultimo = aux;
    lista->comprimento = 0;
}

void listar_do_inicio(t_lista lista)
{
    // Até prox = Null
    if (lista.primeiro == NULL)
    {
        printf("Lista vazia!\n");
        return;
    }

    t_no *aux = lista.primeiro;
    int i = 0;
    while (aux != NULL)
    {
        printf("Nó %d -> info: %d", i, aux->info);
        aux = aux->prox;
        i++;
    }
    
}

void listar_do_fim(t_lista lista)
{
    // Até anterior = Null
    if (lista.primeiro == NULL)
    {
        printf("Lista vazia!\n");
        return;
    }

    t_no *aux = lista.ultimo;
    int i = lista.comprimento;
    while (aux != NULL)
    {
        printf("Nó %d -> info: %d", i, aux->info);
        aux = aux->anterior;
        i++;
    }
}

int size(t_lista lista)
{
    return lista.comprimento;
}