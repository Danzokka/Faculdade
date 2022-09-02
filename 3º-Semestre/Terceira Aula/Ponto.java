public class Ponto {

    double x;
    double y;

    public Ponto(double x, double y){
        this.x = x;
        this.y = y;
    }

    public void mover(double x, double y){
        this.x = x;
        this.y = y;
    }

    public void incrementarX(){
        x++;
    }

    public void incrementarY(){
        y++;
    }

    public void decrementarX(){
        x--;
    }

    public void decrementarY(){
        y--;
    }

    public void exibir(){
        System.out.printf("X: %f Y: %f \n", x, y);
    }

    public static void main(String[] args) {

    }
}
