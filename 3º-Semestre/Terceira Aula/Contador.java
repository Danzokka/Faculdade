/*Escreva a classe Contador que possua um número como estado e realize as seguintes ações:
a) Incrementar: adiciona mais um ao número.
b) Zerar: seta o contador para zero.
c) Exibir: deve imprimir na tela o valor do contador.
A classe deve incluir um construtor que inicializa o contador com zero ao instanciar um novo
objeto.*/

import java.util.Scanner;

public class Contador {
    int contador;

    public Contador(int contador){
        this.contador = 0;
    }

    public void incrementar(){
        contador = contador + 1;
    }

    public void zerar(){
        contador = 0;
    }

    public void exibir(){
        System.out.printf("O número é %d \n", contador);
    }

    public static void main(String[] args) {

    }
}