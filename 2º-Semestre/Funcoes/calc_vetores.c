#include <stdio.h>
//idealizado por Danzokka

int x[2], y[2], z[2];

int main(){
    
    int escolha = 0;

    printf("1. Produto Escalar \n2. Produto Vetorial \n3. Produto Misto \nEscolha (índice do tipo do produto): ");
    scanf("%d", &escolha);
    printf("\n");
    if(escolha == 1){
        escalar();
    } else if(escolha == 2){
        vetorial();
    } else if(escolha == 3){
        misto();
    }else{
        printf("Error");
    }
    
    printf("\nObrigado por me usar :)");
    
    return 0;
}
int escalar(void){
    
    printf("Insira o primeiro vetor: ");
    scanf("%d %d %d", &x[0], &y[0], &z[0]);
    printf("Insira o segundo vetor: ");
    scanf("%d %d %d", &x[1], &y[1], &z[1]);

    int resultado = (x[0]*x[1])+(y[0]*y[1])+(z[0]*z[1]);

    printf("Resultado: %d", resultado);
}
int vetorial(void){
    
    printf("Insira o primeiro vetor: ");
    scanf("%d %d %d", &x[0], &y[0], &z[0]);
    printf("Insira o segundo vetor: ");
    scanf("%d %d %d", &x[1], &y[1], &z[1]);

    int resultant_vector[2];
    resultant_vector[0] = (y[0]*z[1]) - (z[0] * y[1]);
    resultant_vector[1] = - ((x[0]*z[1]) - (x[1] * z[0]));
    resultant_vector[2] = (x[0]*y[1]) - (y[0] * x[1]);

    //Show the results

    printf("Vetor Resultante: %di %dj %dk", resultant_vector[0], resultant_vector[1], resultant_vector[2]);
}
int misto(void){
    printf("Insira o primeiro vetor: ");
    scanf("%d %d %d", &x[0], &y[0], &z[0]);
    printf("Insira o segundo vetor: ");
    scanf("%d %d %d", &x[1], &y[1], &z[1]);
    printf("Insira o terceiro vetor: ");
    scanf("%d %d %d", &x[2], &y[2], &z[2]);

    int resultant_vector[2];
    resultant_vector[0] = x[2] * ((y[0]*z[1]) - (z[0] * y[1]));
    resultant_vector[1] = -y[2] * ((x[0]*z[1]) - (x[1] * z[0]));
    resultant_vector[2] = z[2] * ((x[0]*y[1]) - (y[0] * x[1]));

    int resultado = resultant_vector[0] + resultant_vector[1] + resultant_vector[2];

    printf("Resultado: %d", resultado);   
}
