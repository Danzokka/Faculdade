/**
 * Arquivo de teste para a implementação da Pilha (Stack)
 */
const Stack = require('./Stack');
const EmptyStackException = require('./EmptyStackException');
const FullStackException = require('./FullStackException');

// Cria uma pilha com capacidade padrão (10)
const stack = new Stack();
console.log("Criada uma nova pilha com capacidade padrão (10)");
console.log("A pilha está vazia?", stack.empty());  // true
console.log("Tamanho da pilha:", stack.size());     // 0

try {
    // Tenta recuperar elemento do topo de uma pilha vazia
    stack.peek();
} catch (error) {
    console.log("Erro:", error.message);  // "Stack is empty"
}

// Insere elementos na pilha
console.log("\nInserindo elementos na pilha:");
for (let i = 1; i <= 5; i++) {
    stack.push(i);
    console.log(`Inserido ${i}, tamanho da pilha: ${stack.size()}`);
}

console.log("\nA pilha está vazia?", stack.empty());  // false
console.log("Elemento do topo (peek):", stack.peek());  // 5

// Remove elementos da pilha
console.log("\nRemovendo elementos da pilha:");
for (let i = 0; i < 3; i++) {
    const element = stack.pop();
    console.log(`Removido ${element}, tamanho da pilha: ${stack.size()}`);
}

console.log("\nElemento do topo após remoções:", stack.peek());  // 2

// Cria uma pilha com capacidade personalizada
const smallStack = new Stack(3);
console.log("\nCriada uma nova pilha com capacidade 3");

// Insere elementos na pilha pequena até enchê-la
console.log("\nInserindo elementos na pilha pequena:");
for (let i = 1; i <= 3; i++) {
    smallStack.push(i);
    console.log(`Inserido ${i}, tamanho da pilha: ${smallStack.size()}`);
}

// Tenta inserir mais um elemento em uma pilha cheia
try {
    smallStack.push(4);
} catch (error) {
    console.log("Erro:", error.message);  // "Stack is full"
}

// Tenta criar uma pilha com capacidade inválida
try {
    const invalidStack = new Stack(-5);
} catch (error) {
    console.log("\nErro:", error.message);  // "IllegalArgumentException: Capacity must be a positive integer"
}