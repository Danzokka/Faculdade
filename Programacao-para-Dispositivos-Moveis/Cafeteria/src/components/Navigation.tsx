import { StyleSheet, Text, View } from "react-native";
import { useColorScheme } from "~/lib/useColorScheme";
import { TouchableOpacity } from "react-native-gesture-handler";
import React from "react";
import { Menu, Moon, Sun } from "lucide-react-native";
import Cart from "./Cart";

const Navigation = () => {
  const { isDarkColorScheme, toggleColorScheme } = useColorScheme();

  return (
    <View className="flex flex-row justify-between items-center px-4 bg-background pt-20 pb-4">
      <TouchableOpacity onPress={() => alert("Menu button pressed")}>
        <Menu size={24} color={isDarkColorScheme ? "white" : "black"} />
      </TouchableOpacity>
      <View className="flex flex-row items-center gap-4">
          <Cart />
        <TouchableOpacity onPress={toggleColorScheme}>
          {isDarkColorScheme ? (
            <Sun size={24} color={"white"} />
          ) : (
            <Moon size={24} color={"black"} />
          )}
        </TouchableOpacity>
      </View>
    </View>
  );
};

export default Navigation;

const styles = StyleSheet.create({});
