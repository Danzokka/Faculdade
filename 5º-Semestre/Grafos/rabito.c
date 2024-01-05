// Rafael Dantas Boeira - 2122082004

#include <stdio.h>
#include <stdlib.h>

#define MAX 1000000

typedef struct
{
    int vertice;
    int peso;
} no;

void dijkstra(int N, no grafo[N + 1][N + 1], int distancia[N + 1], int inicio)
{
    int visitado[N + 1];
    for (int i = 1; i <= N; i++)
    {
        distancia[i] = MAX;
        visitado[i] = 0;
    }
    distancia[inicio] = 0;
    for (int i = 1; i <= N; i++)
    {
        int minimo = MAX;
        int u = -1;
        for (int j = 1; j <= N; j++)
        {
            if (!visitado[j] && distancia[j] < minimo)
            {
                minimo = distancia[j];
                u = j;
            }
        }
        if (u == -1)
            break;
        visitado[u] = 1;
        for (int v = 1; v <= N; v++)
        {
            if (grafo[u][v].peso != MAX && distancia[u] + grafo[u][v].peso < distancia[v])
            {
                distancia[v] = distancia[u] + grafo[u][v].peso;
            }
        }
    }
}

int main()
{
    int T;
    scanf("%d", &T);
    while (T--)
    {
        int N, M;
        scanf("%d %d", &N, &M);
        no grafo[N + 1][N + 1];
        for (int i = 1; i <= N; i++)
        {
            for (int j = 1; j <= N; j++)
            {
                grafo[i][j].vertice = j;
                grafo[i][j].peso = MAX;
            }
        }
        for (int i = 0; i < M; i++)
        {
            int u, v, w;
            scanf("%d %d %d", &u, &v, &w);
            grafo[u][v].peso = w;
            grafo[v][u].peso = w;
        }
        int distancia[N + 1];
        dijkstra(N, grafo, distancia, 1);
        int K, P;
        scanf("%d %d", &K, &P);
        int ossos[K];
        for (int i = 0; i < K; i++)
        {
            scanf("%d", &ossos[i]);
        }
        int soma = 0;
        for (int i = 0; i < K; i++)
        {
            soma += distancia[ossos[i]];
        }
        if (soma % (2 * P) == 0)
            printf("No\n");
        else
            printf("Yes\n");
    }
    return 0;
}