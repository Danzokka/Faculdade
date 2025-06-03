import { useThemeColor } from "@/hooks/useThemeColor";
import { StorageService } from "@/services/storageService";
import { useFocusEffect } from "@react-navigation/native";
import React, { useCallback, useState } from "react";
import {
  Alert,
  FlatList,
  Image,
  RefreshControl,
  StyleSheet,
  Text,
  View,
} from "react-native";

interface User {
  id: string;
  name: string;
  email: string;
  phone: string;
  state: string;
  city: string;
  image?: string;
  createdAt: string;
}

export default function UserList() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);

  const backgroundColor = useThemeColor({}, "background");
  const textColor = useThemeColor({}, "text");
  const tintColor = useThemeColor({}, "tint");

  const loadUsers = async (isRefresh = false) => {
    try {
      if (!isRefresh) setLoading(true);
      const usersData = await StorageService.getAllUsers();
      setUsers(usersData.reverse()); // Show newest first
    } catch (error) {
      console.error("Erro ao carregar usuários:", error);
      Alert.alert("Erro", "Não foi possível carregar a lista de usuários");
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useFocusEffect(
    useCallback(() => {
      loadUsers();
    }, [])
  );

  const onRefresh = () => {
    setRefreshing(true);
    loadUsers(true);
  };

  const formatDate = (dateString: string) => {
    try {
      const date = new Date(dateString);
      return date.toLocaleString("pt-BR", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    } catch {
      return "Data inválida";
    }
  };

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((word) => word.charAt(0))
      .join("")
      .substring(0, 2)
      .toUpperCase();
  };

  const renderUser = ({ item }: { item: User }) => (
    <View
      style={[
        styles.userCard,
        { backgroundColor: backgroundColor, borderColor: "#e0e0e0" },
      ]}
    >
      <View style={styles.userHeader}>
        <View style={styles.avatarContainer}>
          {item.image ? (
            <Image source={{ uri: item.image }} style={styles.avatar} />
          ) : (
            <View
              style={[styles.avatarPlaceholder, { backgroundColor: tintColor }]}
            >
              <Text style={styles.avatarText}>{getInitials(item.name)}</Text>
            </View>
          )}
        </View>
        <View style={styles.userInfo}>
          <Text style={[styles.userName, { color: textColor }]}>
            {item.name}
          </Text>
          <Text style={[styles.userEmail, { color: "#666" }]}>
            {item.email}
          </Text>
          <Text style={[styles.userPhone, { color: "#666" }]}>
            {item.phone}
          </Text>
        </View>
      </View>

      <View style={styles.locationContainer}>
        <Text style={[styles.locationText, { color: textColor }]}>
          📍 Estado: {item.state} | Cidade: {item.city}
        </Text>
      </View>

      <View style={styles.dateContainer}>
        <Text style={[styles.dateText, { color: "#888" }]}>
          Cadastrado em: {formatDate(item.createdAt)}
        </Text>
      </View>
    </View>
  );

  const EmptyList = () => (
    <View style={styles.emptyContainer}>
      <Text style={[styles.emptyText, { color: textColor }]}>
        Nenhum usuário cadastrado ainda
      </Text>
      <Text style={[styles.emptySubtext, { color: "#666" }]}>
        Vá para a aba "Formulário" para cadastrar o primeiro usuário
      </Text>
    </View>
  );

  return (
    <View style={[styles.container, { backgroundColor }]}>
      <Text style={[styles.title, { color: textColor }]}>
        Usuários Cadastrados
      </Text>

      <FlatList
        data={users}
        renderItem={renderUser}
        keyExtractor={(item) => item.id}
        contentContainerStyle={styles.listContainer}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={onRefresh}
            tintColor={tintColor}
          />
        }
        ListEmptyComponent={EmptyList}
        showsVerticalScrollIndicator={false}
      />
    </View>
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
    marginBottom: 20,
  },
  listContainer: {
    flexGrow: 1,
  },
  userCard: {
    borderWidth: 1,
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  userHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
  },
  avatarContainer: {
    marginRight: 16,
  },
  avatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
  },
  avatarPlaceholder: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: "center",
    alignItems: "center",
  },
  avatarText: {
    color: "white",
    fontSize: 18,
    fontWeight: "bold",
  },
  userInfo: {
    flex: 1,
  },
  userName: {
    fontSize: 18,
    fontWeight: "bold",
    marginBottom: 4,
  },
  userEmail: {
    fontSize: 14,
    marginBottom: 2,
  },
  userPhone: {
    fontSize: 14,
  },
  locationContainer: {
    marginBottom: 8,
  },
  locationText: {
    fontSize: 14,
    fontStyle: "italic",
  },
  dateContainer: {
    borderTopWidth: 1,
    borderTopColor: "#e0e0e0",
    paddingTop: 8,
  },
  dateText: {
    fontSize: 12,
    textAlign: "right",
  },
  emptyContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingHorizontal: 40,
  },
  emptyText: {
    fontSize: 18,
    fontWeight: "600",
    textAlign: "center",
    marginBottom: 8,
  },
  emptySubtext: {
    fontSize: 14,
    textAlign: "center",
    lineHeight: 20,
  },
});
