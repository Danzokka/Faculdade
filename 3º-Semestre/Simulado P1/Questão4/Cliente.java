/*Um sistema de cadastro de clientes de uma empresa guarda informações sobre nomes, endereços e telefones.
Além disso, caso o cliente seja uma pessoa física, seu número de CPF é armazenado e,
caso o cliente seja uma pessoa jurídica, seu CNPJ e nome de fantasia da empresa devem ser guardados.
A qualquer momento deve ser possível imprimir todos dados de um determinado cliente.*/

public class Cliente {
    String nome;
    String endereco;
    String telefone;


    public Cliente(String nome, String endereco, String telefone) {
        this.nome = nome;
        this.endereco = endereco;
        this.telefone = telefone;
    }

    public void exibir(){
        System.out.printf("Nome: %s \nEndereco: %s \nTelefone: %s", nome, telefone, endereco);
    }
}
