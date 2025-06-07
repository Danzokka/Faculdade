#include <WiFi.h>
#include <WiFiClient.h>
#include <WebServer.h>
#include <ArduinoJson.h>

#define WIFI_SSID "SEU_SSID"
#define WIFI_PASSWORD "SUA_SENHA"
#define API_KEY "8e378afea9e56ac186e9f84cdc8e2eee"
#define CITY_ID "3410315" // Pode ser o nome da cidade ou o ID

const char* host = "api.openweathermap.org";
//https://api.openweathermap.org/data/2.5/forecast?id=3410315&appid=8e378afea9e56ac186e9f84cdc8e2eee&units=metric
#define PORTA 80

int LED = 21;
WebServer server(80);

String descricaoTempo;
float temperatura;
int umidade;

void buscaDadosTempo() {
  WiFiClient client;
  if (!client.connect(host, PORTA)) {
    return;
  }

  String url = "/data/2.5/weather?lat=-3.89472&lon=-42.694172&appid=" + String(API_KEY) + "&units=metric";

  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + url + "\r\n" +
               "Connection: close\r\n\r\n");

  while (client.connected() && !client.available()) {
    delay(1);
  }

  String line = client.readStringUntil('\n');
  if (line == "HTTP/1.1 200 OK") {
    while (client.connected() && !client.available()) {
      delay(1);
    }
    
    String payload = client.readStringUntil('\n');
    DynamicJsonDocument doc(1024);
    deserializeJson(doc, payload);

    descricaoTempo = doc["weather"][0]["description"].as<String>();
    temperatura = doc["main"]["temp"].as<float>();
    umidade = doc["main"]["humidity"].as<int>();

  }
}

void sendHtml() {
  String response = R"(
    <!DOCTYPE html>
<html>
  <head>
    <title>Franzininho Server</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      html {
        font-family: sans-serif;
        text-align: center;
      }
      body {
        display: inline-flex;
        flex-direction: column;
      }
      h1 {
        margin-bottom: 1.2em;
      }
      h2 {
        margin: 0;
      }
      div {
        display: flex;
        flex-direction: column;
        margin-bottom: 1.2em;
        gap: 0.5em;
      }
      .btn {
        background-color: #5b5;
        border: none;
        color: #fff;
        padding: 0.5em 1em;
        font-size: 2em;
        text-decoration: none;
      }
      .btn.OFF {
        background-color: #333;
      }
    </style>
  </head>

  <body>
    <h1>Franzininho Web Server</h1>

    <div>
      <h2>Liga/Desliga</h2>
      <a href="/liga" class="btn LED">LED</a>
      <h2>Clima Atual</h2>
      <p>Descrição: DESCRICAO</p>
      <p>Temperatura: TEMPERATURA °C</p>
      <p>Humidade: UMIDADE %</p>
    </div>
  </body>
</html>
  )";

  response.replace("DESCRICAO", descricaoTempo);
  response.replace("TEMPERATURA", String(temperatura));
  response.replace("UMIDADE", String(umidade));
  server.send(200, "text/html", response);
}

void setup(void) {
  Serial.begin(115200);
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
    Serial.print(".");
  }

  Serial.print("IP: ");
  Serial.println(WiFi.localIP());

  buscaDadosTempo(); // Fetch initial weather data

  server.on("/", sendHtml);

  server.on("/liga", []() {
    ledState = !ledState;
    digitalWrite(LED, ledState);
    sendHtml();
  });

  server.begin();
}

void loop() {
  server.handleClient();
  delay(2);

  // Periodically fetch weather data
  static unsigned long lastFetch = 0;
  if (millis() - lastFetch > 60000) { // Fetch data every 60 seconds
    lastFetch = millis();
    buscaDadosTempo();
  }
}
