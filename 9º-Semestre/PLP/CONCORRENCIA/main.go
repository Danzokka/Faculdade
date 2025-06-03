package main

import (
	"fmt"
	"sync"
)

// Verifica se um número é primo
func isPrime(num int) bool {
	if num <= 1 {
		return false
	}
	if num <= 3 {
		return true
	}
	if num%2 == 0 || num%3 == 0 {
		return false
	}

	i := 5
	for i*i <= num {
		if num%i == 0 || num%(i+2) == 0 {
			return false
		}
		i += 6
	}
	return true
}

// Encontra números primos em uma faixa específica de valores
func findPrimesInRange(start, end, id int, wg *sync.WaitGroup) {
	defer wg.Done()

	for i := start; i <= end; i++ {
		if isPrime(i) {
			fmt.Printf("%d: %d\n", id, i)
		}
	}
}

func main() {
	var wg sync.WaitGroup
	
	// Dividir o trabalho em 10 faixas (0-9999, 10000-19999, etc.)
	rangeSize := 10000
	
	for i := 0; i < 10; i++ {
		start := i * rangeSize
		end := (i + 1) * rangeSize - 1
		if end > 99999 {
			end = 99999
		}
		
		wg.Add(1)
		go findPrimesInRange(start, end, i, &wg)
	}
	
	// Aguardar todas as goroutines terminarem
	wg.Wait()
}