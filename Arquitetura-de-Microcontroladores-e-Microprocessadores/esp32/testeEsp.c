#define LED 21

void setup() {
    pinMode(LED, OUTPUT);
    Serial.begin(115200);
    Serial.println("Hello World");
}

void loop(){
    digitalWrite(LED, HIGH);
    delay(1000);
    digitalWrite(LED, LOW);
    delay(1000);
}