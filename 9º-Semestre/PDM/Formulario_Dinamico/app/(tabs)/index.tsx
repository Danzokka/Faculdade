import DynamicForm from "@/components/DynamicForm";
import { useThemeColor } from "@/hooks/useThemeColor";
import React from "react";
import { SafeAreaView, StyleSheet } from "react-native";

export default function HomeScreen() {
  const backgroundColor = useThemeColor({}, "background");

  return (
    <SafeAreaView style={[styles.container, { backgroundColor }]}>
      <DynamicForm />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
