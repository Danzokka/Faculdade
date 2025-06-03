import java.util.ArrayList;
import java.util.List;

public class Shapes {
    private List<Triangle> triangles;
    
    public Shapes() {
        this.triangles = new ArrayList<>();
    }
    
    public void add(Triangle triangle) {
        triangles.add(triangle);
    }
    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        
        for (Triangle t : triangles) {
            if (t instanceof ScaleneTriangle) {
                ScaleneTriangle st = (ScaleneTriangle) t;
                sb.append("Triângulo escaleno\n");
                sb.append("Arestas: ").append(t.getEdges()).append("\n");
                sb.append("Vértices: ").append(t.getVertices()).append("\n");
                sb.append("Comprimento da aresta A: ").append(st.getEdgeA()).append("\n");
                sb.append("Comprimento da aresta B: ").append(st.getEdgeB()).append("\n");
                sb.append("Comprimento da aresta C: ").append(st.getEdgeC()).append("\n");
                sb.append("Área: ").append(t.area()).append("\n\n");
            } else if (t instanceof IsoscelesTriangle) {
                IsoscelesTriangle it = (IsoscelesTriangle) t;
                sb.append("Triângulo isósceles\n");
                sb.append("Arestas: ").append(t.getEdges()).append("\n");
                sb.append("Vértices: ").append(t.getVertices()).append("\n");
                sb.append("Comprimento da aresta: ").append(it.getEdgeA()).append("\n");
                sb.append("Comprimento da base: ").append(it.getEdgeB()).append("\n");
                sb.append("Área: ").append(t.area()).append("\n\n");
            } else if (t instanceof EquilateralTriangle) {
                sb.append("Triângulo equilátero\n");
                sb.append("Arestas: ").append(t.getEdges()).append("\n");
                sb.append("Vértices: ").append(t.getVertices()).append("\n");
                sb.append("Comprimento da aresta: ").append(((EquilateralTriangle) t).getEdgeA()).append("\n");
                sb.append("Área: ").append(t.area()).append("\n\n");
            }
        }
        
        return sb.toString().trim();
    }
}