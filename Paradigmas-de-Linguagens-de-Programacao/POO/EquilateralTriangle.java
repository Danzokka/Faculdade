public class EquilateralTriangle extends Triangle {
    protected double edgeA;
    
    public EquilateralTriangle(double edgeA) {
        if (edgeA <= 0) {
            throw new IllegalArgumentException("Edge length must be greater than zero");
        }
        this.edgeA = edgeA;
    }
    
    public double getEdgeA() {
        return edgeA;
    }
    
    @Override
    public double area() {
        return (Math.sqrt(3) / 4) * edgeA * edgeA;
    }
}