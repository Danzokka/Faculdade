#include <stdio.h>
#include <string.h>

int is_palindrome(char s[])
{
    int tamanho = strlen(s);

    for (int i = 0; i <= tamanho; i++)
    {
        if (s[i] != s[tamanho - i - 1]) // o ultimo elemento de uma string é o "\0", ent se apenas subtrairmos o tamanho da string - o tamanho do loop sempre dará errado, pois verificaria se qualquer letra seria igual a "\0";
        {
            return 0;
        }
    }
    return 1;
}

int main()
{

    printf("%d", is_palindrome("anan"));

    return 0;
}
