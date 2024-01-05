#include <stdio.h>
#include <stdlib.h>
#include "calculadora.h"
// Inclui os protótipos

struct calculadora
{
  double resultado;
};

Calculadora *Calculadora_criar() // Analogo à um Construtor Java
{
  Calculadora *calc = (Calculadora *)malloc(sizeof(Calculadora));
  if (calc != NULL)
  {
    calc->resultado = 0;
  }
  return calc;
}

void Calculadora_destruir(Calculadora *calc)
{
  free(calc);
}

void Calculadora_exibir(Calculadora *calc)
{
  printf("%.f \n", calc->resultado);
}

void Calculadora_zerar(Calculadora *calc)
{
  calc->resultado = 0;
}

void Calculadora_somar(Calculadora *calc, double n)
{
  calc->resultado += n;
}

void Calculadora_subtrair(Calculadora *calc, double n)
{
  calc->resultado -= n;
}

void Calculadora_multiplicar(Calculadora* calc, double n)
{
  calc->resultado *= n;
}

void Calculadora_dividir(Calculadora *calc, double n)
{
  calc->resultado /= n;
}