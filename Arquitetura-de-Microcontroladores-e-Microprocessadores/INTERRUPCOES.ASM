    ORG   0

;###################################

    JMP   INICIO
    DB    60
    DB    70
    DB    80


   
INICIO:
    INT    02
    INT    03
    INT    04
    JMP    INICIO

;###################################

    ORG    60
    MOV    AL, 90
    OUT    1
    MOV    AL,0
    OUT    1
    IRET

    ORG    70
    MOV    AL, 48
    OUT    1
    MOV    AL,0
    IRET

    ORG    80
    MOV    AL, 24
    OUT    1
    MOV    AL,0
    IRET
END