import { ShoppingCart, Trash2 } from "lucide-react-native";
import * as React from "react";
import { Button } from "~/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "~/components/ui/dropdown-menu";
import { Text } from "~/components/ui/text";
import { useColorScheme } from "~/lib/useColorScheme";
import { useCart } from "../context/Cart";
import { View, Image } from "react-native";
import { CardapioItem } from "../data/cardapio";
import { Link } from "expo-router";

const DropdownCardItem = ({ item }: { item: CardapioItem }) => {
  const { removeFromCart } = useCart();

  const handleRemoveItem = () => {
    removeFromCart(item);
    alert("Item removido do carrinho!");
  };

  return (
    <DropdownMenuItem className="relative flex flex-row items-center max-w-full">
      <Image source={{ uri: item.imagem }} className="w-12 h-12 rounded-lg" />
      <View className="flex flex-col gap-0.5 w-full ml-2">
        <Text className="text-text font-semibold truncate">{item.nome}</Text>
        <Text className="text-text/75 truncate">
          R$ {item.valor.toFixed(2).replace(".", ",")}
        </Text>
      </View>
      <Button
        variant="ghost"
        size="icon"
        className="absolute right-0 top-1/2 -translate-y-1/2 active:bg-transparent"
        onPress={handleRemoveItem}
      >
        <Trash2 color="red" />
      </Button>
    </DropdownMenuItem>
  );
};

export default function Cart() {
  const { isDarkColorScheme } = useColorScheme();
  const { cartItems } = useCart();

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost">
          <ShoppingCart color={isDarkColorScheme ? "white" : "black"} />
          {cartItems.length > 0 && (
            <View className="absolute top-0 right-0 bg-accent h-6 w-6 rounded-full flex items-center justify-center">
              <Text className="text-text text-xs font-bold">
                {cartItems.length}
              </Text>
            </View>
          )}
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent className="w-64 native:w-72 bg-background border-gray-800">
        <DropdownMenuLabel>Meu carrinho</DropdownMenuLabel>
        {cartItems.length > 0 ? (
          <DropdownMenuGroup className="flex flex-col">
            {cartItems.map((item) => (
              <React.Fragment key={item.nome}>
                <DropdownMenuSeparator className="border-gray-800" />
                <DropdownCardItem item={item} />
              </React.Fragment>
            ))}
          </DropdownMenuGroup>
        ) : (
          <>
            <DropdownMenuSeparator />
            <DropdownMenuItem disabled>
              <Text className="text-text/75">Carrinho vazio</Text>
            </DropdownMenuItem>
          </>
        )}
        {cartItems.length > 0 && (
          <>
            <DropdownMenuSeparator className="border-gray-800" />
            <DropdownMenuItem className="flex flex-row items-center justify-between">
              <Text className="text-text font-semibold">Total</Text>
              <Text className="text-text font-semibold">
                R${" "}
                {cartItems
                  .reduce((total, item) => total + item.valor, 0)
                  .toFixed(2)
                  .replace(".", ",")}
              </Text>
            </DropdownMenuItem>
            <DropdownMenuSeparator className="border-gray-800" />
            <DropdownMenuItem className="flex flex-row items-center justify-center">
              <Link asChild href="/checkout">
                <Button variant="secondary" className="w-full">
                  <Text className="text-text">Finalizar compra</Text>
                </Button>
              </Link>
            </DropdownMenuItem>
          </>
        )}
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
