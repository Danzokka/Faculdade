export type CardapioItem = {
  nome: string;
  categoria: string;
  imagem: string;
  descricao: string;
  valor: number;
}

export const items: CardapioItem[] = [
  {
    nome: "Café",
    categoria: "Bebidas",
    imagem:
      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1200px-A_small_cup_of_coffee.JPG",
    descricao: "Café preto",
    valor: 2.5,
  },
  {
    nome: "Pão de queijo",
    categoria: "Salgados",
    imagem:
      "https://amopaocaseiro.com.br/wp-content/uploads/2022/08/yt-069_pao-de-queijo_receita-840x560.jpg",
    descricao: "Pão de queijo mineiro",
    valor: 3.5,
  },
  {
    nome: "Bolo",
    categoria: "Sobremesas",
    imagem:
      "https://www.estadao.com.br/resizer/v2/FIVYQFU6J5ND3PYRA6XQHR4NW4.jpg?quality=80&auth=04a93b8f4c288302da64fd8a96da7bb7cc11dff70430e4ba66587218d5b6011f&width=720&height=503&focal=0,0",
    descricao: "Bolo de cenoura",
    valor: 4.5,
  },
  {
    nome: "Refrigerante",
    categoria: "Bebidas",
    imagem:
      "https://www.coca-cola.com.br/content/dam/journey/br/pt/home/brands/coca-cola/coca-cola-regular.png",
    descricao: "Refrigerante de cola",
    valor: 3.0,
  },
  {
    nome: "Coxinha",
    categoria: "Salgados",
    imagem:
      "https://www.receiteria.com.br/wp-content/uploads/2020/03/receita-de-coxinha-para-vender.jpg",
    descricao: "Coxinha de frango",
    valor: 5.0,
  },
  {
    nome: "Pudim",
    categoria: "Sobremesas",
    imagem:
      "https://www.receitasnestle.com.br/images/receitas/receitas-pudim-de-leite-condensado.jpg",
    descricao: "Pudim de leite condensado",
    valor: 6.0,
  }
];