#include <stdio.h>


int main(){
    
    int d, e = 0;

    printf("Insira um numero: ");
    scanf("%d", &d);
    // d = -5

    printf("e: %d", e);

    e = modulo(d);

    /*printf("Insira um numero: ");
    scanf("%d", &e);   
    // e = 10
    modulo(e); // 10*/

    return 0;
}
int modulo(int x, int y){
    // x = -5
    if (x < 0){
        x = -x;
    }
    
    multiplos(x);
    
    return x;

}

int multiplos(int y){

    for(int i = 0; i<= 10; i++){
        printf("%d X %d = %d \n", y, i, (i*y));
    }
}
