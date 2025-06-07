import java.util.Scanner;

public class ConversaoDeUnidadesDeVolume {
    public static double converteLitroEmCC(double litro){
        return litro * 1000;
    }

    public static double converteMCEmLitro(double mc){
        return mc*1000;
    }

    public static double converteMCemPes(double mc){
        return mc*(35.32);
    }

    public static double converteGalaoEmPolegadas(double galao){
        return galao*(231);
    }

    public static double converteGalaoEmLitros(double galao){
        return galao*(3.785);
    }

    public static void main(String[] args) {
    }
}