/**
 * Implementação de uma estrutura de dados Pilha usando uma lista simplesmente encadeada
 * A pilha segue o princípio de Último a Entrar, Primeiro a Sair (LIFO - Last-In-First-Out)
 */
const Node = require('./Node');
const EmptyStackException = require('./EmptyStackException');
const FullStackException = require('./FullStackException');

class Stack {
  /**
   * Cria uma nova Pilha com capacidade padrão de 10
   */
  constructor(capacity = 10) {
    if (capacity <= 0 || !Number.isInteger(capacity)) {
      throw new Error("IllegalArgumentException: A capacidade deve ser um número inteiro positivo");
    }
    this.capacity = capacity;
    this.header = null;  // Referência para o nó no topo da pilha
    this._size = 0;      // Número atual de elementos na pilha
  }

  /**
   * Verifica se a pilha está vazia
   * @returns {boolean} Verdadeiro se a pilha estiver vazia, falso caso contrário
   */
  empty() {
    return this.header === null;
  }

  /**
   * Recupera o elemento no topo da pilha sem removê-lo
   * @returns {number} O elemento no topo da pilha
   * @throws {EmptyStackException} Se a pilha estiver vazia
   */
  peek() {
    if (this.empty()) {
      throw new EmptyStackException();
    }
    return this.header.element;
  }

  /**
   * Recupera e remove o elemento no topo da pilha
   * @returns {number} O elemento no topo da pilha
   * @throws {EmptyStackException} Se a pilha estiver vazia
   */
  pop() {
    if (this.empty()) {
      throw new EmptyStackException();
    }

    const element = this.header.element;
    this.header = this.header.next;
    this._size--;

    return element;
  }

  /**
   * Insere um novo elemento no topo da pilha
   * @param {number} element - O elemento a ser inserido
   * @throws {FullStackException} Se a pilha estiver cheia
   */
  push(element) {
    if (this._size >= this.capacity) {
      throw new FullStackException();
    }

    // Cria um novo nó com o elemento fornecido e liga ao atual topo
    const newNode = new Node(element, this.header);
    this.header = newNode;
    this._size++;
  }

  /**
   * Obtém o número de elementos na pilha
   * @returns {number} O número de elementos na pilha
   */
  size() {
    return this._size;
  }
}

module.exports = Stack;