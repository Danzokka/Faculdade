public class Main {
    public static void main(String[] args) {

        Contador c1 = new Contador(0);
        Contador c2 = new Contador(0);

        c1.incrementar();
        c2.incrementar();
        c1.zerar();
        c2.incrementar();
        c1.exibir();
        c2.exibir();

        Ponto p1 = new Ponto(1,1);
        Ponto p2 = new Ponto(2,2);

        p1.decrementarX();
        p1.decrementarY();
        p1.exibir();
        p1.mover(100,100);
        p1.exibir();
        p2.incrementarY();
        p2.incrementarX();
        p2.exibir();

    }
}
