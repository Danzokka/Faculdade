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
| 6     | A' B' C' ) A $             | (x + y) ^ (z * y)) / (x - y)$        | Usa A → BA'           |
| 7     | A' B' C' ) A' B $          | (x + y) ^ (z * y)) / (x - y)$        | Usa B → CB'           |
| 8     | A' B' C' ) A' B' C $       | (x + y) ^ (z * y)) / (x - y)$        | Usa C → DC'           |
| 9     | A' B' C' ) A' B' C' D $    | (x + y) ^ (z * y)) / (x - y)$        | Usa D → E             |
| 10    | A' B' C' ) A' B' C' E $    | (x + y) ^ (z * y)) / (x - y)$        | Usa E → x             |
| 11    | A' B' C' ) A' B' C' $      | + y) ^ (z * y)) / (x - y)$           | Consome 'x' da entrada|
| 12    | A' B' C' ) A' B' $         | + y) ^ (z * y)) / (x - y)$           | Usa B' → ε            |
| 13    | A' B' C' ) A' $            | + y) ^ (z * y)) / (x - y)$           | Usa A' → +BA'         |
| 14    | A' B' C' ) A' B + $        | + y) ^ (z * y)) / (x - y)$           | Consome '+' da entrada|
| 15    | A' B' C' ) A' B' C $       | y) ^ (z * y)) / (x - y)$             | Usa B → CB'           |
| 16    | A' B' C' ) A' B' C' D $    | y) ^ (z * y)) / (x - y)$             | Usa D → E             |
| 17    | A' B' C' ) A' B' C' E $    | y) ^ (z * y)) / (x - y)$             | Usa E → y             |
| 18    | A' B' C' ) A' B' C' $      | ) ^ (z * y)) / (x - y)$              | Consome 'y' da entrada|
| 19    | A' B' C' ) A' B' $         | ) ^ (z * y)) / (x - y)$              | Usa B' → ε            |
| 20    | A' B' C' ) A' $            | ) ^ (z * y)) / (x - y)$              | Usa A' → ε            |
| 21    | A' B' C' ) $               | ) ^ (z * y)) / (x - y)$              | Consome ')' da entrada|
| 22    | A' B' C' $                 | ^ (z * y)) / (x - y)$                | Usa C' → ^DC'         |
| 23    | A' B' C' D ^ $             | (z * y)) / (x - y)$                  | Consome '^' da entrada|
| 24    | A' B' C' D $               | (z * y)) / (x - y)$                  | Usa D → (A)           |
| 25    | A' B' C' ) A ( $           | (z * y)) / (x - y)$                  | Consome '(' da entrada|
| 26    | A' B' C' ) A $             | z * y)) / (x - y)$                   | Usa A → BA'           |
| 27    | A' B' C' ) A' B $          | z * y)) / (x - y)$                   | Usa B → CB'           |
| 28    | A' B' C' ) A' B' C $       | z * y)) / (x - y)$                   | Usa C → DC'           |
| 29    | A' B' C' ) A' B' C' D $    | z * y)) / (x - y)$                   | Usa D → E             |
| 30    | A' B' C' ) A' B' C' E $    | z * y)) / (x - y)$                   | Usa E → z             |
| 31    | A' B' C' ) A' B' C' $      | * y)) / (x - y)$                     | Consome 'z' da entrada|
| 32    | A' B' C' ) A' B' $         | * y)) / (x - y)$                     | Usa B' → *CB'         |
| 33    | A' B' C' ) A' B' C * $     | y)) / (x - y)$                       | Consome '*' da entrada|
| 34    | A' B' C' ) A' B' C' D $    | y)) / (x - y)$                       | Usa D → E             |
| 35    | A' B' C' ) A' B' C' E $    | y)) / (x - y)$                       | Usa E → y             |
| 36    | A' B' C' ) A' B' C' $      | )) / (x - y)$                        | Consome 'y' da entrada|
| 37    | A' B' C' ) A' B' $         | )) / (x - y)$                        | Usa B' → ε            |
| 38    | A' B' C' ) A' $            | )) / (x - y)$                        | Usa A' → ε            |
| 39    | A' B' C' ) $               | )) / (x - y)$                        | Consome ')' da entrada|
| 40    | A' B' C' $                 | ) / (x - y)$                         | Consome ')' da entrada|
| 41    | A' B' C' $                 | / (x - y)$                           | Consome '/' da entrada|
| 42    | A' B' $                    | (x - y)$                             | Usa B' → /CB'         |
| 43    | A' B' C $                  | (x - y)$                             | Usa C → DC'           |
| 44    | A' B' C' D $               | (x - y)$                             | Usa D → (A)           |
| 45    | A' B' C' ) A ( $           | (x - y)$                             | Consome '(' da entrada|
| 46    | A' B' C' ) A $             | x - y)$                              | Usa A → BA'           |
| 47    | A' B' C' ) A' B $          | x - y)$                              | Usa B → CB'           |
| 48    | A' B' C' ) A' B' C $       | x - y)$                              | Usa C → DC'           |
| 49    | A' B' C' ) A' B' C' D $    | x - y)$                              | Usa D → E             |
| 50    | A' B' C' ) A' B' C' E $    | x - y)$                              | Usa E → x             |
| 51    | A' B' C' ) A' B' C' $      | - y)$                                | Consome 'x' da entrada|
| 52    | A' B' C' ) A' B' $         | - y)$                                | Usa B' → ε            |
| 53    | A' B' C' ) A' $            | - y)$                                | Usa A' → -BA'         |
| 54    | A' B' C' ) A' B - $        | - y)$                                | Consome '-' da entrada|
| 55    | A' B' C' ) A' B' C $       | y)$                                  | Usa B → CB'           |
| 56    | A' B' C' ) A' B' C' D $    | y)$                                  | Usa D → E             |
| 57    | A' B' C' ) A' B' C' E $    | y)$                                  | Usa E → y             |
| 58    | A' B' C' ) A' B' C' $      | )$                                   | Consome 'y' da entrada|
| 59    | A' B' C' ) A' B' $         | )$                                   | Usa B' → ε            |
| 60    | A' B' C' ) A' $            | )$                                   | Usa A' → ε            |
| 61    | A' B' C' ) $               | )$                                   | Consome ')' da entrada|
| 62    | A' B' C' $                 | $                                    | Entrada aceita        |
