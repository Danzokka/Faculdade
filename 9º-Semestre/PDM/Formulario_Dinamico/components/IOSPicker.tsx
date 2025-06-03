import { useThemeColor } from "@/hooks/useThemeColor";
import React, { useState } from "react";
import {
  Dimensions,
  Modal,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from "react-native";

interface PickerItem {
  label: string;
  value: string;
}

interface IOSPickerProps {
  items: PickerItem[];
  selectedValue: string;
  onValueChange: (value: string) => void;
  placeholder: string;
  style?: any;
  disabled?: boolean;
  error?: boolean;
}

export default function IOSPicker({
  items,
  selectedValue,
  onValueChange,
  placeholder,
  style,
  disabled = false,
  error = false,
}: IOSPickerProps) {
  const [modalVisible, setModalVisible] = useState(false);

  const backgroundColor = useThemeColor({}, "background");
  const textColor = useThemeColor({}, "text");
  const tintColor = useThemeColor({}, "tint");

  const selectedItem = items.find((item) => item.value === selectedValue);
  const displayText = selectedItem ? selectedItem.label : placeholder;

  const handleSelection = (value: string) => {
    onValueChange(value);
    setModalVisible(false);
  };

  return (
    <>
      <TouchableOpacity
        style={[
          styles.pickerButton,
          {
            borderColor: error ? "red" : "#ccc",
            backgroundColor: backgroundColor,
          },
          style,
        ]}
        onPress={() => !disabled && setModalVisible(true)}
        disabled={disabled}
      >
        <Text
          style={[
            styles.pickerText,
            {
              color: selectedValue ? textColor : "#999",
              opacity: disabled ? 0.5 : 1,
            },
          ]}
        >
          {displayText}
        </Text>
        <Text style={[styles.arrow, { color: textColor }]}>▼</Text>
      </TouchableOpacity>

      <Modal
        animationType="slide"
        transparent={true}
        visible={modalVisible}
        onRequestClose={() => setModalVisible(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={[styles.modalContent, { backgroundColor }]}>
            <View style={styles.modalHeader}>
              <TouchableOpacity
                onPress={() => setModalVisible(false)}
                style={styles.cancelButton}
              >
                <Text style={[styles.cancelText, { color: tintColor }]}>
                  Cancelar
                </Text>
              </TouchableOpacity>
              <Text style={[styles.modalTitle, { color: textColor }]}>
                {placeholder}
              </Text>
              <View style={styles.placeholder} />
            </View>

            <ScrollView style={styles.optionsList}>
              {items.map((item) => (
                <TouchableOpacity
                  key={item.value}
                  style={[
                    styles.optionItem,
                    selectedValue === item.value && {
                      backgroundColor: tintColor + "20",
                    },
                  ]}
                  onPress={() => handleSelection(item.value)}
                >
                  <Text
                    style={[
                      styles.optionText,
                      {
                        color: textColor,
                        fontWeight:
                          selectedValue === item.value ? "bold" : "normal",
                      },
                    ]}
                  >
                    {item.label}
                  </Text>
                  {selectedValue === item.value && (
                    <Text style={[styles.checkmark, { color: tintColor }]}>
                      ✓
                    </Text>
                  )}
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        </View>
      </Modal>
    </>
  );
}

const { height } = Dimensions.get("window");

const styles = StyleSheet.create({
  pickerButton: {
    borderWidth: 1,
    borderRadius: 8,
    padding: 12,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    minHeight: 50,
  },
  pickerText: {
    fontSize: 16,
    flex: 1,
  },
  arrow: {
    fontSize: 12,
    marginLeft: 8,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalContent: {
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    maxHeight: height * 0.7,
    paddingBottom: Platform.OS === "ios" ? 34 : 20,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: "#e0e0e0",
  },
  cancelButton: {
    paddingVertical: 8,
    paddingHorizontal: 12,
  },
  cancelText: {
    fontSize: 16,
    fontWeight: "600",
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "bold",
    flex: 1,
    textAlign: "center",
  },
  placeholder: {
    width: 60, // Same width as cancel button for centering
  },
  optionsList: {
    flex: 1,
  },
  optionItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "#e0e0e0",
  },
  optionText: {
    fontSize: 16,
    flex: 1,
  },
  checkmark: {
    fontSize: 18,
    fontWeight: "bold",
  },
});
