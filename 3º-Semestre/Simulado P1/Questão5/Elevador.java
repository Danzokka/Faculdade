/*Crie uma classe denominada Elevador para armazenar as informações de um elevador dentro de um prédio. A classe deve armazenar o andar atual (térreo = 0), total de andares no prédio (desconsiderando o térreo), capacidade do elevador e quantas pessoas estão presentes nele. A classe deve também disponibilizar os seguintes métodos:

Inicializa: que deve receber como parâmetros a capacidade do elevador e o total de andares no prédio (os elevadores sempre começam no térreo e vazio);

Entra: para acrescentar uma pessoa no elevador (só deve acrescentar se ainda houver espaço);

Sai: para remover uma pessoa do elevador (só deve remover se houver alguém dentro dele);

Sobe: para subir um andar (não deve subir se já estiver no último andar);

Desce: para descer um andar (não deve descer se já estiver no térreo);

Encapsular todos os atributos da classe com privado. Crie os métodos set e get.*/


public class Elevador {



    private int capacidade;
    private int andares;
    private int andar;
    private int pessoas;

    public int getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    public int getAndares() {
        return andares;
    }

    public void setAndares(int andares) {
        this.andares = andares;
    }

    public int getAndar() {
        return andar;
    }

    public void setAndar(int andar) {
        this.andar = andar;
    }

    public int getPessoas() {
        return pessoas;
    }

    public void setPessoas(int pessoas) {
        this.pessoas = pessoas;
    }

    public Elevador(){
        this.capacidade = 0;
        this.andares = 0;
        this.andar = 0;
        this.pessoas = 0;
    }

    public void inicializa(int capacidade, int andares, int andar, int pessoas){
        this.capacidade = capacidade;
        this.andares = andares;
        this.andar = 0;
        this.pessoas = 0;
    }

    public void entra(){
        if ((pessoas+1) > capacidade){
            pessoas = pessoas;
        } else {
            pessoas += 1;
        }
    }

    public void sai(){
        if ((pessoas-1) <= 0){
            pessoas = 0;
        } else {
            pessoas -= 1;
        }
    }

    public void sobe(){
        if ((andar+1) > andares){
            andar = andar;
        } else {
            andar += 1;
        }
    }

    public void desce(){
        if (andar <= 0){
            andar = 0;
        } else {
            andar -= 1;
        }
    }

    public static void main(String[] args) {
        Elevador exemplo = new Elevador();
        exemplo.inicializa(2,2,0,0);
        exemplo.entra();
        exemplo.entra();
        exemplo.entra();
        exemplo.sobe();
        exemplo.sobe();
        exemplo.sobe();
        System.out.println(exemplo.capacidade);
        System.out.println(exemplo.andares);
        System.out.println(exemplo.andar);
        System.out.println(exemplo.pessoas);
    }
}
