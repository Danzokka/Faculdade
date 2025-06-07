public class ScaleneTriangle extends IsoscelesTriangle {
    private double edgeC;
    
    public ScaleneTriangle(double edgeA, double edgeB, double edgeC) {
        super(edgeA, edgeB);
        if (edgeC <= 0) {
            throw new IllegalArgumentException("Edge length must be greater than zero");
        }
        if (edgeA == edgeB || edgeA == edgeC || edgeB == edgeC) {
            throw new IllegalArgumentException("All edges must have different lengths in a scalene triangle");
        }
        this.edgeC = edgeC;
    }
    
    public double getEdgeC() {
        return edgeC;
    }
    
    @Override
    public double area() {
        double s = (edgeA + edgeB + edgeC) / 2;
        return Math.sqrt(s * (s - edgeA) * (s - edgeB) * (s - edgeC));
    }
}