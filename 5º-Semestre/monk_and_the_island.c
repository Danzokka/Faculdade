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

int empty(fila *q){
    if(q->inicio == NULL){
        return 1;
    }else{
        return 0;
    }
}

int main(){
    int t, n, m, i, j, x, y, *visited, *distance, *adj;
    fila q;
    scanf("%d", &t);
    while(t--){
        scanf("%d %d", &n, &m);
        visited = (int*) malloc(sizeof(int) * n);
        distance = (int*) malloc(sizeof(int) * n);
        adj = (int*) malloc(sizeof(int) * n * n);
        memset(adj, 0, sizeof(int) * n * n);
        memset(visited, 0, sizeof(int) * n);
        memset(distance, 0, sizeof(int) * n);
        for(i = 0; i < m; i++){
            scanf("%d %d", &x, &y);
            adj[x - 1 + (y - 1) * n] = 1;
            adj[y - 1 + (x - 1) * n] = 1;
        }
        inicializar(&q);
        enfileirar(&q, 0);
        visited[0] = 1;
        while(!empty(&q)){
            x = desinfileira(&q);
            for(i = 0; i < n; i++){
                if(adj[x + i * n] == 1 && visited[i] == 0){
                    enfileirar(&q, i);
                    visited[i] = 1;
                    distance[i] = distance[x] + 1;
                }
            }
        }
        printf("%d\n", distance[n - 1]);
    }
    return 0;
}
