    ORG 0
INICIO:
    IN 0
    PUSH AL
    POP BL
    SUB BL, 30
LOOP:

    MOV AL, FF
    OUT 1
    MOV AL, 00
    OUT 1
    DEC BL
    CMP BL, 00
    JNZ LOOP

    END