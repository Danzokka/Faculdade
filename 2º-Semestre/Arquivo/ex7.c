#include <stdio.h>

int main(){
    
    FILE * fp;

    fp = fopen("ex7.txt","w");

    fclose(fp);
    
    return 0;
}