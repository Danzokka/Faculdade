import React, { createContext, useContext, useEffect, useState } from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { CardapioItem } from "../data/cardapio";

interface CartContextProps {
  cartItems: CardapioItem[];
  addToCart: (item: CardapioItem) => void;
  removeFromCart: (item: CardapioItem) => void;
  clearCart: () => void;
}

const CartContext = createContext<CartContextProps | undefined>(undefined);

export const CartProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [cartItems, setCartItems] = useState<CardapioItem[]>([]);

  useEffect(() => {
    const loadCart = async () => {
      const storedCart = await AsyncStorage.getItem("cartItems");
      if (storedCart) {
        setCartItems(JSON.parse(storedCart));
      }
    };
    loadCart();
  }, []);

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

  return (
    <CartContext.Provider
      value={{ cartItems, addToCart, removeFromCart, clearCart }}
    >
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context) {
    throw new Error("useCart must be used within a CartProvider");
  }
  return context;
};
