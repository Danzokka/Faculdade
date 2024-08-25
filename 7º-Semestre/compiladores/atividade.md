# Exercício 03.75
### Rafael Dantas Boeira - 2122082004

### Apresente a Análise Preditiva Tabular da entrada ((x + y) ^ (z * y)) / (x - y) sobre a gramática a seguir.

```
G = ({A, B, C, D, E}, {+, -, *, /, ^, (, ), x, y, z}, P, A)
P = {A → A+B | A-B | B
     B → B*C | B/C | C
     C → C^D | D
     D → (A) | E
     E → x | y | z}
```

#### Eliminação de recursividade à Esquerda

```
Para A: A-> BA'
        A'-> +BA' | -BA' | ε

Para B: B->CB'
        B'-> *CB' | /CB | ε

Para C: C -> DC'
        C' -> ^DC' | ε

Para D e E: D -> (A) | E
            E -> x | y | z
```

#### Conjunto First(a) e First(A)

```
First(A) = First(B) = First(C) = First(D) = {(, x, y, z}
First (A') = {+, -, ε}
First (B') = {*, /, ε}
First (C') = {^, ε}
First (E) = {x, y, z}
```

#### Conjunto Follow

```
Follow (A) = Follow(A') = {), $}
Follow (B) = Follow(B') = {+, -, ), $}
Follow (C) = Follow(C') = {*, /, +, -, ), $}
Follow (D) = Follow(D') = {^, *, /, +, -, ), $}
Follow (E) = {^, *, /, +, -, ), $}
```

#### Tabela de Análise Preditiva

|       | x         | y         | z         | +         | -         | *         | /         | ^         | (         | )         | $         |
|-------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| A     | A → BA'   | A → BA'   | A → BA'   |           |           |           |           |           | A → BA'   |           |           |
| A'    |           |           |           | A' → +BA' | A' → -BA' |           |           |           |           | A' → ε    | A' → ε    |
| B     | B → CB'   | B → CB'   | B → CB'   |           |           |           |           |           | B → CB'   |           |           |
| B'    |           |           |           | B' → ε    | B' → ε    | B' → *CB' | B' → /CB' |           |           | B' → ε    | B' → ε    |
| C     | C → DC'   | C → DC'   | C → DC'   |           |           |           |           |           | C → DC'   |           |           |
| C'    |           |           |           | C' → ε    | C' → ε    |           |           | C' → ^DC' |           | C' → ε    | C' → ε    |
| D     | D → E     | D → E     | D → E     |           |           |           |           |           | D → (A)   |           |           |
| E     | E → x     | E → y     | E → z     |           |           |           |           |           |           |           |           |


#### Tabela de Movimentos do Analisador Preditivo Tabular

| Passo | Pilha                      | Entrada                              | Ação                  |
|-------|----------------------------|--------------------------------------|-----------------------|
| 1     | A$                         | ((x + y) ^ (z * y)) / (x - y)$       | Usa A → BA'           |
| 2     | A' B$                      | ((x + y) ^ (z * y)) / (x - y)$       | Usa B → CB'           |
| 3     | A' B' C$                   | ((x + y) ^ (z * y)) / (x - y)$       | Usa C → DC'           |
| 4     | A' B' C' D$                | ((x + y) ^ (z * y)) / (x - y)$       | Usa D → (A)           |
| 5     | A' B' C' ) A ($            | ((x + y) ^ (z * y)) / (x - y)$       | Consome '(' da entrada|
| 6     | A' B' C' ) A ($            | x + y) ^ (z * y)) / (x - y)$         | Consome '(' da entrada|
| 7     | A' B' C' ) A $             | x + y) ^ (z * y)) / (x - y)$         | Usa A → BA'           |
| 8     | A' B' C' ) A' B $          | x + y) ^ (z * y)) / (x - y)$         | Usa B → CB'           |
| 9     | A' B' C' ) A' B' C $       | x + y) ^ (z * y)) / (x - y)$         | Usa C → DC'           |
| 10    | A' B' C' ) A' B' C' D $    | x + y) ^ (z * y)) / (x - y)$         | Usa D → E             |
| 11    | A' B' C' ) A' B' C' E $    | x + y) ^ (z * y)) / (x - y)$         | Usa E → x             |
| 12    | A' B' C' ) A' B' C' $      | + y) ^ (z * y)) / (x - y)$           | Consome 'x' da entrada|
| 13    | A' B' C' ) A' B' $         | + y) ^ (z * y)) / (x - y)$           | Usa B' → ε            |
| 14    | A' B' C' ) A' $            | + y) ^ (z * y)) / (x - y)$           | Usa A' → +BA'         |
| 15    | A' B' C' ) A' B + $        | + y) ^ (z * y)) / (x - y)$           | Consome '+' da entrada|
| 16    | A' B' C' ) A' B' C $       | y) ^ (z * y)) / (x - y)$             | Usa B → CB'           |
| 17    | A' B' C' ) A' B' C' D $    | y) ^ (z * y)) / (x - y)$             | Usa D → E             |
| 18    | A' B' C' ) A' B' C' E $    | y) ^ (z * y)) / (x - y)$             | Usa E → y             |
| 19    | A' B' C' ) A' B' C' $      | ) ^ (z * y)) / (x - y)$              | Consome 'y' da entrada|
| 20    | A' B' C' ) A' B' $         | ) ^ (z * y)) / (x - y)$              | Usa B' → ε            |
| 21    | A' B' C' ) A' $            | ) ^ (z * y)) / (x - y)$              | Usa A' → ε            |
| 22    | A' B' C' ) $               | ) ^ (z * y)) / (x - y)$              | Consome ')' da entrada|
| 23    | A' B' C' $                 | ^ (z * y)) / (x - y)$                | Usa C' → ^DC'         |
| 24    | A' B' C' D ^ $             | (z * y)) / (x - y)$                  | Consome '^' da entrada|
| 25    | A' B' C' D $               | (z * y)) / (x - y)$                  | Usa D → (A)           |
| 26    | A' B' C' ) A ( $           | (z * y)) / (x - y)$                  | Consome '(' da entrada|
| 27    | A' B' C' ) A $             | z * y)) / (x - y)$                   | Usa A → BA'           |
| 28    | A' B' C' ) A' B $          | z * y)) / (x - y)$                   | Usa B → CB'           |
| 29    | A' B' C' ) A' B' C $       | z * y)) / (x - y)$                   | Usa C → DC'           |
| 30    | A' B' C' ) A' B' C' D $    | z * y)) / (x - y)$                   | Usa D → E             |
| 31    | A' B' C' ) A' B' C' E $    | z * y)) / (x - y)$                   | Usa E → z             |
| 32    | A' B' C' ) A' B' C' $      | * y)) / (x - y)$                     | Consome 'z' da entrada|
| 33    | A' B' C' ) A' B' $         | * y)) / (x - y)$                     | Usa B' → *CB'         |
| 34    | A' B' C' ) A' B' C * $     | y)) / (x - y)$                       | Consome '*' da entrada|
| 35    | A' B' C' ) A' B' C' D $    | y)) / (x - y)$                       | Usa D → E             |
| 36    | A' B' C' ) A' B' C' E $    | y)) / (x - y)$                       | Usa E → y             |
| 37    | A' B' C' ) A' B' C' $      | )) / (x - y)$                        | Consome 'y' da entrada|
| 38    | A' B' C' ) A' B' $         | )) / (x - y)$                        | Usa B' → ε            |
| 39    | A' B' C' ) A' $            | )) / (x - y)$                        | Usa A' → ε            |
| 40    | A' B' C' ) $               | )) / (x - y)$                        | Consome ')' da entrada|
| 41    | A' B' C' $                 | ) / (x - y)$                         | Consome ')' da entrada|
| 42    | A' B' C' $                 | / (x - y)$                           | Consome '/' da entrada|
| 43    | A' B' $                    | (x - y)$                             | Usa B' → /CB'         |
| 44    | A' B' C $                  | (x - y)$                             | Usa C → DC'           |
| 45    | A' B' C' D $               | (x - y)$                             | Usa D → (A)           |
| 46    | A' B' C' ) A ( $           | (x - y)$                             | Consome '(' da entrada|
| 47    | A' B' C' ) A $             | x - y)$                              | Usa A → BA'           |
| 48    | A' B' C' ) A' B $          | x - y)$                              | Usa B → CB'           |
| 49    | A' B' C' ) A' B' C $       | x - y)$                              | Usa C → DC'           |
| 50    | A' B' C' ) A' B' C' D $    | x - y)$                              | Usa D → E             |
| 51    | A' B' C' ) A' B' C' E $    | x - y)$                              | Usa E → x             |
| 52    | A' B' C' ) A' B' C' $      | - y)$                                | Consome 'x' da entrada|
| 53    | A' B' C' ) A' B' $         | - y)$                                | Usa B' → ε            |
| 54    | A' B' C' ) A' $            | - y)$                                | Usa A' → -BA'         |
| 55    | A' B' C' ) A' B - $        | - y)$                                | Consome '-' da entrada|
| 56    | A' B' C' ) A' B' C $       | y)$                                  | Usa B → CB'           |
| 57    | A' B' C' ) A' B' C' D $    | y)$                                  | Usa D → E             |
| 58    | A' B' C' ) A' B' C' E $    | y)$                                  | Usa E → y             |
| 59    | A' B' C' ) A' B' C' $      | )$                                   | Consome 'y' da entrada|
| 60    | A' B' C' ) A' B' $         | )$                                   | Usa B' → ε            |
| 61    | A' B' C' ) A' $            | )$                                   | Usa A' → ε            |
| 62    | A' B' C' ) $               | )$                                   | Consome ')' da entrada|
| 63    | A' B' C' $                 | $                                    | Entrada aceita        |
