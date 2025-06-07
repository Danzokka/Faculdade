#include <stdio.h>
int main(){
  
  int a1,a2,mf;

  printf("A1: ");
  scanf("%d",&a1);
  printf("A2: ");
  scanf("%d",&a2);

  mf = (0.4 * a1) + (0.6 * a2);

  printf("A sua média final é: %d",mf);

  
  return 0;
}