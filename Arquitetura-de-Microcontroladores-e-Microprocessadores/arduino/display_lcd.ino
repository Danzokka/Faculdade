#include <LiquidCrystal.h>

//Pinos do LCD
//LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
LiquidCrystal lcd(4, 3, 11, 12, 13, 14);

#define POTENCIOMETRO A0

void setup() {
  // Seta colunas e linhas do LCD
  lcd.begin(16, 2);
}

void loop() {
  // Le a entrada do potenciometro
  int potenciometroValue = analogRead(potenciometroValue);

  // Printa o potenciometro no LCD
  lcd.setCursor(0, 0);
  lcd.print("Potenciometro: ");
  lcd.setCursor(0, 1);
  
  lcd.print(potenciometroValue);

  // Delay para atualizar o LCD
  delay(100);
  
  Serial.println(potenciometroValue);
}
