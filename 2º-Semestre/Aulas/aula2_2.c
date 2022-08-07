#include <stdio.h>

int main(){

  int x = 5;
  int *ptr = &x;

  printf("x: %d \n*ptr: %d\n", x, *ptr);  

  *ptr = 69;

  printf("x: %d \n*ptr: %d", x, *ptr);
  
  return 0;
}