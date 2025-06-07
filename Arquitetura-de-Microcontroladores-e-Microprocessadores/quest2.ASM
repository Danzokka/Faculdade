    ORG    0
   
    MOV     AL,20
    MOV     BL,C0
    MOV     CL,40
APAGA:
    MOV    [BL],AL
    INC    BL
    DEC    CL
    JNZ    APAGA

    MOV     AL,61
    MOV     BL,C0
    MOV     CL,1A
LOOP:
    IN      0           ; Lê um caractere do teclado para AL
    CMP     AL, 0D     ; Verifica se é ENTER
    JZ      ENTER
    CMP     AL, 08     ; Verifica se é BACKSPACE
    JZ      BACKSPACE
    CMP     AL, 3B    ; Verifica se é ; (para a função CLEAR)
    JZ      CLEAR

    ; Se não for uma tecla especial, escreve o caractere na VDU
    MOV    [BL],AL
    INC    BL
    DEC    CL
    JNZ    LOOP
    JMP    END

ENTER:
    PUSH    BL
    POP     DL           ; DL recebe a posição atual
    AND     DL, F      ; Isola os 4 bits menos significativos para obter o offset
    PUSH    DL           ; Guarda o offset
    PUSH    BL
    POP     DL
    AND     DL, F0     ; Isola os bits altos para encontrar a linha
    CMP     DL, F0      ; Compara se está na linha 'F' ou acima
    JNS     FICA         ; Se DL >= F0, fica na mesma linha
    ADD     DL, F
    POP     AL           ; Recupera o offset
    ADD     DL, AL       ; Adiciona o offset para manter a coluna
    SUB     DL, BL
    ADD     BL, DL       ; Ajusta BL para o início da próxima linha com mesmo offset
    JMP     LOOP

FICA:
    POP     DL           ; Restaura DL porque não mudamos a linha
    JMP     LOOP

BACKSPACE:
    ; Verifica se não está na posição inicial antes de retroceder
    CMP     BL, C0
    JZ      LOOP   ; Se estiver na posição inicial, ignora o backspace
    DEC     BL
    MOV     AL, 20          ; Retrocede um caractere
    MOV     [BL], AL   ; Coloca espaço (apaga o caractere)
    JMP     LOOP

CLEAR:
    MOV     AL,20
    MOV     BL,C0
    MOV     CL,40
    JMP     APAGA       ; Limpa a tela e retorna para o loop principal

END: 
    END
