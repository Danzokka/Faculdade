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

typedef struct node{
    int value;
    struct node *next;
}node;

typedef struct queue{
    node *head;
    node *tail;
}queue;

void init(queue *q){
    q->head = NULL;
    q->tail = NULL;
}

void enqueue(queue *q, int value){
    node *new_node = (node*) malloc(sizeof(node));
    new_node->value = value;
    new_node->next = NULL;
    if(q->head == NULL){
        q->head = new_node;
        q->tail = new_node;
    }else{
        q->tail->next = new_node;
        q->tail = new_node;
    }
}

int dequeue(queue *q){
    if(q->head == NULL){
        return -1;
    }else{
        node *aux = q->head;
        int value = aux->value;
        q->head = aux->next;
        free(aux);
        return value;
    }
}

int empty(queue *q){
    if(q->head == NULL){
        return 1;
    }else{
        return 0;
    }
}

int main(){
    int t, n, m, i, j, x, y, *visited, *distance, *adj;
    queue q;
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
        init(&q);
        enqueue(&q, 0);
        visited[0] = 1;
        while(!empty(&q)){
            x = dequeue(&q);
            for(i = 0; i < n; i++){
                if(adj[x + i * n] == 1 && visited[i] == 0){
                    enqueue(&q, i);
                    visited[i] = 1;
                    distance[i] = distance[x] + 1;
                }
            }
        }
        printf("%d\n", distance[n - 1]);
    }
    return 0;
}
