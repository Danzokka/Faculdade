/*
 *
 * All the resources for this project:
 * Modified by Handson Technology
 * www.handsontec.com
 * Created by Handsontec Tech team
 *
 */
#include <SPI.h>
#include <MFRC522.h>
#define SS_PIN 10
#define RST_PIN 9

#define LED_PASS 2
#define LED_DENIED 3
#define BUZZER 7 // Defina o pino do buzzer aqui

#define NOTE_C 262
#define NOTE_D 294
#define NOTE_E 330
#define NOTE_F 349
#define NOTE_G 392
#define NOTE_A 440
#define NOTE_B 494
#define NOTE_C_SHARP 528

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance.

void tom(char pino, int frequencia, int duracao){
  float periodo = 1000.0/frequencia; //Periodo em ms
  for (int i = 0; i< duracao/(periodo);i++){ //Executa a rotina de dentro o tanta de vezes que a frequencia desejada cabe dentro da duracao
    digitalWrite(pino,HIGH);
    delayMicroseconds(periodo*500); //Metade do periodo em ms
    digitalWrite(pino, LOW);
    delayMicroseconds(periodo*500);
  }
}

void pass()
{
    digitalWrite(LED_PASS, HIGH);

    // Melodia do Mario ganhando uma vida
    int melody[] = {NOTE_E, NOTE_E, NOTE_E, NOTE_C, NOTE_E, NOTE_G, NOTE_G};
    int durations[] = {100, 100, 100, 100, 100, 100, 100};
    playMelody(melody, durations, sizeof(melody) / sizeof(int));

    digitalWrite(LED_PASS, LOW);
}


void denied()
{
    digitalWrite(LED_DENIED, HIGH);

    // Melodia do Mario perdendo uma vida no Super Mario World
    int melody[] = {NOTE_C, NOTE_G, NOTE_F, NOTE_E, NOTE_C};
    int durations[] = {100, 100, 100, 100, 100};
    playMelody(melody, durations, sizeof(melody) / sizeof(int));

    digitalWrite(LED_DENIED, LOW);
}

void playMelody(int *notes, int *durations, int length)
{
    for (int i = 0; i < length; i++)
    {
        tom(BUZZER, notes[i], durations[i]);
        delay(100); // Pausa entre notas
    }
}

void setup()
{
    Serial.begin(9600); // Initiate a serial communication
    SPI.begin();        // Initiate SPI bus
    mfrc522.PCD_Init(); // Initiate MFRC522
    pinMode(LED_PASS, OUTPUT);
    pinMode(LED_DENIED, OUTPUT);
    pinMode(BUZZER, OUTPUT); // Defina o pino do buzzer como saída
}
void loop()
{
    int tempo = 400;
    // Look for new cards
    if (!mfrc522.PICC_IsNewCardPresent())
    {
        return;
    }
    // Select one of the cards
    if (!mfrc522.PICC_ReadCardSerial())
    {
        return;
    }
    // Show UID on serial monitor
    String content = "";
    byte letter;
    for (byte i = 0; i < mfrc522.uid.size; i++)
    {
        content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
        content.concat(String(mfrc522.uid.uidByte[i], HEX));
    }
    content.toUpperCase();
    Serial.println(content); // Print the content to the serial monitor
    if (content.substring(1) == "B1 47 8A 1D") // change here the UID of the card/cards that you want to give access
    {
        pass();
    }
    else
    {
        denied();
    }
}
