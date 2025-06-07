/********************************************************************
* Leitura do sensor de temperatura DS18B20 (v1.0).
*
* Realiza a leitura da temperatura utilizando sensor DS18B20.
* Apos a leitura, no monitor serial ira imprimir os dados lidos.
*
* Copyright 2019 RoboCore.
* Escrito por Renan Piva (10/04/2019).
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version (<https://www.gnu.org/licenses/>).
*****************************************************************************/

// Inclusao das bibliotecas
#include <OneWire.h>
#include <DallasTemperature.h>

const int PINO_ONEWIRE = 12;
OneWire oneWire(PINO_ONEWIRE); // Cria um objeto OneWire
DallasTemperature sensor(&oneWire); // Informa a referencia da biblioteca dallas temperature para Biblioteca onewire
DeviceAddress endereco_temp; // Cria um endereco temporario da leitura do sensor

void setup() {
  Serial.begin(9600);
  Serial.println("Medindo Temperatura");
  sensor.begin();
}
  
void loop() {
  sensor.requestTemperatures(); // Envia comando para realizar a conversão de temperatura
  if (!sensor.getAddress(endereco_temp,0)) {
    Serial.println("SENSOR NAO CONECTADO"); // Sensor nao conectado, imprime mensagem de erro
  } else {
    Serial.print("Temperatura = ");
    Serial.println(sensor.getTempC(endereco_temp), 1); // Imprime a temperatura lida em graus Celsius
  }
  delay(1000);
}