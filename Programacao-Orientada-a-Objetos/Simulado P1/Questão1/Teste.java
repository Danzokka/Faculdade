import java.util.Scanner;

public class Teste {
    public static void main(String[] args) {

        Scanner in = new Scanner(System.in);

        System.out.printf("Métodos de conversão: \n [1]. Litro -> Centémetro Cúbico \n [2]. Metro Cúbico -> Litro \n [3]. Metro Cúbico -> Pés \n [4]. Galão -> Polegada \n [5]. Galão -> Litro \nMétodo: ");
        int metodo = in.nextInt();

        System.out.printf("Insira a quantidade para a conversão: ");
        double quantidade = in.nextDouble();

        switch (metodo){
            case 1:
                System.out.println(ConversaoDeUnidadesDeVolume.converteLitroEmCC(quantidade));
                break;
            case 2:
                System.out.println(ConversaoDeUnidadesDeVolume.converteMCEmLitro(quantidade));
                break;
            case 3:
                System.out.println(ConversaoDeUnidadesDeVolume.converteMCemPes(quantidade));
                break;
            case 4:
                System.out.println(ConversaoDeUnidadesDeVolume.converteGalaoEmPolegadas(quantidade));
                break;
            case 5:
                System.out.println(ConversaoDeUnidadesDeVolume.converteGalaoEmLitros(quantidade));
                break;
            default:
                System.out.println("Insira um número válido");
        }
    }
}
