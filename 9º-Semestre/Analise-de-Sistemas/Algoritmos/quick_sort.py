# Quick Sort Function
import math
import time
import random

def quick_sort(arr: list[int]) -> list[int]:
    # Caso base
    if len(arr) <= 1:
        return arr
    
    # Caso recursivo
    
    # Com o pivo sendo o meio do array
    pivo = math.floor(len(arr) / 2)
    
    # Com o pivo sendo o primeiro elemento do array
    # pivo = 0
    
    # Com o pivo sendo o último elemento do array
    # pivo = len(arr) - 1
    
    # Com o pivo sendo um elemento aleatório do array
    # pivo = random.randint(0, len(arr) - 1)
    
    left = []
    meio = []
    right = []
    
    for i in range(len(arr)):
        if arr[i] < arr[pivo]:
            left.append(arr[i])
        elif arr[i] > arr[pivo]:
            right.append(arr[i])
        else:
            meio.append(arr[i])
    
    return quick_sort(left) + meio + quick_sort(right)

def gerar_array_com_numeros_aleatorios(tamanho: int) -> list[int]:
    arr = []
    for i in range(tamanho):
        arr.append(random.randint(0, 10000))
    return arr

# Test
arr = gerar_array_com_numeros_aleatorios(100)
start_time = time.time()
print(quick_sort(arr))
print("--- %s seconds ---" % (time.time() - start_time))