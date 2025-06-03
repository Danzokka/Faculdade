import sys
from collections import defaultdict, deque

class Aresta:
    def __init__(self, dest, peso):
        self.dest = dest
        self.peso = peso
        self.proximo = None

class ListaAdj:
    def __init__(self):
        self.inicio = None

class Grafo:
    def __init__(self, num_vertices):
        self.num_vertices = num_vertices
        self.vizinhos_de = [ListaAdj() for _ in range(num_vertices)]

    def adicionar_aresta(self, origem, destino, peso):
        nova = Aresta(destino, peso)
        nova.proximo = self.vizinhos_de[origem].inicio
        self.vizinhos_de[origem].inicio = nova

    def mostrar_grafo(self):
        for i in range(self.num_vertices):
            aresta = self.vizinhos_de[i].inicio
            print(f"Vértice {i}:", end="")
            while aresta:
                print(f" -> {aresta.dest} ({aresta.peso})", end="")
                aresta = aresta.proximo
            print()

    @staticmethod
    def ler_grafo(nome_arquivo):
        with open(nome_arquivo, "r") as arquivo:
            num_vertices = int(arquivo.readline().strip())
            grafo = Grafo(num_vertices)

            for linha in arquivo:
                origem, destino, peso = map(int, linha.strip().split(","))
                if 0 <= origem < num_vertices and 0 <= destino < num_vertices:
                    grafo.adicionar_aresta(origem, destino, peso)
                else:
                    print(f"Aresta inválida: {origem},{destino},{peso}")

        return grafo

def proximo_vertice(distancia_total, foi_visitado):
    menor = sys.maxsize
    indice = -1

    for v in range(len(distancia_total)):
        if not foi_visitado[v] and distancia_total[v] < menor:
            menor = distancia_total[v]
            indice = v

    return indice

def mostrar_caminho(melhor_anterior, vertice):
    if melhor_anterior[vertice] == -1:
        print(vertice, end="")
        return

    mostrar_caminho(melhor_anterior, melhor_anterior[vertice])
    print(f" -> {vertice}", end="")

def dijkstra(grafo, origem):
    num_vertices = grafo.num_vertices
    distancia_total = [sys.maxsize] * num_vertices
    foi_visitado = [False] * num_vertices
    melhor_anterior = [-1] * num_vertices

    distancia_total[origem] = 0

    print(f"\n===== Iniciando Dijkstra a partir do vértice {origem} =====")

    for _ in range(num_vertices):
        atual = proximo_vertice(distancia_total, foi_visitado)

        if atual == -1:
            break

        foi_visitado[atual] = True

        print(f"\nVisitando vértice {atual} (distância atual: {distancia_total[atual]})")

        aresta = grafo.vizinhos_de[atual].inicio
        while aresta:
            vizinho = aresta.dest
            peso = aresta.peso

            if not foi_visitado[vizinho] and distancia_total[atual] != sys.maxsize and distancia_total[atual] + peso < distancia_total[vizinho]:
                distancia_total[vizinho] = distancia_total[atual] + peso
                melhor_anterior[vizinho] = atual

                print(f"  Atualizando vértice {vizinho}: nova distância = {distancia_total[vizinho]}, anterior = {atual}")

            aresta = aresta.proximo

def copiar_grafo(grafo):
    copia = Grafo(grafo.num_vertices)
    for u in range(grafo.num_vertices):
        aresta = grafo.vizinhos_de[u].inicio
        while aresta:
            copia.adicionar_aresta(u, aresta.dest, aresta.peso)
            aresta = aresta.proximo
    return copia

def dfs_aumentante(grafo, u, destino, visitado, pai):
    visitado[u] = True
    if u == destino:
        return True

    aresta = grafo.vizinhos_de[u].inicio
    while aresta:
        v = aresta.dest
        if not visitado[v] and aresta.peso > 0:
            pai[v] = u
            if dfs_aumentante(grafo, v, destino, visitado, pai):
                return True
        aresta = aresta.proximo

    return False