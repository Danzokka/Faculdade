#include <stdio.h>

int main(){
    
    char str[] = "Teste avaliativo";
    char input;
    char *pc;
    int ocorrencia = -1;

    printf("Insira um caractere para procurar na string: ");
    scanf("%c", input);
    
    for(int i = 0; i <= 17; i++){
        if(str[i] == input){
            pc = &str[i];
            ocorrencia = i;
        }else{
            continue;
        }
    }

    if (ocorrencia != -1){
        printf("A última ocorrência do caractere inserido foi no elemento: %d\nE o seu endereço de memória é: %d",ocorrencia,pc);
    }else{
        printf("-1");
    }

    return 0;
}
