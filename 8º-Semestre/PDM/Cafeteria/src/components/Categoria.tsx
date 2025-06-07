import { StyleSheet, Text, View } from "react-native";
import Cardapio from "./Cardapio";
import React from "react";
import { CardapioItem } from "../data/cardapio";

interface CategoriaProps {
  category: string;
  items: CardapioItem[];
}

export default function Categoria({ category, items }: CategoriaProps) {
  return (
    <View className="w-full flex flex-col gap-4">
      <Text className="text-xl font-semibold text-text">{category}</Text>
      <View className="border border-gray-200 rounded-l-2xl rounded-r-2xl" />
      {items.map((item) => (
        <Cardapio props={item} key={item.nome} />
      ))}
    </View>
  );
}

const styles = StyleSheet.create({});
