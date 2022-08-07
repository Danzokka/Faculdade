#include <stdio.h>

int main(){
  
  int a = 10;
  int *b = &a;
  int c = 20;
  int *d = &c;

  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);

  a = 15;
  
  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);

  *d = c;

  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);

  *b = 25;

  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);

  d = &c;

  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);

  c = 7;

  a = 5;

  b = d;

  printf("a: %d b: %d c: %d d: %d\n",a,*b,c,*d);
  
  return 0;
}