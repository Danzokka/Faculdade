#include <stdio.h>

int main(){
  char str[] = "OlaOleOli";
  char *ptr = str;

  for(int i; str[i]; i++)
    printf("Str: %c || *ptr: %d\n", str[i], &ptr[i]);

  printf("\nSelecionado: %d ||Ponteiro: %c \n\n", &str, *(ptr+2));

  printf("A: %c\nE: %c\nI: %c", ptr[2], *(ptr+5), *(ptr + 8));

  printf("\n%d", ptr);
  printf("\n%d", &ptr);
  return 0;
}