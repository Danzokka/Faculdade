int main (int argc , char *argv[])
{
    
    int numero; //variável

    printf("Digite um numero"); //print
    scanf("%d",&numero); //lê o numero inserido
    getchar(); //limpa o buffer do teclado do PC

    printf("O numero é igual a: %d\n\n",numero);

    system ("PAUSE");
    return 0;
}