#include <stdio.h>

void formata_hora(float horas)
{

    int segundos = horas * 3600;
    int h = segundos / 3600;
    int resto = segundos % 3600;
    int min = resto / 60;
    int seg = resto % 60;

    char hora[10];

    sprintf(hora, "%d:%d:%d", h, min, seg);
}

int main()
{

    formata_hora(4.525);

    return 0;
}
