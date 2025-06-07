import java.util.Scanner;
public class Calculadora {
    double resultado;

    public Calculadora(double resultado){
        this.resultado = 0;
    }

    public void somar(double valor){
        resultado += valor;
    }

    public void subtrair(double valor){
        resultado -= valor;
    }

    public void multiplicar(double valor){
        resultado *= valor;
    }

    public void dividir(double valor){
        if (valor == 0){
            System.out.println("Não é possível dividir por 0, tente com outro valor");
        } else {
            resultado /= valor;
        }
    }

    public void zerar(){
        resultado = 0;
    }

    public void exibir(){
        System.out.println(resultado);
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        Calculadora calc = new Calculadora(0);
        String metodo = "none";
        String continua = "S";
        while ("S".equals(continua.toUpperCase())){

            System.out.printf("Insira um valor: ");
            double valor = in.nextDouble();

            System.out.printf("[1]. Multiplicar (*) \n[2]. Dividir (/)\n[3]. Somar (+)\n[4]. Subtrair (-)\n[5]. Zerar (0) \nInsira o sinal: ");
            metodo = in.next();

            if ("*".equals(metodo)){
                calc.multiplicar(valor);
            } else if ("/".equals(metodo)){
                calc.dividir(valor);
            } else if ("+".equals(metodo)){
                calc.somar(valor);
            } else if ("-".equals(metodo)){
                calc.subtrair(valor);
            } else if ("0".equals(metodo)){
                calc.zerar();
            } else {
                System.exit(1);
            }
            calc.exibir();

            System.out.printf("Deseja continuar? (S)im ou (N)ão ? ");
            continua = in.next();

             if (! "S".equals(continua.toUpperCase())){
                 break;
             }
        }
    }
}
