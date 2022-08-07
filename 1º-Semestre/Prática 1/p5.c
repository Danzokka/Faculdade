#include <stdio.h>
int main(){
    
    float bytes, gb, B = 1024;

    printf("CONVERSORA PARA BYTES\n");
    printf("GBs: ");
    scanf("%f",&gb);
        
    bytes = gb * (B*B*B);

    printf("%0.02f Giga Bytes equivalem a ",gb);
    
    printf("%0.02f Bytes",bytes);
    
    return 0;
}