ORG    0

INICIO:
    MOV    AL, 0        ; Zera AL (usaremos AL para leitura dos caracteres)
    MOV    BL, 0        ; Zera BL (usaremos BL para o sentido de rotação)
    MOV    CL, 0        ; Zera CL
    MOV    DL, 0        ; Zera DL

LE_NUMERO:
    IN     0            ; Lê um caractere do teclado
    CMP    AL, 0D       ; Verifica se é ENTER (código ASCII 0D)
    JZ     LE_SENTIDO   ; Se for ENTER, vai para a leitura do sentido de rotação
    CMP    CL, 2         ; Verifica se já leu 2 dígitos
    JZ     LE_NUMERO    ; Se já leu 2 dígitos, ignora o caractere
    INC    CL    
    SUB    AL, 30       ; Converte o caractere para número (0-9)
    MUL    DL, 0A       ; Multiplica DL por 10 para deslocar o dígito
    ADD    DL, AL       ; Adiciona o dígito atual a DL
    JMP    LE_NUMERO    ; Continua lendo os próximos dígitos

LE_SENTIDO:
    IN     0            ; Lê o sentido de rotação
    PUSH   AL
    POP    BL
LOOP_SENTIDO:
    IN     0            ; Espera o usuário pressionar ENTER
    CMP    AL, 0D       ; Verifica se é ENTER (código ASCII 0D)
    JNZ    LE_SENTIDO   ; Continua lendo até ENTER ser pressionado novamente


    CMP    BL, 48       ; Verifica se o sentido é horário
    JZ     HORARIO
    CMP    BL, 41       ; Verifica se o sentido é anti-horário
    JZ     ANTIHORARIO

HORARIO:
    MOV    AL, 11       ; Configura para rotação no sentido horário
LOOP_HOR:
    OUT    05
    ROL    AL
    DEC    DL
    JNZ    LOOP_HOR
    JMP    INICIO

ANTIHORARIO:
    MOV    AL, 11       ; Configura para rotação no sentido anti-horário
LOOP_ANTI:
    OUT    05
    ROR    AL
    DEC    DL
    JNZ    LOOP_ANTI
    JMP    INICIO

    END
