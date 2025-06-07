import { UserFormData } from "@/schemas/userSchema";
import AsyncStorage from "@react-native-async-storage/async-storage";

export class StorageService {
  private static readonly USER_DATA_KEY = "user_data";
  private static readonly USERS_LIST_KEY = "users_list";

  static async saveUser(userData: UserFormData): Promise<void> {
    try {
      const userWithId = {
        ...userData,
        id: Date.now().toString(),
        createdAt: new Date().toISOString(),
      };

      // Salvar usuário atual
      await AsyncStorage.setItem(
        this.USER_DATA_KEY,
        JSON.stringify(userWithId)
      );

      // Adicionar à lista de usuários
      const existingUsers = await this.getAllUsers();
      const updatedUsers = [...existingUsers, userWithId];
      await AsyncStorage.setItem(
        this.USERS_LIST_KEY,
        JSON.stringify(updatedUsers)
      );
    } catch (error) {
      console.error("Erro ao salvar usuário:", error);
      throw error;
    }
  }

  static async getCurrentUser(): Promise<UserFormData | null> {
    try {
      const userData = await AsyncStorage.getItem(this.USER_DATA_KEY);
      return userData ? JSON.parse(userData) : null;
    } catch (error) {
      console.error("Erro ao buscar usuário atual:", error);
      return null;
    }
  }

  static async getAllUsers(): Promise<any[]> {
    try {
      const usersData = await AsyncStorage.getItem(this.USERS_LIST_KEY);
      return usersData ? JSON.parse(usersData) : [];
    } catch (error) {
      console.error("Erro ao buscar lista de usuários:", error);
      return [];
    }
  }

  static async clearUserData(): Promise<void> {
    try {
      await AsyncStorage.removeItem(this.USER_DATA_KEY);
    } catch (error) {
      console.error("Erro ao limpar dados do usuário:", error);
      throw error;
    }
  }
}
