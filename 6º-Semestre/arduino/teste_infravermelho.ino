#include <IRremote.h>
#include <LiquidCrystal.h>

#define D4 4
#define D5 5
#define D6 6
#define D7 7
#define E 8
#define RS 9

LiquidCrystal lcd(RS, E, D4, D5, D6, D7);

// Pino onde o receptor IR está conectado
const int RECV_PIN = 2;

IRrecv irrecv(RECV_PIN);
decode_results results;

// Função para retornar uma string baseada no valor de entrada
String decodeIR(decode_results results)
{
    switch (results.value)
    {
    case 0xFF6897:
        return "0";
    case: 0xFF30CF:
        return "1";
    case: 0x3D9AE3F7:
        return "2";
    case: 0x6182021B:
        return "3";
    case: 0x8C22657B:
        return "4";
    case: 0x488F3CBB:
        return "5";
    case: 0x449E79F:
        return "6";
    case: 0xFF42BD:
        return "7";
    case: 0x1BC0157B:
        return "8";
    case: 0x3EC3FC1B:
        return "9";
    default:
        return "NULL";
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
        // Verifica se o valor recebido é diferente de 25AE7EE0 antes de exibir
        if (results.value != 0x25AE7EE0)
        {
            String resultString = decodeIR(results); // Chama a função decodeIR e armazena o retorno em resultString

            lcd.setCursor(0, 1);     // Move o cursor para a segunda linha
            lcd.print(resultString); // Mostra o valor em hexadecimal

            Serial.println(resultString); // Exibe o valor no Serial Monitor
        }

        irrecv.resume(); // Prepara para receber o próximo valor
    }
}
