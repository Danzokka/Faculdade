# 📱 Programação para Dispositivos Móveis

![React Native](https://go-skill-icons.vercel.app/api/icons?i=react&theme=light) ![Expo](https://go-skill-icons.vercel.app/api/icons?i=expo&theme=light) ![TypeScript](https://go-skill-icons.vercel.app/api/icons?i=ts&theme=light) ![Node.js](https://go-skill-icons.vercel.app/api/icons?i=nodejs&theme=light)

## 📖 Descrição

Esta disciplina aborda o desenvolvimento de aplicações móveis multiplataforma usando React Native e Expo. Focamos na criação de interfaces responsivas, consumo de APIs, gerenciamento de estado e publicação de aplicativos para iOS e Android.

## 🎯 Objetivos de Aprendizagem

- Desenvolver **aplicações móveis nativas** multiplataforma
- Implementar **interfaces responsivas** e acessíveis
- Consumir **APIs REST** e gerenciar dados
- Aplicar **navegação** entre telas
- Utilizar **componentes nativos** do dispositivo
- Publicar aplicativos nas **lojas oficiais**

## 🛠️ Stack Tecnológica

### 📱 Frontend Mobile

```javascript
// Tecnologias principais
- React Native      // Framework multiplataforma
- Expo             // Toolchain e SDK
- TypeScript       // Type safety
- React Navigation // Navegação entre telas
- Context API      // Gerenciamento de estado
- AsyncStorage     // Persistência local
```

### 🔗 Backend Integration

```javascript
// Integração com backend
- Axios            // HTTP client
- REST APIs        // Comunicação com servidor
- JSON            // Formato de dados
- Auth tokens     // Autenticação
```

## 📂 Projetos Desenvolvidos

### ☕ Aplicativo Cafeteria

**Descrição:** Sistema completo de pedidos para cafeteria

**Funcionalidades:**

- 🏠 **Tela Inicial:** Apresentação e navegação
- 📋 **Cardápio:** Lista de produtos com filtros
- 🛒 **Carrinho:** Gestão de pedidos
- 👤 **Perfil:** Dados do usuário
- 💳 **Pagamento:** Integração com gateway

```typescript
// Exemplo de componente do cardápio
interface Product {
  id: string;
  name: string;
  price: number;
  image: string;
  category: string;
}

const MenuScreen: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [selectedCategory, setSelectedCategory] = useState("all");

  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = async () => {
    try {
      const response = await api.get("/products");
      setProducts(response.data);
    } catch (error) {
      Alert.alert("Erro", "Falha ao carregar produtos");
    }
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={filteredProducts}
        renderItem={({ item }) => <ProductCard product={item} />}
        keyExtractor={(item) => item.id}
      />
    </View>
  );
};
```

### 📝 Formulário Dinâmico

**Descrição:** Sistema de formulários configuráveis

**Características:**

- 🔧 **Configuração JSON:** Formulários definidos via JSON
- ✅ **Validação:** Regras customizáveis
- 💾 **Persistência:** Dados salvos localmente
- 📤 **Sincronização:** Upload para servidor

```typescript
// Schema de formulário dinâmico
interface FormField {
  id: string;
  type: "text" | "number" | "email" | "select" | "checkbox";
  label: string;
  required: boolean;
  validation?: ValidationRule[];
  options?: Option[];
}

interface FormSchema {
  id: string;
  title: string;
  fields: FormField[];
}

// Componente de campo dinâmico
const DynamicField: React.FC<{
  field: FormField;
  value: any;
  onChange: (value: any) => void;
}> = ({ field, value, onChange }) => {
  switch (field.type) {
    case "text":
      return (
        <TextInput
          placeholder={field.label}
          value={value}
          onChangeText={onChange}
          style={styles.textInput}
        />
      );
    case "select":
      return (
        <Picker selectedValue={value} onValueChange={onChange}>
          {field.options?.map((option) => (
            <Picker.Item
              key={option.value}
              label={option.label}
              value={option.value}
            />
          ))}
        </Picker>
      );
    default:
      return null;
  }
};
```

### 🔙 Backend para Consultas

**Descrição:** API REST para suporte aos aplicativos

**Tecnologias:**

- **Node.js + Express:** Servidor web
- **Prisma:** ORM para banco de dados
- **PostgreSQL:** Banco de dados relacional
- **JWT:** Autenticação via tokens

```typescript
// API Controller exemplo
export class ProductController {
  async getAllProducts(req: Request, res: Response) {
    try {
      const products = await prisma.product.findMany({
        include: {
          category: true,
          images: true,
        },
      });

      return res.json(products);
    } catch (error) {
      return res.status(500).json({ error: "Internal server error" });
    }
  }

  async createProduct(req: Request, res: Response) {
    const { name, price, categoryId, description } = req.body;

    try {
      const product = await prisma.product.create({
        data: {
          name,
          price,
          categoryId,
          description,
        },
      });

      return res.status(201).json(product);
    } catch (error) {
      return res.status(400).json({ error: "Invalid data" });
    }
  }
}
```

## 🧩 Componentes e Patterns

### 📱 Componentes Reutilizáveis

```typescript
// Button Component
interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: "primary" | "secondary" | "outline";
  disabled?: boolean;
}

const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  variant = "primary",
  disabled = false,
}) => {
  return (
    <TouchableOpacity
      style={[styles.button, styles[variant], disabled && styles.disabled]}
      onPress={onPress}
      disabled={disabled}
    >
      <Text style={[styles.buttonText, styles[`${variant}Text`]]}>{title}</Text>
    </TouchableOpacity>
  );
};

// Card Component
interface CardProps {
  children: React.ReactNode;
  onPress?: () => void;
  style?: ViewStyle;
}

const Card: React.FC<CardProps> = ({ children, onPress, style }) => {
  const Component = onPress ? TouchableOpacity : View;

  return (
    <Component style={[styles.card, style]} onPress={onPress}>
      {children}
    </Component>
  );
};
```

### 🗂️ Gerenciamento de Estado

```typescript
// Context para carrinho de compras
interface CartItem {
  id: string;
  product: Product;
  quantity: number;
}

interface CartContextData {
  items: CartItem[];
  addItem: (product: Product) => void;
  removeItem: (productId: string) => void;
  updateQuantity: (productId: string, quantity: number) => void;
  clearCart: () => void;
  total: number;
}

const CartContext = createContext<CartContextData>({} as CartContextData);

export const CartProvider: React.FC = ({ children }) => {
  const [items, setItems] = useState<CartItem[]>([]);

  const addItem = useCallback((product: Product) => {
    setItems((currentItems) => {
      const existingItem = currentItems.find(
        (item) => item.product.id === product.id
      );

      if (existingItem) {
        return currentItems.map((item) =>
          item.product.id === product.id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      } else {
        return [...currentItems, { id: nanoid(), product, quantity: 1 }];
      }
    });
  }, []);

  const total = useMemo(() => {
    return items.reduce(
      (sum, item) => sum + item.product.price * item.quantity,
      0
    );
  }, [items]);

  return (
    <CartContext.Provider
      value={{
        items,
        addItem,
        removeItem,
        updateQuantity,
        clearCart,
        total,
      }}
    >
      {children}
    </CartContext.Provider>
  );
};
```

## 🧭 Navegação

### 📍 React Navigation Setup

```typescript
// Tipos de navegação
export type RootStackParamList = {
  Home: undefined;
  ProductDetails: { productId: string };
  Cart: undefined;
  Profile: undefined;
  Login: undefined;
};

// Stack Navigator
const Stack = createNativeStackNavigator<RootStackParamList>();

export const AppNavigator: React.FC = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator
        initialRouteName="Home"
        screenOptions={{
          headerStyle: {
            backgroundColor: "#6200ee",
          },
          headerTintColor: "#fff",
          headerTitleStyle: {
            fontWeight: "bold",
          },
        }}
      >
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="ProductDetails" component={ProductDetailsScreen} />
        <Stack.Screen name="Cart" component={CartScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
```

## 💾 Persistência de Dados

### 📱 AsyncStorage

```typescript
// Utilities para storage
export class StorageService {
  static async setItem(key: string, value: any): Promise<void> {
    try {
      const jsonValue = JSON.stringify(value);
      await AsyncStorage.setItem(key, jsonValue);
    } catch (error) {
      console.error("Error saving data:", error);
    }
  }

  static async getItem<T>(key: string): Promise<T | null> {
    try {
      const jsonValue = await AsyncStorage.getItem(key);
      return jsonValue != null ? JSON.parse(jsonValue) : null;
    } catch (error) {
      console.error("Error loading data:", error);
      return null;
    }
  }

  static async removeItem(key: string): Promise<void> {
    try {
      await AsyncStorage.removeItem(key);
    } catch (error) {
      console.error("Error removing data:", error);
    }
  }
}
```

## 🎨 Estilização e UI

### 💅 StyleSheet e Responsive Design

```typescript
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f5f5f5",
    paddingHorizontal: 16,
  },
  card: {
    backgroundColor: "#ffffff",
    borderRadius: 8,
    padding: 16,
    marginBottom: 12,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  button: {
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 6,
    alignItems: "center",
    justifyContent: "center",
  },
  primary: {
    backgroundColor: "#6200ee",
  },
  secondary: {
    backgroundColor: "#03dac6",
  },
  outline: {
    borderWidth: 1,
    borderColor: "#6200ee",
    backgroundColor: "transparent",
  },
});

// Responsive dimensions
const { width: screenWidth, height: screenHeight } = Dimensions.get("window");

const responsiveStyles = StyleSheet.create({
  container: {
    paddingHorizontal: screenWidth * 0.05, // 5% das bordas
  },
  image: {
    width: screenWidth * 0.9,
    height: screenWidth * 0.6, // Aspect ratio 3:2
  },
});
```

## 🚀 Deploy e Distribuição

### 📦 Build e Publicação

```bash
# Expo build
expo build:android
expo build:ios

# EAS Build (recomendado)
eas build --platform android
eas build --platform ios

# Publicação
eas submit --platform android
eas submit --platform ios
```

### 🔧 Configuração de Build

```json
// eas.json
{
  "cli": {
    "version": ">= 3.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal"
    },
    "production": {}
  },
  "submit": {
    "production": {}
  }
}
```

## 📊 Performance e Otimização

- **Lazy Loading:** Carregamento sob demanda
- **Image Optimization:** Compressão e cache
- **Bundle Splitting:** Divisão do código
- **Memory Management:** Gestão de memória
- **Network Optimization:** Cache de requisições

## 🔗 Recursos Complementares

- [React Native Documentation](https://reactnative.dev/)
- [Expo Documentation](https://docs.expo.dev/)
- [React Navigation](https://reactnavigation.org/)
- [NativeBase UI Library](https://nativebase.io/)

---

_Esta disciplina prepara para o desenvolvimento profissional de aplicações móveis modernas, cobrindo desde conceitos básicos até técnicas avançadas de otimização e distribuição._
