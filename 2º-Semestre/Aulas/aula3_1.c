#include <stdio.h>

int main(){
    
  //Escreva um algoritmo que percorra um array de inteiros e identifique o maior e menor valor desse array

  int num[9];

  printf("Insira um número: ");
  scanf("%d", &*(num));

  int maior = *(num);
  int menor = *(num);

  for(int i = 1; i < 10; ++i){
    printf("Insira um número: ");
    scanf("%d", &*(num + i));

    if(*(num + i) > maior){
      maior = *(num + i);
    }else if(*(num + i) < menor){
      menor = *(num + i);
    }
  }
    
  printf("O menor numero foi: %d\nO maior numero foi: %d", menor, maior);
    
  return 0;
}