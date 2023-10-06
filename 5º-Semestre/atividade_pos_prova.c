#include<stdio.h>
#include<stdlib.h>

#define MAX 100

typedef struct no {
    int vertice;
    struct no* next;
} no;

no* cria_no(int v);
void adiciona_aresta(no* lista_adjacencia[], int origem, int destino);
void DFS(no* lista_adjacencia[], int inicio, int visitado[], int pai[]);

int main() {
    int vertices = 4, arestas, origem, destino;

    no* lista_adjacencia[vertices];
    for(int i=0; i<vertices; i++)
        lista_adjacencia[i] = NULL;

    scanf("%d", &arestas);

    for(int i=0; i<arestas; i++) {
        scanf("%d %d", &origem, &destino);
        adiciona_aresta(lista_adjacencia, origem, destino);
    }

    int visitado[vertices];
    int pai[vertices];
    for(int i=0; i<vertices; i++) {
        visitado[i] = 0;
        pai[i] = -1;
    }

    for(int i=0; i<vertices; i++) {
        if(visitado[i] == 0) {
            DFS(lista_adjacencia, i, visitado, pai);
        }
    }

    return 0;
}

no* cria_no(int v) {
    no* novo_no = malloc(sizeof(no));
    novo_no->vertice = v;
    novo_no->next = NULL;
    return novo_no;
}

void adiciona_aresta(no* lista_adjacencia[], int origem, int destino) {
    no* novo_no = cria_no(destino);
    novo_no->next = lista_adjacencia[origem];
    lista_adjacencia[origem] = novo_no;
}

void DFS(no* lista_adjacencia[], int inicio, int visitado[], int pai[]) {
    visitado[inicio] = 1;

    no* temp = lista_adjacencia[inicio];

    while(temp) {
        int vertice_conectado = temp->vertice;

        if(visitado[vertice_conectado] == 0) {
            pai[vertice_conectado] = inicio;
            DFS(lista_adjacencia, vertice_conectado, visitado, pai);
        }
        else if(pai[inicio] != vertice_conectado)
            printf("Backedge detectada entre o vértice %d e o vértice %d\n", inicio, vertice_conectado);

        temp = temp->next;
    }
}
