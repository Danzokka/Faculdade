lista_desornada = [1, 14, 2, 5, 2]

def acharTamanhoArray(arrayInput):
    elementos = 0
    try:
        while True:
            # Tenta acessar o elemento no índice atual
            _ = arrayInput[elementos]
            elementos += 1
    except IndexError:
        # Quando ocorrer um IndexError, significa que chegamos ao fim da lista
        pass
    return elementos

def bubbleSort(arrayInput):
    print(acharTamanhoArray(arrayInput))

bubbleSort(lista_desornada)