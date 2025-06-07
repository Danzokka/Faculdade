public class Cliente {
    private String nome;
    private String endereco;
    private String telefone;


    public Cliente(String nome, String endereco, String telefone) {
        this.nome = nome;
        this.endereco = endereco;
        this.telefone = telefone;
    }

    public void exibir(){
        System.out.printf("Nome: %s \nEndereco: %s \nTelefone: %s", nome, telefone, endereco);
    }
}
