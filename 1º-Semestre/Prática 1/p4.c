#include <stdio.h>
int main(){
    
    float icms = 0.17, confins = 0.076, paesp = 0.0165, pf;
    int pi;

    printf("Preço do produto: ");
    scanf("%d",&pi);

    pf = (1 + icms + confins + paesp) * pi ;
    
    printf("Com os impostos o seu produto custará: %0.2f reais",pf);
    
    
    return 0;
}