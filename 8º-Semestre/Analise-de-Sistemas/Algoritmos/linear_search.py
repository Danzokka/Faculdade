# Linear Search Algorithm

import time

def linear_search(list: list[int], item: int) -> int:
    for i in range(len(list)):
        if list[i] == item:
            return i
    return None

def gerar_array_com_numeros_aleatorios(tamanho: int) -> list[int]:
    arr = []
    for i in range(tamanho):
        arr.append(i)
    return arr

arr = gerar_array_com_numeros_aleatorios(100)

start_time = time.time()
print(linear_search(arr, 11))
print("--- %s seconds ---" % (time.time() - start_time))