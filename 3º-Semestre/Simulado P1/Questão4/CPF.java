public class CPF extends Cliente{
    String cpf;

    public CPF(String nome, String endereco, String telefone, String cpf) {
        super(nome, endereco, telefone);
        this.cpf = cpf;
    }

    @Override
    public void exibir() {
        super.exibir();
        System.out.printf("\nCPF: %s", cpf);
    }
}
