#include <stdio.h>
#include <ctype.h>

int main(){
  
  char str[30];
  int contador = 0;
  
  printf("Insira uma string: ");
  scanf("%s", str);



  for (int i = 0; str[i] != '\0'; i++) {
    str[i] = tolower(str[i]);
    printf("%c", str[i]);
    if (str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u'){
      contador = contador + 1;
    }
  }  

  if (contador > 0){
    printf("Na string teve %d ocorrencias de vogais", contador);
  }else{
    printf("Nao contem vogais");
  }
  return 0;
}