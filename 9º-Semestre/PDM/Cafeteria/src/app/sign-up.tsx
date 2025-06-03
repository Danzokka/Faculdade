import { View, Text } from "react-native";
import React from "react";
import Form from "../components/Form";
import { Button } from "../components/ui/button";

const Signup = () => {
  return (
    <View className="bg-background w-full min-h-screen h-full flex flex-col py-12 px-4 gap-4">
      <Text className="text-3xl font-bold text-left w-full text-text">Cadastro</Text>
      <Form />
      <Button variant="default" className="w-full">
        <Text className="text-white">Cadastrar</Text>
      </Button>
    </View>
  );
};

export default Signup;
