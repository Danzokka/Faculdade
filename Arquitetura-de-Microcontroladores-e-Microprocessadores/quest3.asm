    ORG 0
    JMP START
    DB 24
    DB 3
    DB 4F
    DB B
    DB 1F
    DB 3
    DB 18
    DB 2
    DB 8F
    DB 5
    DB 18
    DB 3
    DB 48
    DB 9
    DB 18
    DB 7
    DB 88
    DB 10
    DB 2A
    DB 8
    DB 8A
    DB 3
	DB 1A
    DB A
    DB 48
    DB 14
	DB 14
	DB 4
	DB 88
	DB 16
	DB 28
	DB 11
	DB 48
	DB 8
	DB 18
	DB B
	DB 45
	DB 13
	DB 25
	DB 6
	DB 88
	DB 9
	DB 25
	DB B
	DB 48
	DB 9
	DB 25
	DB 6
	DB 83
	DB 31
	DB FF
	DB FF

START:
    MOV AL, FF
    MOV DL, F
    OUT 4           ; Reseta a serpente no início
LOOP:
    IN 0            ; Lê um caractere do teclado
    CMP AL, 72
    JZ RESET
    CMP AL, 0D     ; Checa se é ENTER para terminar
    JZ END
    CMP AL, 77
    JZ CIMA
    CMP AL, 61
    JZ ESQUERDA
    CMP AL, 64
    JZ DIREITA
    CMP AL, 73
    JZ BAIXO
    CMP AL, 2B     ; Aumentar a distância
    JZ AUMENTA
    CMP AL, 2D
    JZ DIMINUI
    CMP AL, 78     ; Modo automático
    JZ AUTO

    JMP LOOP

RESET:
    JMP START       ; Reinicia a serpente

END:
    CALL F0

CIMA:
    MOV CL, 80
    ADD CL, DL
    PUSH CL
    POP AL
    OUT 4
    JMP LOOP

ESQUERDA:
    MOV CL, 20
    ADD CL, DL
    PUSH CL
    POP AL
    OUT 4
    JMP LOOP

DIREITA:
    MOV CL, 10
    ADD CL, DL
    PUSH CL
    POP AL
    OUT 4
    JMP LOOP

BAIXO:
    MOV CL, 40
    ADD CL, DL
    PUSH CL
    POP AL
    OUT 4
    JMP LOOP

AUMENTA:
    INC DL          ; Aumenta a distância percorrida
    JMP LOOP

DIMINUI:
    DEC DL          ; Diminui a distância percorrida
    JMP LOOP

AUTO:
    MOV AL, FF
    MOV BL, 2
    MOV Cl, 3
    MOV DL, [CL]

LOOP_AUTO:
    MOV AL, [BL]
    OUT 4
    DEC DL
    JNZ LOOP_AUTO
    ADD BL, 2
    ADD CL, 2
    MOV DL, [CL]
    CMP DL, FF
    JZ END
    JMP LOOP_AUTO

ORG F0
    END


