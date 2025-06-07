    ORG 0

    MOV AL,41
    MOV CL, C0
    MOV [CL], AL
    MOV BL, 1
INICIO:
    INC AL
    INC CL
    MOV [CL], AL
    INC BL
    CMP BL, 1A
    JNZ INICIO
    END