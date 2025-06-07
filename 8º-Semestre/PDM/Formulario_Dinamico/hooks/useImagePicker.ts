import * as ImagePicker from "expo-image-picker";
import { useState } from "react";
import { Alert } from "react-native";

export const useImagePicker = () => {
  const [image, setImage] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const requestPermission = async () => {
    const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (status !== "granted") {
      Alert.alert(
        "Permissão necessária",
        "Precisamos de permissão para acessar suas fotos."
      );
      return false;
    }
    return true;
  };

  const pickImage = async () => {
    const hasPermission = await requestPermission();
    if (!hasPermission) return;

    setIsLoading(true);
    try {
      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ["images"],
        allowsEditing: true,
        aspect: [1, 1],
        quality: 0.8,
        base64: true,
      });

      if (!result.canceled && result.assets[0]) {
        const imageBase64 = `data:image/jpeg;base64,${result.assets[0].base64}`;
        setImage(imageBase64);
        return imageBase64;
      }
    } catch (error) {
      console.error("Erro ao selecionar imagem:", error);
      Alert.alert("Erro", "Não foi possível selecionar a imagem");
    } finally {
      setIsLoading(false);
    }
  };

  const takePhoto = async () => {
    const { status } = await ImagePicker.requestCameraPermissionsAsync();
    if (status !== "granted") {
      Alert.alert(
        "Permissão necessária",
        "Precisamos de permissão para acessar a câmera."
      );
      return;
    }

    setIsLoading(true);
    try {
      const result = await ImagePicker.launchCameraAsync({
        allowsEditing: true,
        aspect: [1, 1],
        quality: 0.8,
        base64: true,
      });

      if (!result.canceled && result.assets[0]) {
        const imageBase64 = `data:image/jpeg;base64,${result.assets[0].base64}`;
        setImage(imageBase64);
        return imageBase64;
      }
    } catch (error) {
      console.error("Erro ao tirar foto:", error);
      Alert.alert("Erro", "Não foi possível tirar a foto");
    } finally {
      setIsLoading(false);
    }
  };

  const showImageOptions = () => {
    Alert.alert("Selecionar Imagem", "Escolha uma opção", [
      { text: "Galeria", onPress: pickImage },
      { text: "Câmera", onPress: takePhoto },
      { text: "Cancelar", style: "cancel" },
    ]);
  };

  const removeImage = () => {
    setImage(null);
  };

  return {
    image,
    isLoading,
    pickImage,
    takePhoto,
    showImageOptions,
    removeImage,
    setImage,
  };
};
