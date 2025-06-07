# 🗂️ Estruturas de Dados

![C](https://go-skill-icons.vercel.app/api/icons?i=c&theme=light) ![Visual Studio Code](https://go-skill-icons.vercel.app/api/icons?i=vscode&theme=light) ![Git](https://go-skill-icons.vercel.app/api/icons?i=git&theme=light)

## 📖 Descrição

Esta disciplina explora as estruturas de dados fundamentais e algoritmos essenciais para o desenvolvimento de software eficiente. Retornando à linguagem C, aplicamos conceitos avançados de organização e manipulação de dados através de Tipos Abstratos de Dados (TADs) e algoritmos de ordenação.

## 🎯 Objetivos de Aprendizagem

- Implementar **Tipos Abstratos de Dados (TADs)** em C
- Compreender e aplicar **algoritmos de ordenação** e busca
- Analisar **complexidade algoritmica** (Big O)
- Desenvolver **estruturas dinâmicas** de dados
- Aplicar **técnicas de recursão** para solução de problemas

## 📊 Estruturas de Dados Implementadas

### 🔄 Estruturas Lineares

- **Array/Vetor:** Acesso direto por índice
- **Lista Ligada:** Inserção e remoção dinâmica
- **Pilha (Stack):** LIFO - Last In, First Out
- **Fila (Queue):** FIFO - First In, First Out

### 🌳 Estruturas Hierárquicas

- **Árvore Binária:** Organização hierárquica
- **Árvore de Busca Binária:** Busca otimizada
- **Heap:** Estrutura de prioridade
- **Árvore AVL:** Balanceamento automático

### 🕸️ Estruturas de Grafos

- **Grafo Direcionado:** Relações unidirecionais
- **Grafo Não-Direcionado:** Relações bidirecionais
- **Matriz de Adjacência:** Representação matricial
- **Lista de Adjacência:** Representação por listas

## 📂 Atividades Desenvolvidas

| Atividade        | Foco Principal          | Estruturas Implementadas       | Complexidade |
| ---------------- | ----------------------- | ------------------------------ | ------------ |
| **Atividade 01** | TADs Básicos            | Array, Lista Ligada            | ⭐⭐         |
| **Atividade 02** | Pilhas e Filas          | Stack, Queue, Deque            | ⭐⭐⭐       |
| **Atividade 03** | Árvores                 | BST, Heap, Traversal           | ⭐⭐⭐⭐     |
| **Atividade 04** | Algoritmos de Ordenação | QuickSort, MergeSort, HeapSort | ⭐⭐⭐⭐⭐   |

## 🔄 Algoritmos de Ordenação

### 🚀 Algoritmos Simples (O(n²))

```c
// Bubble Sort - Comparação de elementos adjacentes
void bubbleSort(int arr[], int n);

// Selection Sort - Seleção do menor elemento
void selectionSort(int arr[], int n);

// Insertion Sort - Inserção ordenada
void insertionSort(int arr[], int n);
```

### ⚡ Algoritmos Eficientes (O(n log n))

```c
// Quick Sort - Divisão e conquista
void quickSort(int arr[], int low, int high);

// Merge Sort - Divisão e combinação
void mergeSort(int arr[], int l, int r);

// Heap Sort - Usando estrutura heap
void heapSort(int arr[], int n);
```

## 🛠️ Tipos Abstratos de Dados (TADs)

### 📝 Definição de TAD

```c
// Exemplo: TAD Lista
typedef struct {
    int *data;
    int size;
    int capacity;
} Lista;

// Operações básicas
Lista* criarLista(int capacity);
void inserir(Lista *lista, int elemento);
void remover(Lista *lista, int posicao);
void destruirLista(Lista *lista);
```

## 🚀 Compilação e Execução

### Pré-requisitos

```bash
# Instalar GCC (se não disponível)
sudo apt install gcc  # Ubuntu/Debian
brew install gcc      # macOS
```

### Compilação

```bash
# Compilação simples
gcc -o programa arquivo.c

# Compilação com debugging
gcc -g -o programa arquivo.c

# Compilação com otimização
gcc -O2 -o programa arquivo.c

# Compilação com múltiplos arquivos
gcc -o programa main.c lista.c arvore.c
```

### Execução e Debugging

```bash
# Executar programa
./programa

# Debugging com GDB
gdb ./programa
(gdb) break main
(gdb) run
(gdb) step
```

## 📈 Análise de Complexidade

### ⏱️ Complexidade Temporal

| Algoritmo         | Melhor Caso | Caso Médio | Pior Caso  |
| ----------------- | ----------- | ---------- | ---------- |
| **Bubble Sort**   | O(n)        | O(n²)      | O(n²)      |
| **Quick Sort**    | O(n log n)  | O(n log n) | O(n²)      |
| **Merge Sort**    | O(n log n)  | O(n log n) | O(n log n) |
| **Busca Linear**  | O(1)        | O(n)       | O(n)       |
| **Busca Binária** | O(1)        | O(log n)   | O(log n)   |

### 💾 Complexidade Espacial

- **Algoritmos In-Place:** O(1) - Bubble Sort, Selection Sort
- **Algoritmos Recursivos:** O(log n) - Quick Sort
- **Algoritmos com Arrays Auxiliares:** O(n) - Merge Sort

## 🧪 Conceitos Fundamentais

- **Ponteiros e Alocação Dinâmica:** `malloc()`, `free()`, `realloc()`
- **Recursão:** Solução de problemas dividindo em subproblemas
- **Modularização:** Separação de TADs em arquivos `.h` e `.c`
- **Análise de Algoritmos:** Big O, Omega, Theta
- **Estruturas Dinâmicas:** Crescimento conforme necessidade

## 🔗 Recursos Complementares

- [Visualização de Algoritmos](https://visualgo.net/)
- [GeeksforGeeks - Data Structures](https://www.geeksforgeeks.org/data-structures/)
- [CS50 - Harvard](https://cs50.harvard.edu/)

---

_Esta disciplina é fundamental para formar a base algorítmica necessária para disciplinas avançadas e desenvolvimento de software eficiente e otimizado._
