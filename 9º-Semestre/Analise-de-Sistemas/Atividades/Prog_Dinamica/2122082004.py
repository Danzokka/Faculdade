import time

# Exercício 1: Fibonacci com Programação Dinâmica

def exercicio_1_1(n):
    if n <= 1:
        return n
    return exercicio_1_1(n - 1) + exercicio_1_1(n - 2)


def exercicio_1_2(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        return n
    memo[n] = exercicio_1_2(n - 1, memo) + exercicio_1_2(n - 2, memo)
    return memo[n]


def exercicio_1_3(n):
    if n <= 1:
        return n
    
    fib = [0] * (n + 1)
    fib[0] = 0
    fib[1] = 1
    
    for i in range(2, n + 1):
        fib[i] = fib[i - 1] + fib[i - 2]
        
    return fib[n]


# Exercício 2: Problema da Mochila 0/1

def exercicio_2(items, W):

    n = len(items)
    # Criar tabela dp com n+1 linhas e W+1 colunas
    dp = [[0 for _ in range(W + 1)] for _ in range(n + 1)]
    
    # Preencher a tabela dp
    for i in range(1, n + 1):
        w_i, v_i = items[i - 1]
        for w in range(W + 1):
            # Não incluir o item i
            dp[i][w] = dp[i - 1][w]
            
            # Incluir o item i se possível
            if w_i <= w:
                dp[i][w] = max(dp[i][w], dp[i - 1][w - w_i] + v_i)
    
    # Reconstruir a solução (quais itens foram selecionados)
    selected_items = []
    w = W
    for i in range(n, 0, -1):
        if dp[i][w] != dp[i - 1][w]:  # Este item foi incluído
            w_i, v_i = items[i - 1]
            selected_items.append(i - 1)  # Índice do item
            w -= w_i
    
    selected_items.reverse()  # Para manter a ordem original dos itens
    
    return dp[n][W], selected_items


# Exercício 3: Maior Subsequência Comum (LCS)

def exercicio_3(str1, str2):
    m, n = len(str1), len(str2)
    
    # Criar tabela dp com m+1 linhas e n+1 colunas
    dp = [[0 for _ in range(n + 1)] for _ in range(m + 1)]
    
    # Preencher a tabela dp
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if str1[i - 1] == str2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + 1
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
    
    # Reconstruir a subsequência
    lcs = []
    i, j = m, n
    while i > 0 and j > 0:
        if str1[i - 1] == str2[j - 1]:
            lcs.append(str1[i - 1])
            i -= 1
            j -= 1
        elif dp[i - 1][j] > dp[i][j - 1]:
            i -= 1
        else:
            j -= 1
    
    lcs.reverse()
    
    return dp[m][n], ''.join(lcs)


# Exercício 6: Distância de Edição (Levenshtein)

def exercicio_6(str1, str2):
    m, n = len(str1), len(str2)
    
    # Criar tabela dp com m+1 linhas e n+1 colunas
    dp = [[0 for _ in range(n + 1)] for _ in range(m + 1)]
    
    # Inicializar a primeira linha e coluna
    for i in range(m + 1):
        dp[i][0] = i
    for j in range(n + 1):
        dp[0][j] = j
    
    # Preencher a tabela dp
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if str1[i - 1] == str2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1]
            else:
                dp[i][j] = 1 + min(dp[i - 1][j],      # deleção
                                   dp[i][j - 1],      # inserção
                                   dp[i - 1][j - 1])  # substituição
    
    # Reconstruir as operações
    operations = []
    i, j = m, n
    
    while i > 0 or j > 0:
        if i > 0 and j > 0 and str1[i - 1] == str2[j - 1]:
            # Caracteres iguais, nenhuma operação necessária
            i -= 1
            j -= 1
        elif j > 0 and (i == 0 or dp[i][j] == dp[i][j - 1] + 1):
            # Inserção
            operations.append(f"Inserir '{str2[j - 1]}' na posição {i}")
            j -= 1
        elif i > 0 and (j == 0 or dp[i][j] == dp[i - 1][j] + 1):
            # Deleção
            operations.append(f"Deletar '{str1[i - 1]}' na posição {i-1}")
            i -= 1
        else:
            # Substituição
            operations.append(f"Substituir '{str1[i - 1]}' por '{str2[j - 1]}' na posição {i-1}")
            i -= 1
            j -= 1
    
    operations.reverse()
    
    return dp[m][n], operations


def main():
    print("Exercício 1: Fibonacci com Programação Dinâmica")
    test_values = [5, 10, 20, 30, 40, 45]
    
    print("\nVersão recursiva simples:")
    for n in test_values[:3]:  # Limita aos valores menores para evitar tempo excessivo
        start_time = time.time()
        result = exercicio_1_1(n)
        end_time = time.time()
        print(f"F({n}) = {result}, tempo: {end_time - start_time:.8f} segundos")
    
    print("\nVersão recursiva com memoização (top-down):")
    for n in test_values:
        memo = {}  # Limpa o memo para cada teste
        start_time = time.time()
        result = exercicio_1_2(n, memo)
        end_time = time.time()
        print(f"F({n}) = {result}, tempo: {end_time - start_time:.8f} segundos")
    
    print("\nVersão iterativa (bottom-up):")
    for n in test_values:
        start_time = time.time()
        result = exercicio_1_3(n)
        end_time = time.time()
        print(f"F({n}) = {result}, tempo: {end_time - start_time:.8f} segundos")
    
    print("\n\nExercício 2: Problema da Mochila 0/1")
    items = [(2, 3), (3, 4), (4, 5), (5, 8), (9, 10)]
    W = 20
    max_value, selected_items = exercicio_2(items, W)
    print(f"Valor máximo: {max_value}")
    print(f"Itens selecionados: {selected_items}")
    print("Detalhes dos itens selecionados:")
    total_weight = 0
    for idx in selected_items:
        weight, value = items[idx]
        total_weight += weight
        print(f"Item {idx}: peso {weight}, valor {value}")
    print(f"Peso total: {total_weight}, Valor total: {max_value}")
    
    print("\n\nExercício 3: Maior Subsequência Comum (LCS)")
    str1 = "AGGTAB"
    str2 = "GXTXAYB"
    length, subsequence = exercicio_3(str1, str2)
    print(f"String 1: {str1}")
    print(f"String 2: {str2}")
    print(f"Comprimento da LCS: {length}")
    print(f"Subsequência: {subsequence}")
    
    print("\n\nExercício 6: Distância de Edição (Levenshtein)")
    str1 = "kitten"
    str2 = "sitting"
    distance, operations = exercicio_6(str1, str2)
    print(f"String de origem: {str1}")
    print(f"String de destino: {str2}")
    print(f"Distância de edição: {distance}")
    print("Operações:")
    for op in operations:
        print(f"  - {op}")


if __name__ == "__main__":
    main()