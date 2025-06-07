# ⚡ Projetos Hardware

![Arduino](https://go-skill-icons.vercel.app/api/icons?i=arduino&theme=light) ![C++](https://go-skill-icons.vercel.app/api/icons?i=cpp&theme=light) ![ESP32](https://img.shields.io/badge/ESP32-000000?style=flat&logo=espressif&logoColor=red)

## 📖 Descrição

Esta seção agrupa projetos relacionados ao desenvolvimento de sistemas embarcados, utilizando principalmente Arduino e ESP32. Os projetos abordam desde conceitos básicos de eletrônica digital até implementações complexas de IoT e automação.

## 🎯 Objetivos de Aprendizagem

- Desenvolver **sistemas embarcados** usando microcontroladores
- Implementar **comunicação IoT** (WiFi, Bluetooth, LoRa)
- Aplicar **sensores e atuadores** em projetos práticos
- Programar em **C/C++** para microcontroladores
- Integrar **hardware e software** em soluções completas
- Desenvolver **protótipos funcionais** para problemas reais

## 🔧 Plataformas de Desenvolvimento

### 🤖 Arduino

**Características:**

- Microcontrolador ATmega328P
- 14 pinos digitais, 6 pinos analógicos
- Clock de 16MHz
- Ideal para projetos educacionais

```cpp
// Exemplo básico - Blink LED
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
```

### 📡 ESP32

**Características:**

- Dual-core Tensilica LX6
- WiFi e Bluetooth integrados
- Até 18 canais ADC
- Ideal para projetos IoT

```cpp
#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "Minha_Rede";
const char* password = "minha_senha";

WebServer server(80);

void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Conectando ao WiFi...");
  }

  server.on("/", handleRoot);
  server.begin();
  Serial.println("Servidor iniciado!");
}

void handleRoot() {
  server.send(200, "text/html", "<h1>ESP32 Web Server</h1>");
}

void loop() {
  server.handleClient();
}
```

## 📂 Projetos Desenvolvidos

### 🌡️ Sistema de Monitoramento Ambiental

**Plataforma:** ESP32  
**Sensores:** DHT22, BMP280, Sensor de Solo  
**Comunicação:** WiFi + MQTT

**Funcionalidades:**

- Monitoramento de temperatura e umidade
- Medição de pressão atmosférica
- Análise de umidade do solo
- Dashboard web em tempo real
- Alertas via Telegram

```cpp
#include <DHT.h>
#include <WiFi.h>
#include <PubSubClient.h>

#define DHT_PIN 4
#define DHT_TYPE DHT22

DHT dht(DHT_PIN, DHT_TYPE);
WiFiClient espClient;
PubSubClient mqtt(espClient);

void setup() {
  Serial.begin(115200);
  dht.begin();

  connectWiFi();
  mqtt.setServer("broker.mqtt.org", 1883);
}

void loop() {
  float temp = dht.readTemperature();
  float humidity = dht.readHumidity();

  if (!isnan(temp) && !isnan(humidity)) {
    publishSensorData(temp, humidity);
  }

  delay(30000); // Envia dados a cada 30 segundos
}

void publishSensorData(float temp, float humidity) {
  String payload = "{\"temperature\":" + String(temp) +
                   ",\"humidity\":" + String(humidity) + "}";

  mqtt.publish("sensors/environmental", payload.c_str());
}
```

### 🏠 Sistema de Automação Residencial

**Plataforma:** Arduino + ESP32  
**Componentes:** Relés, Sensores PIR, LDR  
**Interface:** App móvel + Web

**Funcionalidades:**

- Controle de iluminação automático
- Detecção de presença
- Controle remoto via WiFi
- Programação de horários
- Consumo energético

### 🚗 Sistema de Controle Veicular

**Plataforma:** Arduino  
**Sensores:** Ultrassônico, GPS, Acelerômetro  
**Atuadores:** Motores DC, Servo

**Características:**

- Detecção de obstáculos
- Controle de velocidade PWM
- Sistema de navegação GPS
- Telemetria via Serial

```cpp
#include <Servo.h>
#include <NewPing.h>

#define TRIGGER_PIN 12
#define ECHO_PIN 11
#define MAX_DISTANCE 200

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
Servo servoMotor;

int motorEsquerda = 3;
int motorDireita = 5;

void setup() {
  servoMotor.attach(9);
  pinMode(motorEsquerda, OUTPUT);
  pinMode(motorDireita, OUTPUT);

  servoMotor.write(90); // Posição central
}

void loop() {
  int distancia = sonar.ping_cm();

  if (distancia > 20) {
    moverFrente();
  } else {
    pararMotores();
    evitarObstaculo();
  }

  delay(100);
}

void evitarObstaculo() {
  // Verificar direções
  servoMotor.write(45);  // Olhar direita
  delay(500);
  int distanciaDireita = sonar.ping_cm();

  servoMotor.write(135); // Olhar esquerda
  delay(500);
  int distanciaEsquerda = sonar.ping_cm();

  servoMotor.write(90);  // Voltar ao centro

  if (distanciaDireita > distanciaEsquerda) {
    virarDireita();
  } else {
    virarEsquerda();
  }
}
```

## 📡 Comunicação e Conectividade

### 📶 Protocolos Implementados

| Protocolo     | Alcance | Velocidade | Consumo     | Aplicação         |
| ------------- | ------- | ---------- | ----------- | ----------------- |
| **WiFi**      | 100m    | Alta       | Médio       | IoT doméstico     |
| **Bluetooth** | 10m     | Média      | Baixo       | Controle local    |
| **LoRa**      | 15km    | Baixa      | Muito baixo | Sensores remotos  |
| **Zigbee**    | 100m    | Média      | Baixo       | Malha de sensores |

### 🌐 Integração com Cloud

```cpp
#include <HTTPClient.h>
#include <ArduinoJson.h>

void sendToCloud(float temperature, float humidity) {
  HTTPClient http;
  http.begin("https://api.thingspeak.com/update");
  http.addHeader("Content-Type", "application/json");

  StaticJsonDocument<200> doc;
  doc["api_key"] = "YOUR_API_KEY";
  doc["field1"] = temperature;
  doc["field2"] = humidity;

  String jsonString;
  serializeJson(doc, jsonString);

  int httpResponseCode = http.POST(jsonString);

  if (httpResponseCode > 0) {
    Serial.println("Dados enviados com sucesso!");
  }

  http.end();
}
```

## ⚙️ Sensores e Atuadores

### 📊 Sensores Utilizados

```cpp
// Sensor de Temperatura DHT22
#include <DHT.h>
DHT dht(4, DHT22);

// Sensor Ultrassônico HC-SR04
#include <NewPing.h>
NewPing sonar(12, 11, 200);

// Sensor de Movimento PIR
int pirPin = 2;
bool motionDetected = digitalRead(pirPin);

// Sensor de Luminosidade LDR
int ldrPin = A0;
int lightLevel = analogRead(ldrPin);

// Acelerômetro MPU6050
#include <MPU6050.h>
MPU6050 mpu;
```

### 🎛️ Atuadores e Controle

```cpp
// Controle de Motor DC com PWM
int motorPin = 3;
int velocidade = 150; // 0-255
analogWrite(motorPin, velocidade);

// Servo Motor
#include <Servo.h>
Servo servo;
servo.attach(9);
servo.write(90); // Posição em graus

// Relé para cargas AC
int relePin = 7;
digitalWrite(relePin, HIGH); // Liga
digitalWrite(relePin, LOW);  // Desliga

// Display LCD I2C
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
lcd.print("Temperatura: ");
lcd.print(temperatura);
```

## 🔋 Gerenciamento de Energia

### ⚡ Otimização de Consumo

```cpp
#include <esp_sleep.h>

void enterDeepSleep(int seconds) {
  esp_sleep_enable_timer_wakeup(seconds * 1000000);
  esp_deep_sleep_start();
}

// Exemplo de uso
void loop() {
  // Executar tarefas
  readSensors();
  sendData();

  // Dormir por 5 minutos
  enterDeepSleep(300);
}
```

## 🛠️ Ferramentas de Desenvolvimento

### 💻 IDEs e Ambientes

- **Arduino IDE:** Ambiente oficial
- **PlatformIO:** IDE avançada com VSCode
- **ESP-IDF:** Framework oficial ESP32
- **Fritzing:** Design de circuitos

### 📋 Bibliotecas Essenciais

```cpp
// WiFi e conectividade
#include <WiFi.h>
#include <PubSubClient.h>
#include <HTTPClient.h>

// Sensores
#include <DHT.h>
#include <NewPing.h>
#include <MPU6050.h>

// Atuadores
#include <Servo.h>
#include <Stepper.h>

// Comunicação
#include <SPI.h>
#include <Wire.h>
#include <SoftwareSerial.h>

// Utilitários
#include <ArduinoJson.h>
#include <EEPROM.h>
```

## 📊 Debugging e Monitoramento

### 🔍 Técnicas de Debug

```cpp
// Serial Monitor
void debugPrint(String message) {
  if (DEBUG_MODE) {
    Serial.print("[DEBUG] ");
    Serial.println(message);
  }
}

// LED Status Indicator
void setStatusLED(int status) {
  switch(status) {
    case 0: // OFF
      digitalWrite(LED_PIN, LOW);
      break;
    case 1: // ON
      digitalWrite(LED_PIN, HIGH);
      break;
    case 2: // BLINK
      blinkLED(500);
      break;
  }
}

// Watchdog Timer
#include <esp_task_wdt.h>

void setup() {
  esp_task_wdt_init(30, true); // 30s timeout
  esp_task_wdt_add(NULL);
}

void loop() {
  // Reset watchdog
  esp_task_wdt_reset();

  // Código principal
  mainCode();
}
```

## 🔗 Recursos Complementares

- [Arduino Official Documentation](https://www.arduino.cc/en/Tutorial/HomePage)
- [ESP32 Programming Guide](https://docs.espressif.com/projects/esp-idf/)
- [PlatformIO Documentation](https://docs.platformio.org/)
- [Circuit Simulator - Tinkercad](https://www.tinkercad.com/)

---

_Os projetos de hardware combinam teoria e prática, desenvolvendo soluções reais para problemas do cotidiano e preparando para áreas como IoT, automação industrial e sistemas embarcados._
