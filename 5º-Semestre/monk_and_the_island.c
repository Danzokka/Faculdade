/*
Aluno: Rafael Dantas Boeira
Matrícula: 2122082004
*/

/*Problem
Monk visits the land of Islands. There are a total of N islands numbered from 1 to N. Some pairs of islands are connected to each other by Bidirectional bridges running over water.
Monk hates to cross these bridges as they require a lot of efforts. He is standing at Island #1 and wants to reach the Island #N. Find the minimum the number of bridges that he shall have to cross, if he takes the optimal route.

Input:
First line contains T. T testcases follow.
First line of each test case contains two space-separated integers N, M.
Each of the next M lines contains two space-separated integers X and Y , denoting that there is a bridge between Island X and Island Y.

Output:
Print the answer to each test case in a new line.

Constraints:
1 ≤ T ≤ 10
1 ≤ N ≤ 104
1 ≤ M ≤ 105
1 ≤ X, Y ≤ N*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct no{
    int valor;
    struct no *next;
}no;

typedef struct fila{
    no *inicio;
    no *fim;
}fila;

void inicializar(fila *q){
    q->inicio = NULL;
    q->fim = NULL;
}

void enfileirar(fila *q, int valor){
    no *novo_no = (no*) malloc(sizeof(no));
    novo_no->valor = valor;
    novo_no->next = NULL;
    if(q->inicio == NULL){
        q->inicio = novo_no;
        q->fim = novo_no;
    }else{
        q->fim->next = novo_no;
        q->fim = novo_no;
    }
}

int desinfileira(fila *q){
    if(q->inicio == NULL){
        return -1;
    }else{
        no *aux = q->inicio;
        int valor = aux->valor;
        q->inicio = aux->next;
        free(aux);
        return valor;
    }
}

int eh_vazio(fila *q){
    if(q->inicio == NULL){
        return 1;
    }else{
        return 0;
    }
}

int main(){
    int casos, 
    vertices, qtdArestas, i, j, x, y, *visitado, *distancia, *matriz_adjacencia; // x e y são as arestas

    fila fila;
    scanf("%d", &casos);
    while(casos--){
        scanf("%d %d", &vertices, &qtdArestas);
        visitado = (int*) malloc(sizeof(int) * vertices);
        distancia = (int*) malloc(sizeof(int) * vertices);
        matriz_adjacencia = (int*) malloc(sizeof(int) * vertices * vertices);
        memset(matriz_adjacencia, 0, sizeof(int) * vertices * vertices);
        memset(visitado, 0, sizeof(int) * vertices);
        memset(distancia, 0, sizeof(int) * vertices);
        for(i = 0; i < qtdArestas; i++){
            scanf("%d %d", &x, &y);
            matriz_adjacencia[x - 1 + (y - 1) * vertices] = 1;
            matriz_adjacencia[y - 1 + (x - 1) * vertices] = 1;
        }
        inicializar(&fila);
        enfileirar(&fila, 0);
        visitado[0] = 1;
        while(!eh_vazio(&fila)){
            x = desinfileira(&fila);
            for(i = 0; i < vertices; i++){
                if(matriz_adjacencia[x + i * vertices] == 1 && visitado[i] == 0){
                    enfileirar(&fila, i);
                    visitado[i] = 1;
                    distancia[i] = distancia[x] + 1;
                }
            }
        }
        printf("%d\n", distancia[vertices - 1]);
    }
    return 0;
}
