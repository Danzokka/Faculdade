#include <stdio.h>

int main(){
    
    int input,num,mil,cent,dez,uni;

    printf("Digite um número inteiro: ");
    scanf("%d",&input);

    num = input;
    uni = num % 10;
    num = (num - uni)/10;
    dez = num % 10;
    num = (num - dez)/10;
    cent = num % 10;
    num = (num - cent)/10;
    mil = num % 10;

    printf("%d é decomposto em %d unidades, %d dezenas, %d centenas e %d milhares",input,uni,dez,cent,mil);
    
    return 0;
}