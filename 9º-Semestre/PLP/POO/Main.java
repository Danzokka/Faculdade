public class Main
{
  public static void main(String[] args)
  {
    Shapes shape = new Shapes();

    EquilateralTriangle equilateral = new EquilateralTriangle(3);
    shape.add(equilateral);

    IsoscelesTriangle isosceles = new IsoscelesTriangle(3, 4);
    shape.add(isosceles);

    ScaleneTriangle scalene = new ScaleneTriangle(3, 4, 5);
    shape.add(scalene);

    System.out.println(shape);
  }
}