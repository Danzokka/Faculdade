public class IsoscelesTriangle extends EquilateralTriangle {
    protected double edgeB;
    
    public IsoscelesTriangle(double edgeA, double edgeB) {
        super(edgeA);
        if (edgeB <= 0) {
            throw new IllegalArgumentException("Edge length must be greater than zero");
        }
        if (edgeA == edgeB) {
            throw new IllegalArgumentException("Edges must have different lengths in an isosceles triangle");
        }
        this.edgeB = edgeB;
    }
    
    public double getEdgeB() {
        return edgeB;
    }
    
    @Override
    public double area() {
        double h = Math.sqrt(edgeA * edgeA - (edgeB * edgeB / 4));
        return (edgeB * h) / 2;
    }
}