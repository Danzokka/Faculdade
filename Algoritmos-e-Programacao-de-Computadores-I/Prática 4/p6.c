#include <stdio.h>
#include <string.h>

int main(){
    
    /*Faça um programa em C que leia um verbo e imprima a conjugação no presente do indicativo 
    caso ele termine em AR 
    (ex.: PROGRAMAR, EU PROGRAMO, TU PROGRAMAS, ELE PROGRAMA, NÓS PROGRAMAMOS, VÓS PROGRAMAIS E ELES PROGRAMAM).*/
    
    char ch = "a";
    char verbo[30];
    char *ret;
    printf("Insira um verbo: ");
    gets(verbo);
    
    ret = strrchr(verbo,ch);

    printf("Oq tem dps de %c é %s \n",ch,ret);

    return 0;
}