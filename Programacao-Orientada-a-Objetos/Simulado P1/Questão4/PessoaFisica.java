public class PessoaFisica extends Cliente{
    private String cpf;

    public PessoaFisica(String nome, String endereco, String telefone, String cpf) {
        super(nome, endereco, telefone);
        this.cpf = cpf;
    }

    @Override
    public void exibir() {
        super.exibir();
        System.out.printf("\nCPF: %s", cpf);
    }
}
