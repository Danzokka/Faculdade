/**
 * Exceção lançada ao tentar acessar ou remover elementos de uma pilha vazia
 */
class EmptyStackException extends Error {
  constructor(message = "A pilha está vazia") {
    super(message);
    this.name = "EmptyStackException";
  }
}

module.exports = EmptyStackException;