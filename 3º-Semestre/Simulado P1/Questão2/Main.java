public class Main {
    public static void main(String[] args) {
        Animal animal = new Animal();
        animal.caminha();
        //animal.latir(); não funciona, pois latir é um método exclusivo da classe cachorro
        //animal.mia(); não funciona, pois miar é um método exclusivo da classe gato

        Cachorro bidu = new Cachorro();
        bidu.caminha();
        bidu.late();
        //bidu.mia(); não funciona, pois miar é um método exclusivo da classe gato

        Gato deBotas = new Gato();
        deBotas.caminha();
        //deBotas.latir(); não funciona, pois latir é um método exclusivo da classe cachorro
        deBotas.mia();

    }
}
