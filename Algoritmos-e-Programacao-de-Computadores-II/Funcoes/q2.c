#include <stdio.h>

long int n_segundos(int n_horas);

int main(){
    
    long int valor_segundos, h;

    printf("Insira as horas yey: ");
    scanf("%d", &h);
    
    valor_segundos = n_segundos(h);

    printf("Em %d horas tem %d segundos", h, valor_segundos);
    
    return 0;
}

long int n_segundos(int n_horas){
    long int seg = 3600 * n_horas;
    return seg;
}