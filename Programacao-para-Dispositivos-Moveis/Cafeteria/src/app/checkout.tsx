import { StyleSheet, Text, View, ScrollView, FlatList } from "react-native";
import { Link } from "expo-router";
import { Button } from "../components/ui/button";
import { useCart } from "../context/Cart";
import Cardapio from "../components/Cardapio";
import React from "react";

const checkout = () => {
  const { cartItems } = useCart();
  const items = cartItems;

  return (
    <View className="bg-background w-full min-h-screen h-full flex flex-col items-center gap-4 py-12 px-4">
      <Text className="text-3xl font-bold w-full text-left text-text">
        Resumo da Compra
      </Text>
      <View className="w-full flex flex-col gap-4">
        <Text className="text-text">
          {items.length} {items.length > 1 ? "itens" : "item"} selecionado
        </Text>
        <ScrollView
          className="flex-grow-0 w-full"
          contentContainerClassName="flex flex-col w-full gap-4 overflow-hidden "
        >
          {items.map((item, index) => (
            <Cardapio props={item} key={index} func="removeFromCart" />
          ))}
        </ScrollView>
      </View>
      <Text className="w-full text-2xl text-left font-bold text-text">
        Total: R$ {items.reduce((acc, item) => acc + item.valor, 0)}
      </Text>
      <Text className="text-text/75 w-full text-left font-semibold">
        Ainda não tem conta?{" "}
        <Link href="/sign-up" asChild>
          <Text className="text-accent font-semibold">Crie uma conta</Text>
        </Link>{" "}
        e ganhe 10% de desconto na primeira compra!
      </Text>
      <Link href="/sign-up" asChild>
        <Button variant="default" className="w-full">
          <Text className="text-text">Finalizar Compra</Text>
        </Button>
      </Link>
    </View>
  );
};

export default checkout;

const styles = StyleSheet.create({});
