public class Main {
    public static void main(String[] args) {
        Cliente teste1 = new PessoaFisica("Teste1", "Teste1", "Teste1", "Teste1");
        teste1.exibir();
        Cliente teste2 = new PessoaJuridica("Teste2","Teste2","Teste2","Teste2","Teste2");
        teste2.exibir();
    }
}
