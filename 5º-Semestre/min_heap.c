#include <stdio.h>
#include <stdlib.h>

#define MAX 1000000

typedef struct {
    int vertex;
    int weight;
} Node;

void dijkstra(int N, Node graph[N+1][N+1], int dist[N+1], int start) {
    int visited[N+1];
    for(int i=1; i<=N; i++) {
        dist[i] = MAX;
        visited[i] = 0;
    }
    dist[start] = 0;
    for(int i=1; i<=N; i++) {
        int min = MAX;
        int u = -1;
        for(int j=1; j<=N; j++) {
            if(!visited[j] && dist[j] < min) {
                min = dist[j];
                u = j;
            }
        }
        if(u == -1) break;
        visited[u] = 1;
        for(int v=1; v<=N; v++) {
            if(graph[u][v].weight != MAX && dist[u] + graph[u][v].weight < dist[v]) {
                dist[v] = dist[u] + graph[u][v].weight;
            }
        }
    }
}

int main() {
    int T;
    scanf("%d", &T);
    while(T--) {
        int N, M;
        scanf("%d %d", &N, &M);
        Node graph[N+1][N+1];
        for(int i=1; i<=N; i++) {
            for(int j=1; j<=N; j++) {
                graph[i][j].vertex = j;
                graph[i][j].weight = MAX;
            }
        }
        for(int i=0; i<M; i++) {
            int u, v, w;
            scanf("%d %d %d", &u, &v, &w);
            graph[u][v].weight = w;
            graph[v][u].weight = w;
        }
        int dist[N+1];
        dijkstra(N, graph, dist, 1);
        int K, P;
        scanf("%d %d", &K, &P);
        int bones[K];
        for(int i=0; i<K; i++) {
            scanf("%d", &bones[i]);
        }
        int sum = 0;
        for(int i=0; i<K; i++) {
            sum += dist[bones[i]];
        }
        if(sum % (2*P) == 0) printf("No\n");
        else printf("Yes\n");
    }
    return 0;
}
