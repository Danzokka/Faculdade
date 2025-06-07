typedef struct calculadora Calculadora;
Calculadora* Calculadora_criar();
void Calculadora_destruir(Calculadora* calc);
void Calculadora_exibir(Calculadora* calc);
void Calculadora_zerar(Calculadora* calc);
void Calculadora_somar(Calculadora* calc, double n);
void Calculadora_subtrair(Calculadora* calc, double n);
void Calculadora_multiplicar(Calculadora* calc, double n);
void Calculadora_dividir(Calculadora* calc, double n);
