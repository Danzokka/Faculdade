

int main(){
    
    FILE *fp;
    FILE * fp2;

    fp = fopen("C:\\VSCode\\C\\Arquivo\\teste.txt","r");

    if(fp == NULL){
        printf("Não foi possivel abrir o arquivo");
        return 1;
    }

    fp2 = fopen("C:\\VSCode\\C\\Arquivo\\testes1.txt","w");

    if(fp2 == NULL){
        printf("Não foi possivel abrir o arquivo");
        return 1;
    }
    copiar(fp,fp2);

    fclose(fp); 
    fclose(fp2);

    return 0;
}

int copiar(FILE * file1, FILE * file2){
    char leitor[1000];

    

    strcpy

    while(fgets(leitor,1000,file1) != NULL)

    fputs(leitor, file2);

}
