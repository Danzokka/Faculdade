#include <IRremote.h>
#include <LiquidCrystal.h>

#define D4 4
#define D5 5
#define D6 6
#define D7 7
#define E 8
#define RS 9

LiquidCrystal lcd(RS, E, D4, D5, D6, D7);

const int RECV_PIN = 2;

IRrecv irrecv(RECV_PIN);
decode_results results;

String decodeIR(decode_results results)
{
    switch (results.value)
    {
    case 0xC101E57B:
        return "0";
    case 0x9716BE3F:
        return "1";
    case 0x3D9AE3F7:
        return "2";
    case 0x6182021B:
        return "3";
    case 0x8C22657B:
        return "4";
    case 0xFF38C7:
        return "5";
    case 0x449E79F:
        return "6";
    case 0xFF42BD:
        return "7";
    case 0xFF4AB5:
        return "8";
    case 0xFF52AD:
        return "9";
    default:
        return "Null";
    }
}

void setup()
{
    Serial.begin(115200);
    irrecv.enableIRIn();
    lcd.begin(16, 2);
    lcd.print("Botao:");
}

void loop()
{
    if (irrecv.decode(&results))
    {
        if (results.value != 0x25AE7EE0)
        {
            String resultString = decodeIR(results);
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print("Botao:");
            lcd.setCursor(0, 1);
            lcd.print(resultString);
            Serial.println(resultString);
        }

        irrecv.resume();
    }
}
