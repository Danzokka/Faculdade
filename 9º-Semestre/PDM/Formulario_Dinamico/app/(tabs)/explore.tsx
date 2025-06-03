import UserList from "@/components/UserList";
import { useThemeColor } from "@/hooks/useThemeColor";
import React from "react";
import { SafeAreaView, StyleSheet } from "react-native";

export default function TabTwoScreen() {
  const backgroundColor = useThemeColor({}, "background");

  return (
    <SafeAreaView style={[styles.container, { backgroundColor }]}>
      <UserList />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
