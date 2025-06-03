import { useState } from "react";
import { Link } from "expo-router";
import { Text, View, ScrollView, FlatList } from "react-native";
import Categoria from "../components/Categoria";
import { getCardapio } from "../actions/cardapio";
import React from "react";
import { Button } from "../components/ui/button";

export default function Index() {
  const items = getCardapio();
  const [selectedCategory, setSelectedCategory] = useState("Todos");

  const categories: string[] = [
    "Todos",
    ...Array.from(new Set(items.map((item) => item.categoria))),
  ];

  const filteredItems =
    selectedCategory === "Todos"
      ? items
      : items.filter((item) => item.categoria === selectedCategory);

  return (
    <View className="w-full h-screen flex flex-col justify-center items-center gap-8 py-12 px-4 bg-background">
      <Text className="text-3xl font-bold w-full text-left text-text">
        Cardápio
      </Text>
      <ScrollView
        horizontal
        className="w-full"
        contentContainerClassName="gap-4 flex-row h-8 mb-4"
      >
        {categories.map((category) => (
          <Button
            onPress={() => setSelectedCategory(category)}
            key={category}
            className="px-4 py-2"
            size={"sm"}
            variant={selectedCategory === category ? "secondary" : "outline"}
          >
            <Text className="text-sm text-text font-semibold">{category}</Text>
          </Button>
        ))}
      </ScrollView>
      <FlatList
        className="flex flex-col w-full h-full"
        style={{ display: "flex", flexDirection: "column", gap: 12 }}
        contentContainerStyle={{ gap: 12 }}
        data={filteredItems}
        renderItem={({ item }) => (
          <Categoria
            category={item.categoria}
            items={item.items}
            key={item.categoria}
          />
        )}
        keyExtractor={(item) => item.categoria}
      />
    </View>
  );
}
