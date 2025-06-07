#include <stdio.h>
int main(){
   int raio;
   float pi,p;

   pi = 3.1416;

   printf("O raio da sua pizza: ");
   scanf("%d",&raio);

    p = 2*pi*raio;

    printf("O perímetro da sua pizza é: %f",p);

}