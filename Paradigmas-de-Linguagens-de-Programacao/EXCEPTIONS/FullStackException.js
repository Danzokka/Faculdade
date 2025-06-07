/**
 * Exceção lançada ao tentar adicionar elementos a uma pilha cheia
 */
class FullStackException extends Error {
  constructor(message = "A pilha está cheia") {
    super(message);
    this.name = "FullStackException";
  }
}

module.exports = FullStackException;