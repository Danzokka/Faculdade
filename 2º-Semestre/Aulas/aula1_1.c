#include <stdio.h>

int main(){
  
  char str[30];
  int contador = 0;
  
  printf("Insira uma string: ");
  scanf("%[^\n]%*c", str);
  
  printf("%s", str);
  for (int i = 0; str[i] != '\0'; i++) {
    if (str[i] < ':' && str[i] > '/') {
      contador = contador + 1;
    }
  }  

  if (contador > 0){
    printf("Na string teve %d ocorrencias de numeros", contador);
  }else{
    printf("Nao contem numeros");
  }
  return 0;
}
