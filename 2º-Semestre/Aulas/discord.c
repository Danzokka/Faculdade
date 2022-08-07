#include <stdio.h>

int main(){
    
    int matriz[] = {35, 120, 97, 109, 101};
    int *ponteiro = &matriz;

    /*printf("%c \n", string[4]);
    printf("%d \n", &string);
    printf("%d \n", ponteiro);
    printf("%c \n", string[4]);
    printf("%c \n", *(ponteiro + 4));
    printf("%d \n", &string[4]);
    printf("%d", (ponteiro + 4));*/
    
    printf("Imprimir: %c", matriz[0]);

    return 0;
}