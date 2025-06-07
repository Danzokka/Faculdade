import { StyleSheet, Text, View } from "react-native";
import React from "react";
import { Input } from "./ui/input";
import { Label } from "./ui/label";

const fields = [
  {
    label: "Nome",
    placeholder: "Digite seu nome",
    type: "text",
  },
  {
    label: "Email",
    placeholder: "Digite seu email",
    type: "email",
  },
  {
    label: "Telefone",
    placeholder: "Digite seu telefone",
    type: "tel",
  },
  {
    label: "Data de Nascimento",
    placeholder: "Digite sua data de nascimento",
    type: "date",
  },
  {
    label: "Senha",
    placeholder: "Digite sua senha",
    type: "password",
  },
];

const Form = () => {
  return (
    <View className="w-full flex flex-col gap-4">
      {fields.map((field, index) => (
        <View key={index} className="w-full flex flex-col gap-2">
          <Label>{field.label}</Label>
          <Input
            placeholder={field.placeholder}
            keyboardType={
              field.type === "email"
                ? "email-address"
                : field.type === "tel"
                ? "phone-pad"
                : field.type === "text"
                ? "default"
                : undefined
            }
          />
        </View>
      ))}
    </View>
  );
};

export default Form;
