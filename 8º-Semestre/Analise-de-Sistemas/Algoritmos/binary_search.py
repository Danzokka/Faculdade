# Implementando Binary Search
import time

def binary_search(list: list[int], item: int) -> int:
    baixo = 0
    alto = len(list) - 1
    
    while baixo <= alto:
        meio = (baixo + alto) // 2
        chute = list[meio]
        
        if chute == item:
            return meio
        if chute > item:
            alto = meio - 1
        else:
            baixo = meio + 1
    
    return None

def gerar_array_com_numeros_aleatorios(tamanho: int) -> list[int]:
    arr = []
    for i in range(tamanho):
        arr.append(i)
    return arr

arr = gerar_array_com_numeros_aleatorios(100)

start_time = time.time()
print(binary_search(arr, 160))
print("--- %s seconds ---" % (time.time() - start_time))