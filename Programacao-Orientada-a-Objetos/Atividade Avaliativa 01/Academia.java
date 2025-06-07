import java.util.Scanner;

public class Academia {

    String nome;
    String sobrenome;
    int idade;
    double altura;
    double peso;

    public Academia(String nome, String sobrenome, int idade, double altura, double peso){
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.idade = idade;
        this.altura = altura;
        this.peso = peso;
    }

    public void comer(String refeicao){

        if ("frutas".equals(refeicao)){
            peso += 0.05;
        }
        else if ("lanche".equals(refeicao)){
            peso += 0.1;
        }
        else if ("almoço".equals(refeicao) || "jantar".equals(refeicao)){
            peso += 0.2;
        } else {
            System.exit(1);
        }
    }

    public void treinar(String modalidade){

        if("intenso".equals(modalidade)){
            peso -= 0.15;
        } else if ("moderado".equals(modalidade)){
            peso -= 0.1;
        } else if ("leve".equals(modalidade)){
            peso -= 0.05;
        } else {
            System.exit(1);
        }
    }

    public void exibir(){
        double imc = peso / (altura * altura);
        System.out.println("+++++++++++++++++++++++++++++++");
        System.out.printf("Nome: %s %s \nIdade: %d anos\nAltura: %.2f m \nPeso: %.2f kg\nIMC: %.2f\nResultado: %s \n",nome, sobrenome, idade, altura, peso, imc, avaliarImc(imc));
        System.out.println("+++++++++++++++++++++++++++++++");
    }

    public static String avaliarImc(double imc){

        String resultadoImc = "Insira dados validos";
        if(imc < 16){
            resultadoImc = "Baixo peso Grau III";
        }else if (imc >= 16 && imc < 17){
            resultadoImc = "Baixo peso Grau II";
        }else if (imc >= 17 && imc < 18.5){
            resultadoImc = "Baixo peso Grau I";
        }else if (imc >= 18.5 && imc < 25){
            resultadoImc = "Peso Ideal";
        }else if (imc >= 25 && imc < 30){
            resultadoImc = "Sobrepeso";
        }else if (imc >= 30 && imc < 35){
            resultadoImc = "Obesidade Grau I";
        }else if (imc >= 35 && imc < 40){
            resultadoImc = "Obesidade Grau II";
        }else if (imc >= 40){
            resultadoImc = "Obesidade Grau III";
        }
        return resultadoImc;
    }

    public static Academia criar(){
        Scanner in = new Scanner(System.in);
        System.out.print("Insira o nome: ");
        String nome = in.next();
        System.out.print("Insira o sobrenome: ");
        String sobrenome = in.next();
        System.out.printf("Insira a idade: ");
        int idade = in.nextInt();
        System.out.printf("Insira a altura: ");
        double altura = in.nextDouble();
        System.out.printf("Insira o peso: ");
        double peso = in.nextDouble();
        System.out.println(" ");

        return new Academia(nome, sobrenome, idade, altura, peso);
    }

    public static void main(String[] args) {

        Scanner in = new Scanner(System.in);

        Academia pessoa = Academia.criar();

        System.out.print("[1]. Comer \n[2]. Treinar \nInsira pelo o índice: ");
        int metodo = in.nextInt();

        if (metodo == 1) {
            System.out.print("[1]. Frutas \n[2]. Lanche \n[3]. Almoço ou Janta \nInsira o nome: ");
            String comida = in.next();
            pessoa.comer(comida.toLowerCase());
        } else if (metodo == 2){
            System.out.print("[1]. Intenso \n[2]. Moderado \n[3]. Leve \nInsira o nome: ");
            String treino = in.next();
            pessoa.treinar(treino.toLowerCase());
        } else {
            System.exit(1);
        }

        pessoa.exibir();


    }
}
