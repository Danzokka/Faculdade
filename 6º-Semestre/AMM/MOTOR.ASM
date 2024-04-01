    ORG 0
    MOV BL, 5
INICIO:
    MOV AL, 1
    OUT 5

    MOV AL, 2
    OUT 5

    MOV AL, 4
    OUT 5

    MOV AL, 8
    OUT 5

    DEC BL
    JNZ INICIO
    END
