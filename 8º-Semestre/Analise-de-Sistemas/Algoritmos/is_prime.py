import time
import matplotlib.pyplot as plt

def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def main():
    prime_times = []
    non_prime_times = []
    prime_numbers = []
    non_prime_numbers = []
    numbers = range(5000)  # Reduzido para evitar longos tempos de execução
    
    for i in numbers:
        initial = time.time()
        result = is_prime(i)
        execution_time = time.time() - initial
        
        if result:
            prime_numbers.append(i)
            prime_times.append(execution_time)
        else:
            non_prime_numbers.append(i)
            non_prime_times.append(execution_time)
    
    # Plotar gráficos
    plt.figure(figsize=(12, 6))

    # Gráfico para números primos
    plt.subplot(1, 2, 1)
    plt.plot(prime_numbers, prime_times, label="Primos", color="blue")
    plt.xlabel("Números Primos")
    plt.ylabel("Tempo (segundos)")
    plt.title("Tempo de execução para números primos")
    plt.legend()
    plt.grid()

    # Gráfico para números não primos
    plt.subplot(1, 2, 2)
    plt.plot(non_prime_numbers, non_prime_times, label="Não Primos", color="red")
    plt.xlabel("Números Não Primos")
    plt.ylabel("Tempo (segundos)")
    plt.title("Tempo de execução para números não primos")
    plt.legend()
    plt.grid()

    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()