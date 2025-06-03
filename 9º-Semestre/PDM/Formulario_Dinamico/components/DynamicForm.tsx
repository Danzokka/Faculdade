import { useImagePicker } from "@/hooks/useImagePicker";
import { useThemeColor } from "@/hooks/useThemeColor";
import { UserFormData, userFormSchema } from "@/schemas/userSchema";
import { City, IBGEService, State } from "@/services/ibgeService";
import { StorageService } from "@/services/storageService";
import { zodResolver } from "@hookform/resolvers/zod";
import { Picker, PickerIOS } from "@react-native-picker/picker";
import React, { useEffect, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import {
  ActivityIndicator,
  Alert,
  Image,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";

interface ConditionalPickerProps {
  selectedValue: string;
  onValueChange: (value: string, index: number) => void;
  textColor: string;
  children: React.ReactNode;
  enabled?: boolean;
}

const ConditionalPicker: React.FC<ConditionalPickerProps> = ({
  selectedValue,
  onValueChange,
  textColor,
  children,
  enabled = true,
}) => {
  const handleValueChange = (itemValue: any, itemIndex: number) => {
    onValueChange(String(itemValue), itemIndex);
  };

  if (Platform.OS === "ios") {
    return (
      <PickerIOS
        selectedValue={selectedValue}
        onValueChange={handleValueChange}
        style={[{ color: textColor, minHeight: 120 }]}
      >
        {children}
      </PickerIOS>
    );
  }

  return (
    <Picker
      selectedValue={selectedValue}
      onValueChange={handleValueChange}
      style={[{ color: textColor }]}
      enabled={enabled}
    >
      {children}
    </Picker>
  );
};

interface ConditionalPickerItemProps {
  label: string;
  value: string;
}

const ConditionalPickerItem: React.FC<ConditionalPickerItemProps> = ({
  label,
  value,
}) => {
  if (Platform.OS === "ios") {
    return <PickerIOS.Item label={label} value={value} />;
  }
  return <Picker.Item label={label} value={value} />;
};

export default function DynamicForm() {
  const [states, setStates] = useState<State[]>([]);
  const [cities, setCities] = useState<City[]>([]);
  const [loadingStates, setLoadingStates] = useState(false);
  const [loadingCities, setLoadingCities] = useState(false);
  const [selectedState, setSelectedState] = useState<string>("");

  const backgroundColor = useThemeColor({}, "background");
  const textColor = useThemeColor({}, "text");
  const tintColor = useThemeColor({}, "tint");

  const {
    control,
    handleSubmit,
    setValue,
    watch,
    formState: { errors, isSubmitting },
    reset,
  } = useForm<UserFormData>({
    resolver: zodResolver(userFormSchema),
  });

  const {
    image,
    isLoading: imageLoading,
    showImageOptions,
    removeImage,
    setImage,
  } = useImagePicker();

  const watchedState = watch("state");
  useEffect(() => {
    loadStates();
    loadExistingUser();
  }, [loadExistingUser]);

  useEffect(() => {
    if (watchedState && watchedState !== selectedState) {
      setSelectedState(watchedState);
      loadCities(watchedState);
      setValue("city", ""); // Reset city when state changes
    }
  }, [watchedState, selectedState, setValue]);

  useEffect(() => {
    if (image) {
      setValue("image", image);
    }
  }, [image, setValue]);

  const loadStates = async () => {
    setLoadingStates(true);
    try {
      const statesData = await IBGEService.getStates();
      setStates(statesData);
    } catch {
      Alert.alert("Erro", "Não foi possível carregar os estados");
    } finally {
      setLoadingStates(false);
    }
  };

  const loadCities = async (stateId: string) => {
    if (!stateId) return;

    setLoadingCities(true);
    setCities([]);
    try {
      const citiesData = await IBGEService.getCitiesByState(stateId);
      setCities(citiesData);
    } catch {
      Alert.alert("Erro", "Não foi possível carregar as cidades");
    } finally {
      setLoadingCities(false);
    }
  };

  const loadExistingUser = async () => {
    try {
      const userData = await StorageService.getCurrentUser();
      if (userData) {
        reset(userData);
        if (userData.image) {
          setImage(userData.image);
        }
        if (userData.state) {
          setSelectedState(userData.state);
          loadCities(userData.state);
        }
      }
    } catch (error) {
      console.error("Erro ao carregar dados existentes:", error);
    }
  };

  const onSubmit = async (data: UserFormData) => {
    try {
      await StorageService.saveUser(data);
      Alert.alert("Sucesso", "Dados salvos com sucesso!", [
        {
          text: "OK",
          onPress: () => {
            // Optionally navigate to user list or reset form
          },
        },
      ]);
    } catch {
      Alert.alert("Erro", "Não foi possível salvar os dados");
    }
  };

  const clearForm = () => {
    Alert.alert(
      "Limpar Formulário",
      "Tem certeza que deseja limpar todos os dados?",
      [
        { text: "Cancelar", style: "cancel" },
        {
          text: "Limpar",
          style: "destructive",
          onPress: () => {
            reset();
            removeImage();
            setSelectedState("");
            setCities([]);
            StorageService.clearUserData();
          },
        },
      ]
    );
  };

  return (
    <ScrollView style={[styles.container, { backgroundColor }]}>
      <Text style={[styles.title, { color: textColor }]}>
        Cadastro de Usuário
      </Text>

      {/* Image Picker */}
      <View style={styles.imageContainer}>
        <Text style={[styles.label, { color: textColor }]}>Foto do Perfil</Text>
        {image ? (
          <View style={styles.imageWrapper}>
            <Image source={{ uri: image }} style={styles.profileImage} />
            <TouchableOpacity
              style={[styles.removeImageButton, { backgroundColor: "red" }]}
              onPress={removeImage}
            >
              <Text style={styles.removeImageText}>×</Text>
            </TouchableOpacity>
          </View>
        ) : (
          <TouchableOpacity
            style={[styles.imagePlaceholder, { borderColor: tintColor }]}
            onPress={showImageOptions}
            disabled={imageLoading}
          >
            {imageLoading ? (
              <ActivityIndicator color={tintColor} />
            ) : (
              <Text style={[styles.imagePlaceholderText, { color: tintColor }]}>
                Tocar para adicionar foto
              </Text>
            )}
          </TouchableOpacity>
        )}
      </View>

      {/* Name Field */}
      <View style={styles.fieldContainer}>
        <Text style={[styles.label, { color: textColor }]}>Nome *</Text>
        <Controller
          control={control}
          name="name"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              style={[
                styles.input,
                { color: textColor, borderColor: errors.name ? "red" : "#ccc" },
              ]}
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
              placeholder="Digite seu nome"
              placeholderTextColor="#999"
            />
          )}
        />
        {errors.name && (
          <Text style={styles.errorText}>{errors.name.message}</Text>
        )}
      </View>

      {/* Email Field */}
      <View style={styles.fieldContainer}>
        <Text style={[styles.label, { color: textColor }]}>Email *</Text>
        <Controller
          control={control}
          name="email"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              style={[
                styles.input,
                {
                  color: textColor,
                  borderColor: errors.email ? "red" : "#ccc",
                },
              ]}
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
              placeholder="Digite seu email"
              placeholderTextColor="#999"
              keyboardType="email-address"
              autoCapitalize="none"
            />
          )}
        />
        {errors.email && (
          <Text style={styles.errorText}>{errors.email.message}</Text>
        )}
      </View>

      {/* Phone Field */}
      <View style={styles.fieldContainer}>
        <Text style={[styles.label, { color: textColor }]}>Telefone *</Text>
        <Controller
          control={control}
          name="phone"
          render={({ field: { onChange, onBlur, value } }) => (
            <TextInput
              style={[
                styles.input,
                {
                  color: textColor,
                  borderColor: errors.phone ? "red" : "#ccc",
                },
              ]}
              onBlur={onBlur}
              onChangeText={onChange}
              value={value}
              placeholder="Digite seu telefone"
              placeholderTextColor="#999"
              keyboardType="phone-pad"
            />
          )}
        />
        {errors.phone && (
          <Text style={styles.errorText}>{errors.phone.message}</Text>
        )}
      </View>

      {/* State Field */}
      <View style={styles.fieldContainer}>
        <Text style={[styles.label, { color: textColor }]}>Estado *</Text>
        {loadingStates ? (
          <View style={styles.loadingContainer}>
            <ActivityIndicator color={tintColor} />
            <Text style={[styles.loadingText, { color: textColor }]}>
              Carregando estados...
            </Text>
          </View>
        ) : (
          <Controller
            control={control}
            name="state"
            render={({ field: { onChange, value } }) => (
              <View
                style={[
                  styles.pickerContainer,
                  { borderColor: errors.state ? "red" : "#ccc" },
                ]}
              >
                <ConditionalPicker
                  selectedValue={value}
                  onValueChange={(val) => onChange(val)}
                  textColor={textColor}
                >
                  <ConditionalPickerItem label="Selecione um estado" value="" />
                  {states.map((state) => (
                    <ConditionalPickerItem
                      key={state.id}
                      label={state.nome}
                      value={state.id.toString()}
                    />
                  ))}
                </ConditionalPicker>
              </View>
            )}
          />
        )}
        {errors.state && (
          <Text style={styles.errorText}>{errors.state.message}</Text>
        )}
      </View>

      {/* City Field */}
      <View style={styles.fieldContainer}>
        <Text style={[styles.label, { color: textColor }]}>Cidade *</Text>
        {loadingCities ? (
          <View style={styles.loadingContainer}>
            <ActivityIndicator color={tintColor} />
            <Text style={[styles.loadingText, { color: textColor }]}>
              Carregando cidades...
            </Text>
          </View>
        ) : (
          <Controller
            control={control}
            name="city"
            render={({ field: { onChange, value } }) => (
              <View
                style={[
                  styles.pickerContainer,
                  { borderColor: errors.city ? "red" : "#ccc" },
                ]}
              >
                <ConditionalPicker
                  selectedValue={value}
                  onValueChange={(val) => onChange(val)}
                  textColor={textColor}
                  enabled={cities.length > 0}
                >
                  <ConditionalPickerItem
                    label="Selecione uma cidade"
                    value=""
                  />
                  {cities.map((city) => (
                    <ConditionalPickerItem
                      key={city.id}
                      label={city.nome}
                      value={city.id.toString()}
                    />
                  ))}
                </ConditionalPicker>
              </View>
            )}
          />
        )}
        {errors.city && (
          <Text style={styles.errorText}>{errors.city.message}</Text>
        )}
      </View>

      {/* Buttons */}
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={[
            styles.button,
            styles.submitButton,
            { backgroundColor: tintColor },
          ]}
          onPress={handleSubmit(onSubmit)}
          disabled={isSubmitting}
        >
          {isSubmitting ? (
            <ActivityIndicator color="white" />
          ) : (
            <Text style={styles.buttonText}>Salvar</Text>
          )}
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.button, styles.clearButton]}
          onPress={clearForm}
          disabled={isSubmitting}
        >
          <Text style={[styles.buttonText, { color: "red" }]}>Limpar</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 30,
  },
  fieldContainer: {
    marginBottom: 20,
  },
  label: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 8,
  },
  input: {
    borderWidth: 1,
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: "transparent",
  },
  pickerContainer: {
    borderWidth: 1,
    borderRadius: 8,
    backgroundColor: "transparent",
  },
  picker: {
    height: 50,
  },
  errorText: {
    color: "red",
    fontSize: 14,
    marginTop: 4,
  },
  loadingContainer: {
    flexDirection: "row",
    alignItems: "center",
    padding: 12,
  },
  loadingText: {
    marginLeft: 8,
    fontSize: 14,
  },
  imageContainer: {
    alignItems: "center",
    marginBottom: 20,
  },
  imageWrapper: {
    position: "relative",
  },
  profileImage: {
    width: 120,
    height: 120,
    borderRadius: 60,
    marginTop: 10,
  },
  removeImageButton: {
    position: "absolute",
    top: 5,
    right: 5,
    width: 30,
    height: 30,
    borderRadius: 15,
    justifyContent: "center",
    alignItems: "center",
  },
  removeImageText: {
    color: "white",
    fontSize: 18,
    fontWeight: "bold",
  },
  imagePlaceholder: {
    width: 120,
    height: 120,
    borderRadius: 60,
    borderWidth: 2,
    borderStyle: "dashed",
    justifyContent: "center",
    alignItems: "center",
    marginTop: 10,
  },
  imagePlaceholderText: {
    fontSize: 14,
    textAlign: "center",
    paddingHorizontal: 10,
  },
  buttonContainer: {
    gap: 15,
    marginTop: 20,
    marginBottom: 40,
  },
  button: {
    padding: 15,
    borderRadius: 8,
    alignItems: "center",
  },
  submitButton: {
    backgroundColor: "#007AFF",
  },
  clearButton: {
    backgroundColor: "transparent",
    borderWidth: 1,
    borderColor: "red",
  },
  buttonText: {
    color: "white",
    fontSize: 16,
    fontWeight: "600",
  },
});
