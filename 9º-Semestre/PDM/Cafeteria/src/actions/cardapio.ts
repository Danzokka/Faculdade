import { items } from "../data/cardapio"

export function getCardapio() {

  // Simulate a delay to mimic a real API call
  
  const categories = Array.from(new Set(items.map(item => item.categoria)))

  const data = categories.map(category => {
    return {
      categoria: category,
      items: items.filter(item => item.categoria === category)
    }
  })

  
  return data
}