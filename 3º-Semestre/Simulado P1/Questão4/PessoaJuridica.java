public class PessoaJuridica extends Cliente{
    private String cnpj;
    private String nomeEmpresa;

    public PessoaJuridica(String nome, String endereco, String telefone, String cnpj, String nomeEmpresa) {
        super(nome, endereco, telefone);
        this.cnpj = cnpj;
        this.nomeEmpresa = nomeEmpresa;
    }

    @Override
    public void exibir() {
        super.exibir();
        System.out.printf("\nCNPJ: %s \nNome da Empresa: %s", cnpj, nomeEmpresa);
    }
}
