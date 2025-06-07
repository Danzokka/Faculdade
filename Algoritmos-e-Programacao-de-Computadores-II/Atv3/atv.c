#include <stdio.h>
#include<stdlib.h>

typedef struct {
    char nome[20];
    float valor;
}t_produto;

void preencher(t_produto *produto){
    
    printf("Insira o nome do produto: ");
    scanf("%[^\n]%*c", produto->nome);
    printf("Insira o valor do produto: ");
    scanf("%f%*c", &produto->valor);
}

void salvar_produtos_txt(int n, t_produto *vet_produtos){
    FILE * fp;
    fp = fopen("C:\\VSCode\\C\\Atv3\\teste.txt","w");

    if(fp == NULL){
        printf("Não foi possivel abrir o arquivo");
    }

    for(int i = 0; i < n; i++){
        fprintf(fp,"%s\t%.2f\n", vet_produtos[i].nome, vet_produtos[i].valor);
    }

    fclose(fp);

}

void ler_produtos_txt(char *caminho_do_arquivo){
    FILE * fp;

    fp = fopen(caminho_do_arquivo, "r");

    char nome[50];
    float valor;

    if(fp == NULL){
        printf("Não foi possivel abrir o arquivo");
    }

    while(fscanf(fp, "%[^\t]%f%*c", nome, &valor) != EOF){
        printf("%s %.2f\n", nome, valor);
    }

    fclose(fp);
}


int main(){

    int quantidade_produtos;

    printf("Insira a quantidade de produtos: ");
    scanf("%d%*c", &quantidade_produtos);

    t_produto *vet_produtos = malloc(sizeof(t_produto)*quantidade_produtos);

    if(vet_produtos == NULL){
        printf("Malloc não funcionou");
        return 1;
    }

    for(int i = 0; i< quantidade_produtos; i++){
        preencher((vet_produtos + i));
    }

    salvar_produtos_txt(quantidade_produtos, vet_produtos);

    ler_produtos_txt("C:\\VSCode\\C\\Atv3\\teste.txt");

    free(vet_produtos);

    return 0;
}