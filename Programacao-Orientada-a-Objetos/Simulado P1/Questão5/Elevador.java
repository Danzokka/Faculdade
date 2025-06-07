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
}
