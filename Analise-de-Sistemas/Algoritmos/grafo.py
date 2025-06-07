from typing import List


# Using a Python dictionary to act as an adjacency list
grafo = {
  'a' : ['b','c', 'd'],
  'b' : ['a'],
  'c' : ['a', 'e'],
  'd' : ['a', 'f'],
  'e' : ['c'],
  'f' : ['d']
}

 
visitados = [] # Pilha de elementos visitados 
# Mostra todos os nós do grafo em profundidade
def dfs(visited, grafo, node):
    for i in range(0, len(visited)):
        if visited[i] == node:
            return
    print(node)
    visited.append(node)
    for neighbour in grafo[node]:
        dfs(visited, grafo, neighbour)
    
            

bfs_visitados = []  # Pilha de elementos visitados    
# Mostra todos os nós do grafo em largura    
def bfs(visitados, grafo, node):
    fila = []
    fila.append(node)
    visitados.append(node)
    
    while fila:
        s = fila.pop(0)
        print(s)
        
        for vizinho in grafo[s]:
            if vizinho not in visitados:
                fila.append(vizinho)
                visitados.append(vizinho)


            
def main():
    print("DFS")  
    dfs(visitados, grafo, 'a')
    print("BFS")
    bfs(bfs_visitados, grafo, 'a')
    
main()
    