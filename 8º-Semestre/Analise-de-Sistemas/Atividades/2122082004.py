import os
clear = lambda: os.system('cls')

def funcao1():
    print("Hello Wordl! \n")
    print("O que mais vc esperava dessa funcao?")

def funcao2():
    numero = int(input("Insira o numero que deseja para a tabuada: "))
    
    for i in range(0,11):
        print(f'{numero} x {i} = {numero*i}')

def funcao3():
    valor_real = int(input("Insira o valor em Real: "))
    dolar_para_real = valor_real / 5.81
    print(f'Em dolar isso da aproximadamente ${dolar_para_real:,.2f} USD')
    
def funcao4():
    print("Rosas sao rosas, violetas sao rosas, eu sou daltonico")

def funcao5():
    digite_f = ""
    print("Ajude um desenvolvedor cansado, digite F para prestar respeito")
    while (digite_f != "f" and digite_f != "F"):
        digite_f = input("Preste respeito: ")
    
        
    

def menu():
    input_var = input("""
          1. Limpa console
          2. Tabuada do numero.
          3. Conversao do Dolar
          4. Recita poema
          5. Ajude um desenvolvedor
          Insira o input: """)
    match input_var:
        case "1":
            clear()
        case "2":
            funcao2()
        case "3":
            funcao3()
        case "4":
            funcao4()
        case "5":
            funcao5()
        case "x":
            return False
        case "X":
            return False
        case _:
            print("Insira um numero de 1 a 5 ou aperte x para sair")
    return True

looping = True
while (looping == True):
    looping = menu()