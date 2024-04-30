#define POTENCIOMETRO 0

#define D1 2
#define C1 3
#define B1 4
#define A1 5

#define D2 6
#define C2 7
#define B2 10
#define A2 11

#define D3 12
#define C3 13
#define B3 14
#define A3 15

#define D4 16
#define C4 17
#define B4 18
#define A4 19

int initialize[] = {
    D1, C1, B1, A1, D2, C2, B2, A2, D3, C3, B3, A3, D4, C4, B4, A4};

int segment1[] = {
    D1, C1, B1, A1};

int segment2[] = {
    D2, C2, B2, A2};

int segment3[] = {
    D3, C3, B3, A3};

int segment4[] = {
    D4, C4, B4, A4};

void setup()
{
    for (int i = 0; i <= 15; i++)
    {
        pinMode(initialize[i], OUTPUT);
    }
}

void loop()
{

    int valor = analogRead(POTENCIOMETRO);
    int binario[4];

    for (int i = 0; i < 4; i++)
    {
        binario[i] = valor % 10;
        valor = valor / 10;
        Serial.println(binario[i]);
    }


    Serial.println(valor);
}