import { useEffect, useState } from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { CardapioItem } from "../data/cardapio";

export const useCart = () => {
  const [cartItems, setCartItems] = useState<CardapioItem[]>([]);

  // Carregar itens do AsyncStorage ao iniciar
  useEffect(() => {
    const loadCart = async () => {
      const storedCart = await AsyncStorage.getItem("cartItems");
      if (storedCart) {
        setCartItems(JSON.parse(storedCart));
      }
    };
    loadCart();
  }, []);

  // Salvar itens no AsyncStorage sempre que o estado mudar
  useEffect(() => {
    AsyncStorage.setItem("cartItems", JSON.stringify(cartItems));
  }, [cartItems]);

  const addToCart = (item: CardapioItem) => {
    setCartItems((prev) => [...prev, item]);
  };

  const removeFromCart = (item: CardapioItem) => {
    const updatedCart = cartItems.filter((i) => i.nome !== item.nome);
    setCartItems(updatedCart);
  };

  const clearCart = () => {
    setCartItems([]);
    AsyncStorage.removeItem("cartItems");
  };

  return {
    cartItems,
    addToCart,
    removeFromCart,
    clearCart,
  };
};
export default useCart;