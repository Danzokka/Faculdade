## Determine a complexidade de tempo no pior caso das operações a seguir, para os seguintes tipos de listas:

- **Simplesmente encadeada**, sem descritor

- **Duplamente encadeada**, com os seguintes descritores: primeiro nó, último nó e comprimento

### Operações:
- **inserir_inicio:**
- - As duas funções apresentam complexidade de tempo constante, ou seja, O(1). Mesmo que a lista simplesmente encadeada não possua um descritor, não há a necessidade de percorrer toda a lista para inserir um novo elemento no início da lista.
- **inserir_fim:**
- - A complexidade de tempo para inserir um novo elemento no fim de uma lista Simplesmente Encadeada é O(n), já que é necessário percorrer todos os nós da lista até chegar no último elemento. Por outro lado, em uma lista Duplamente Encadeada, a complexidade é O(1), pois basta ajustar um ponteiro para adicionar o novo elemento no fim da lista.
- **deletar_inicio:**
- - Em ambas as listas, a complexidade de tempo para deletar um elemento no início é igual a O(1), pois a implementação de ambas as estruturas de dados permite que o elemento seja removido diretamente sem a necessidade de percorrer toda a lista.
- **deletar_fim:**
- - A lista Simplesmente Encadeada tem complexidade O(n) para remover um elemento no fim da lista, pois é necessário percorrer toda a lista para encontrar o elemento anterior ao que será removido. Já a lista Duplamente Encadeada tem complexidade O(1) para essa operação, já que basta ajustar os ponteiros do elemento a ser removido e do seu anterior.
- **listar:**
- - Em ambos os casos, a complexidade de tempo para listar os elementos será O(n), pois é necessário percorrer toda a lista para exibir cada um dos elementos armazenados.
- **Calcular o tamanho da lista:**
- - Calcular o comprimento de uma lista Simplesmente Encadeada requer uma complexidade de tempo O(n), pois é necessário percorrer toda a lista para contar seus elementos. Já em uma lista Duplamente Encadeada, a complexidade é O(1), pois é possível acessar o seu atributo comprimento e apenas retornar ele.

