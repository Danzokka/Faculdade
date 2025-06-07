#ifndef CILINDRO_H
#define CILINDRO_H

typedef struct cilindro Cilindro;

Cilindro* criar(float raio, float altura);
void destruir(Cilindro* c);

float getRaio(Cilindro* c);
float getAltura(Cilindro* c);
float areaBase(Cilindro* c);
float areaLateral(Cilindro* c);
float areaTotal(Cilindro* c);
float volume(Cilindro* c);

#endif