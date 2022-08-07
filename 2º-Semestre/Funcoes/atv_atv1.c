#include <stdio.h>

float determinante(int lin, int col, matriz[lin][col]){

    int det;

    det = (matriz[0][0] * ((matriz[1][1]*matriz[2][2]) - (matriz[1][2] * matriz[2][1]))) - (matriz[0][1] * ((matriz[1][0]*matriz[2][2]) - (matriz[2][0] * matriz[1][2]))) + (matriz[0][2] * ((matriz[1][0]*matriz[2][1]) - (matriz[2][0] * matriz[1][1])));   

    return det;
}

int main(){
    
    int lin = 3;
    int col = 3;
    
    int mat[3][3];

    mat[0][0] = 1;
    mat[0][1] = 2;
    mat[0][2] = 3;
    mat[1][0] = 4;
    mat[1][1] = 5;
    mat[1][2] = 6;
    mat[2][0] = 7;
    mat[2][1] = 8;
    mat[2][2] = 9;

    for(int i=0; i<3; i++){
        for(int j=0; j<3; j++){
            printf("%d", mat[i][j]);
        }
        printf("\n");
    }
    
    determinante();

    return 0;
}