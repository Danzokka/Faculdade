/**
 * Classe Nó para implementação de lista encadeada.
 * Cada nó armazena um elemento inteiro e uma referência para o próximo nó.
 */
class Node {
  /**
   * Cria um novo Nó com um valor e referência para o próximo
   * @param {number} element - O valor inteiro a ser armazenado
   * @param {Node|null} next - Referência para o próximo nó (padrão: null)
   */
  constructor(element, next = null) {
    this.element = element;
    this.next = next;
  }
}

module.exports = Node;