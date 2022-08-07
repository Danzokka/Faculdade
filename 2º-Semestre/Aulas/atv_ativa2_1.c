#include <stdio.h>

char * strcopy (char * dest, char * origem);

int main(){
    
    char str[100], copia[100];

    printf("Insira uma string: ");
    scanf("%[\n]", str);

    strcopy(copia,str);
    
    printf("%s", copia);

    return 0;
}

char * strcopy (char * dest, char * origem){
    int i = 0;
    while (origem[i] != '\0')
    {
        dest[i] = origem[i];
        i++;
    }
    return dest;
}