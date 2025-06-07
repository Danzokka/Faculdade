# Merge Sort Function
import random

def merge_sort(arr: list[int]) -> list[int]:
    # Caso base
    if len(arr) <= 1:
        return arr
    
    # Caso recursivo
    meio = len(arr) // 2
    
    esquerda = []
    direita = []
    
    for i in range(meio):
        esquerda.append(arr[i])
        
    for i in range(meio, len(arr)):
        direita.append(arr[i])
        
    esquerda = merge_sort(esquerda)
    direita = merge_sort(direita)
    
    return merge(esquerda, direita)

# Merge Function
def merge(esquerda: list[int], direita: list[int]) -> list[int]:
    merged = []
    esquerda_index = 0
    direita_index = 0
    
    # Enquanto houver elementos em ambos os arrays
    while esquerda_index < len(esquerda) and direita_index < len(direita):
        if esquerda[esquerda_index] < direita[direita_index]:
            merged.append(esquerda[esquerda_index])
            esquerda_index += 1
        else:
            merged.append(direita[direita_index])
            direita_index += 1
    
    # Adiciona os elementos restantes
    while esquerda_index < len(esquerda):
        merged.append(esquerda[esquerda_index])
        esquerda_index += 1
    
    while direita_index < len(direita):
        merged.append(direita[direita_index])
        direita_index += 1
    
    return merged

def gerar_array_com_numeros_aleatorios(tamanho: int) -> list[int]:
    arr = []
    for i in range(tamanho):
        arr.append(random.randint(0, 10000))
    return arr


# Test
arr = gerar_array_com_numeros_aleatorios(100)
print(merge_sort(arr))
