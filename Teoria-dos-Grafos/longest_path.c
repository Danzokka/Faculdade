/*You are given an unweighted, undirected tree. Write a program to output the length of the longest path (from one node to another) in that tree. The length of a path in this case is number of edges we traverse from source to destination.

Input
The first line of the input file contains one integer N --- number of nodes in the tree (0 < N <= 10000). Next N-1 lines contain N-1 edges of that tree --- Each line contains a pair (u, v) means there is an edge between node u and node v (1 <= u, v <= N).

Output
Print the length of the longest path on one line.

Example
Input:
3
1 2
2 3

Output:
2*/

#include <stdio.h>
#include <stdlib.h>

#define MAX_NOS 10001

typedef struct no
{
    int valor;
    struct no *prox;
} no;

no *adj[MAX_NOS];
int visitado[MAX_NOS];
int profundidade_maxima1, profundidade_maxima2;

void adiciona_aresta(int u, int v)
{
    no *novo_no = (no *)malloc(sizeof(no));
    novo_no->valor = v;
    novo_no->prox = adj[u];
    adj[u] = novo_no;
}

void dfs(int node, int profundidade) {
    visitado[node] = 1;
    if (profundidade > profundidade_maxima1) {
        profundidade_maxima1 = profundidade;
        profundidade_maxima2 = node;
    }
    for (no* vizinho = adj[node]; vizinho != NULL; vizinho = vizinho->prox) {
        if (!visitado[vizinho->valor]) {
            dfs(vizinho->valor, profundidade + 1);
        }
    }
}
int main()
{
    int qtd_nos;
    scanf("%d", &qtd_nos);

    for (int i = 1; i <= qtd_nos; i++)
    {
        adj[i] = NULL;
        visitado[i] = 0;
    }

    for (int i = 0; i < qtd_nos - 1; i++)
    {
        int u, v;
        scanf("%d %d", &u, &v);
        adiciona_aresta(u, v);
        adiciona_aresta(v, u);
    }

    profundidade_maxima1 = -1;
    dfs(1, 0);

    for (int i = 1; i <= qtd_nos; i++)
        visitado[i] = 0;

    profundidade_maxima1 = -1;
    dfs(profundidade_maxima2, 0);

    printf("%d\n", profundidade_maxima1);

    return 0;
}
