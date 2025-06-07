# 🕸️ Teoria dos Grafos

![Python](https://go-skill-icons.vercel.app/api/icons?i=py&theme=light) ![C](https://go-skill-icons.vercel.app/api/icons?i=c&theme=light) ![Jupyter](https://go-skill-icons.vercel.app/api/icons?i=jupyter&theme=light)

## 📖 Descrição

Esta disciplina explora a teoria matemática dos grafos e suas aplicações computacionais. Estudamos algoritmos fundamentais para navegação, busca e otimização em estruturas de grafos, aplicáveis a problemas como redes sociais, sistemas de transporte e otimização de rotas.

## 🎯 Objetivos de Aprendizagem

- Compreender **conceitos fundamentais** da teoria dos grafos
- Implementar **algoritmos de busca** em grafos (DFS, BFS)
- Aplicar **algoritmos de caminho mínimo** (Dijkstra, Floyd-Warshall)
- Resolver problemas de **conectividade** e **árvore geradora mínima**
- Analisar **complexidade** de algoritmos em grafos

## 🌐 Conceitos Fundamentais

### 📊 Tipos de Grafos

- **Grafo Simples:** Sem laços ou arestas múltiplas
- **Multigrafo:** Permite arestas múltiplas
- **Grafo Direcionado:** Arestas com direção
- **Grafo Ponderado:** Arestas com pesos
- **Grafo Bipartido:** Vértices divididos em dois conjuntos

### 🔗 Representações

```c
// Matriz de Adjacência
int matriz[V][V];

// Lista de Adjacência
typedef struct Node {
    int vertex;
    int weight;
    struct Node* next;
} Node;

Node* adj[V];
```

## 🔍 Algoritmos de Busca

### 🌊 Busca em Largura (BFS)

```python
def bfs(graph, start):
    visited = set()
    queue = [start]

    while queue:
        vertex = queue.pop(0)
        if vertex not in visited:
            visited.add(vertex)
            queue.extend(graph[vertex] - visited)

    return visited
```

### 🌲 Busca em Profundidade (DFS)

```python
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()

    visited.add(start)

    for neighbor in graph[start] - visited:
        dfs(graph, neighbor, visited)

    return visited
```

## 🛣️ Algoritmos de Caminho Mínimo

### ⚡ Algoritmo de Dijkstra

- **Aplicação:** Caminho mínimo de uma origem
- **Complexidade:** O((V + E) log V)
- **Requisito:** Pesos não-negativos

### 🌐 Algoritmo de Floyd-Warshall

- **Aplicação:** Caminho mínimo entre todos os pares
- **Complexidade:** O(V³)
- **Vantagem:** Funciona com pesos negativos

### 🚀 Algoritmo de Bellman-Ford

- **Aplicação:** Detecta ciclos negativos
- **Complexidade:** O(VE)
- **Característica:** Mais lento que Dijkstra

## 🌳 Árvore Geradora Mínima

### 🔗 Algoritmo de Kruskal

```python
def kruskal(graph):
    # Ordenar arestas por peso
    edges = sorted(graph.edges, key=lambda x: x.weight)
    mst = []

    for edge in edges:
        if not creates_cycle(mst, edge):
            mst.append(edge)

    return mst
```

### 📡 Algoritmo de Prim

```python
def prim(graph, start):
    mst = []
    visited = {start}
    edges = priority_queue(graph.edges_from(start))

    while edges and len(visited) < len(graph.vertices):
        edge = edges.pop_min()
        if edge.end not in visited:
            mst.append(edge)
            visited.add(edge.end)
            edges.add_all(graph.edges_from(edge.end))

    return mst
```

## 📂 Aplicações Práticas

### 🗺️ Sistemas de Navegação

- **Algoritmo:** Dijkstra para GPS
- **Estrutura:** Grafo ponderado com distâncias
- **Otimização:** A\* para melhor performance

### 👥 Redes Sociais

- **Conectividade:** BFS para grau de separação
- **Influência:** PageRank baseado em grafos
- **Comunidades:** Detecção de clusters

### 🚛 Logística e Transporte

- **Rotas:** Problema do caixeiro viajante
- **Fluxo:** Algoritmos de fluxo máximo
- **Otimização:** Árvore geradora mínima para redes

## 🧮 Complexidade Algoritmica

| Algoritmo          | Complexidade Temporal | Complexidade Espacial |
| ------------------ | --------------------- | --------------------- |
| **BFS**            | O(V + E)              | O(V)                  |
| **DFS**            | O(V + E)              | O(V)                  |
| **Dijkstra**       | O((V + E) log V)      | O(V)                  |
| **Floyd-Warshall** | O(V³)                 | O(V²)                 |
| **Kruskal**        | O(E log E)            | O(V)                  |
| **Prim**           | O((V + E) log V)      | O(V)                  |

## 🛠️ Ferramentas e Tecnologias

- **Linguagens:** Python, C, Java
- **Bibliotecas:** NetworkX (Python), igraph (R)
- **Visualização:** Graphviz, Gephi
- **Análise:** Jupyter Notebooks

## 📊 Problemas Clássicos

- **Caminho Mais Curto:** Dijkstra, Bellman-Ford
- **Conectividade:** Componentes conexas
- **Planaridade:** Teste de grafos planares
- **Coloração:** Problema das k-cores
- **Fluxo Máximo:** Ford-Fulkerson
- **Correspondência:** Algoritmo húngaro

## 🔗 Recursos Complementares

- [Graph Theory Tutorial](https://www.tutorialspoint.com/graph_theory/)
- [NetworkX Documentation](https://networkx.org/)
- [Visualização de Grafos](https://graphonline.ru/en/)

---

_A Teoria dos Grafos é fundamental para resolver problemas complexos de conectividade, otimização e análise de redes em diversas áreas da computação e matemática aplicada._
