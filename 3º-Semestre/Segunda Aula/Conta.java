import java.util.Scanner;

public class Conta {
    String nome;
    String cpf;
    double saldo;

    public Conta(String nome, String cpf, double saldo){
        this.nome = nome;
        this.cpf = cpf;
        this.saldo = saldo;
    }

    public double saque(double saldo){
        
        Scanner in = new Scanner(System.in);
        System.out.println("Quanto deseja sacar? ");
        int saque =  in.nextInt();
        if (saldo < saque){
            System.out.println("Saldo insuficiente");
            return saldo;
        }
        saldo = saldo - saque;
        System.out.println("\n");
        return saldo;
    }

    public double deposito(double saldo){
        
        Scanner in = new Scanner(System.in);
        System.out.println("Quanto deseja depositar? ");
        int deposito =  in.nextInt();        
        System.out.println("\n");
        saldo = deposito + saldo;
        
        return saldo;
    }

    public void exibicao(double saldo, String nome){
        //print do saldo da pessoa utilizando o saldo e o nome como parametros
        System.out.printf("%s você possuí %.2f \n", nome, saldo);
    }

    public static void main(String[] args) {
        Conta rafael = new Conta("Rafael", "123456789AB", 147000.00);
        //Para deixar o processo em loop até o usuário escolher sair
        Boolean retorno = true;
        Scanner in = new Scanner(System.in);
        while(retorno == true){

            System.out.print("Qual função deseja utilizar? Utilize o índice \n[1].Sacar \n[2].Depositar \n[3].Exibir Saldo \n[4]Sair \n");
            int funcao =  in.nextInt();   

            if (funcao == 1){
                //leva para o metodo saque
                rafael.saldo = rafael.saque(rafael.saldo);
            }
            else if (funcao == 2){
                //leva para o método deposito
                rafael.saldo = rafael.deposito(rafael.saldo);
            }
            else if (funcao == 3){
                //leva para o método exibicao
                rafael.exibicao(rafael.saldo, rafael.nome);
            }
            else if (funcao == 4){
                //encerra o programa
                System.exit(0);
            }
            else {
                //para repetir o programa até ser colocado um número valido
                Boolean erro = true;
                while(erro == true){
                    System.out.println("Insira um número valido");
                    funcao = in.nextInt();

                    if(funcao == 1 || funcao == 2 || funcao == 3){
                        erro =  false;
                    }
                    else{
                        erro = true;
                    }
                }
            }    
        }
    }
}