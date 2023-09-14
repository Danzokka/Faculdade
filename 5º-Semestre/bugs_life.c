/*Professor Hopper is researching the sexual behavior of a rare species of bugs. He assumes that they feature two different genders and that they only interact with bugs of the opposite gender. In his experiment, individual bugs and their interactions were easy to identify, because numbers were printed on their backs.

Given a list of bug interactions, decide whether the experiment supports his assumption of two genders with no homosexual bugs or if it contains some bug interactions that falsify it.

Input
The first line of the input contains the number of scenarios. Each scenario starts with one line giving the number of bugs (at least one, and up to 2000) and the number of interactions (up to 1000000) separated by a single space. In the following lines, each interaction is given in the form of two distinct bug numbers separated by a single space. Bugs are numbered consecutively starting from one.

Output
The output for every scenario is a line containing “Scenario #i:”, where i is the number of the scenario starting at 1, followed by one line saying either “No suspicious bugs found!” if the experiment is consistent with his assumption about the bugs’ sexual behavior, or “Suspicious bugs found!” if Professor Hopper’s assumption is definitely wrong.*/


#include <stdio.h>
#include <stdbool.h>

#define MAXIMO_BUGS 2000 //Número máximo de bugs

int grafo[MAXIMO_BUGS][MAXIMO_BUGS]; //Representa o grafo de interações entre os bugs
int cor[MAXIMO_BUGS]; //Representa a cor de cada bug (-1 = não visitado, 0 = cor 1, 1 = cor 2)

bool verifica_bipartido(int numero_de_bugs, int bug) {
    for (int i = 0; i < numero_de_bugs; i++) { 
        if (grafo[bug][i]) {
            if (cor[i] == -1) {
                cor[i] = 1 - cor[bug]; //Se o bug i não foi visitado, atribui a cor oposta ao bug atual
                if (!verifica_bipartido(numero_de_bugs, i)) {
                    return false; //Se o grafo não for bipartido, retorna false
                }
            } else if (cor[i] == cor[bug]) {
                return false; //Se o bug i já foi visitado e tem a mesma cor do bug atual, retorna false
            }
        }
    }
    return true; //Se o grafo for bipartido, retorna true
}

int main() {
    int numero_cenarios;
    scanf("%d", &numero_cenarios);

    for (int cenario = 1; cenario <= numero_cenarios; cenario++) { 
        int numero_de_bugs, interacoes;
        scanf("%d %d", &numero_de_bugs, &interacoes); 

        // Inicializa o grafo e as cores
        for (int i = 0; i < numero_de_bugs; i++) {
            cor[i] = -1; //Cor -1 significa que o bug não foi visitado
            for (int j = 0; j < numero_de_bugs; j++) {
                grafo[i][j] = 0; //Grafo 0 significa que não há interação entre os bugs
            }
        }

        // Lê as interações entre os bugs
        for (int i = 0; i < interacoes; i++) {
            int bug1, bug2;
            scanf("%d %d", &bug1, &bug2);
            grafo[bug1 - 1][bug2 - 1] = 1; 
            grafo[bug2 - 1][bug1 - 1] = 1; //Grafo 1 significa que há interação entre os bugs
        }

        bool resultado = true;

        // Verifica se o grafo é bipartido
        for (int i = 0; i < numero_de_bugs; i++) {
            if (cor[i] == -1) {
                cor[i] = 0;
                if (!verifica_bipartido(numero_de_bugs, i)) {
                    resultado = false; //Se o grafo não for bipartido, o resultado é falso
                    break;
                }
            }
        }

        // Imprime o resultado
        printf("Scenario #%d:\n", cenario);
        if (resultado) {
            printf("No suspicious bugs found!\n");
        } else {
            printf("Suspicious bugs found!\n");
        }
    }

    return 0;
}





