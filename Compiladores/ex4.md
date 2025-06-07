# Exercício 03.76
### Rafael Dantas Boeira - 2122082004

### Apresente a Análise de Precedência de Operadores, da entrada `(a + (b . c) + d)` sobre a gramática a seguir.

``` txt
G = ({A, B, C, D}, {a, b, c, d, +, ., (, )}, P, A)
P = {A → (B)
     B → B+C | C
     C → C.D | D
     D → a | b | c | d | A}
```

#### Tabela de Precedência de Operadores da Gramática G

|    | + | . | ( | ) | a,b,c,d | $ |
|----|-----|-----|-----|-----|-----------|-----|
| `+` | `>` | `<` | `<` | `>` | `<`       | `>` |
| `.` | `>` | `>` | `<` | `>` | `<`       | `>` |
| `(` | `<` | `<` | `<` | `=` | `<`       |     |
| `)` | `>` | `>` |     | `>` |           | `>` |
| `a,b,c,d` | `>` | `>` |     | `>` |           | `>` |
| `$` | `<` | `<` | `<` |     | `<`       | `aceita` |

#### Movimentos do analisador de precedência de operadores

| Pilha          | Relação | Entrada                | Ação                | Handle         |
|----------------|---------|------------------------|---------------------|----------------|
| `$`            | `<`     | `(a + (b . c) + d) $`   | empilha `(`         |                |
| `$ (`          | `<`     | `a + (b . c) + d) $`    | empilha `a`         |                |
| `$ ( a`        | `>`     | `+ (b . c) + d) $`      | reduz               | `F → a`        |
| `$ ( F`        | `<`     | `+ (b . c) + d) $`      | empilha `+`         |                |
| `$ ( F +`      | `<`     | `(b . c) + d) $`        | empilha `(`         |                |
| `$ ( F + (`    | `<`     | `b . c) + d) $`         | empilha `b`         |                |
| `$ ( F + ( b`  | `>`     | `. c) + d) $`           | reduz               | `F → b`        |
| `$ ( F + ( F`  | `<`     | `. c) + d) $`           | empilha `.`         |                |
| `$ ( F + ( F .`| `<`     | `c) + d) $`             | empilha `c`         |                |
| `$ ( F + ( F . c`| `>`   | `) + d) $`              | reduz               | `F → c`        |
| `$ ( F + ( F . F`| `>`   | `) + d) $`              | reduz               | `T → T.F`      |
| `$ ( F + ( T`  | `=`     | `) + d) $`              | empilha `)`         |                |
| `$ ( F + F`    | `<`     | `+ d) $`                | empilha `+`         |                |
| `$ ( F + F +`  | `<`     | `d) $`                  | empilha `d`         |                |
| `$ ( F + F + d`| `>`     | `) $`                   | reduz               | `F → d`        |
| `$ ( F + F + F`| `>`     | `) $`                   | reduz               | `T → T+T`      |
| `$ ( T`        | `=`     | `) $`                   | empilha `)`         |                |
| `$ ( T )`      | `>`     | `$`                     | reduz               | `F → (T)`      |
| `$ F`          | `>`     | `$`                     | reduz               | `T → T*P`      |
| `$ S`          | `aceita`| `$`                     |                     |                |
