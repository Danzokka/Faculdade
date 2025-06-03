  /******************************************************************************
  Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
  C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
  Code, Compile, Run and Debug online from anywhere in world.

  *******************************************************************************/

  % MDC - Máximo Divisor Comum
  % mdc(+A, +B, -MDC)
  % Calcula o Máximo Divisor Comum entre dois números inteiros positivos A e B

  % Casos base:
  % Verifica se os números são válidos (inteiros positivos)
  mdc(A, B, false) :- A < 0, !.
  mdc(A, B, false) :- B < 0, !.

  % Quando um dos números é zero
  mdc(0, B, B) :- B >= 0, !.
  mdc(A, 0, A) :- A >= 0, !.

  % Implementação do algoritmo de Euclides para MDC
  mdc(A, B, MDC) :- 
      A > 0, B > 0,
      A > B, !,
      Resto is A mod B,
      mdc(B, Resto, MDC).

  mdc(A, B, MDC) :- 
      A > 0, B > 0,
      A =< B, !,
      Resto is B mod A,
      mdc(A, Resto, MDC).

  % Função principal para execução dos testes
  main:-
      process,
      halt.

  % Processo com todos os testes
  process:-
      write('Testando casos de MDC:'), nl, nl,
      
      write('Teste 1: mdc(-18, 60, X)'), nl,
      mdc(-18, 60, X1), write('X = '), write(X1), nl, nl,
      
      write('Teste 2: mdc(0, 60, X)'), nl,
      mdc(0, 60, X2), write('X = '), write(X2), nl, nl,
      
      write('Teste 3: mdc(18, -60, X)'), nl,
      mdc(18, -60, X3), write('X = '), write(X3), nl, nl,
      
      write('Teste 4: mdc(18, 0, X)'), nl,
      mdc(18, 0, X4), write('X = '), write(X4), nl, nl,
      
      write('Teste 5: mdc(0, 0, X)'), nl,
      mdc(0, 0, X5), write('X = '), write(X5), nl, nl,
      
      write('Teste 6: mdc(8, 12, X)'), nl,
      mdc(8, 12, X6), write('X = '), write(X6), nl, nl,
      
      write('Teste 7: mdc(12, 8, X)'), nl,
      mdc(12, 8, X7), write('X = '), write(X7), nl, nl,
      
      write('Teste 8: mdc(18, 60, X)'), nl,
      mdc(18, 60, X8), write('X = '), write(X8), nl, nl,
      
      write('Teste 9: mdc(60, 18, X)'), nl,
      mdc(60, 18, X9), write('X = '), write(X9), nl.

  :- main.