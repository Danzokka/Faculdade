#include <stdio.h>
#include "calculadora.h"

int main()
{

    Calculadora *teste;
    teste = Calculadora_criar();

    Calculadora_exibir(teste);

    Calculadora_somar(teste, 2);

    Calculadora_exibir(teste);

    return 0;
}