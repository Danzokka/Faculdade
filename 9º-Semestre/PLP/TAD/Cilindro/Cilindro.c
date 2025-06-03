#include <stdlib.h>
#include <math.h>
#include "Cilindro.h"

/* Definição da estrutura do cilindro */
struct cilindro {
    float raio;
    float altura;
};

Cilindro* criar(float raio, float altura) {
    Cilindro* c = (Cilindro*) malloc(sizeof(Cilindro));
    
    if (c != NULL) {
        c->raio = raio;
        c->altura = altura;
    }
    
    return c;
}

void destruir(Cilindro* c) {
    free(c);
}

float getRaio(Cilindro* c) {
    return c->raio;
}

float getAltura(Cilindro* c) {
    return c->altura;
}

float areaBase(Cilindro* c) {
    return M_PI * c->raio * c->raio;
}

float areaLateral(Cilindro* c) {
    return 2 * M_PI * c->raio * c->altura;
}

float areaTotal(Cilindro* c) {
    return 2 * areaBase(c) + areaLateral(c);
}

float volume(Cilindro* c) {
    return areaBase(c) * c->altura;
}