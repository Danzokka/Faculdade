    ORG 0
    MOV AL, FF
    OUT 4
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
    MOV BL, 3
    MOV CL, 4
    MOV DL, [CL]
LOOP:
    MOV AL, [BL]
    OUT 4
    DEC DL
    JNZ LOOP
    ADD BL, 2
    ADD CL, 2
    MOV DL, [CL]
	CMP DL, FF
JZ START
    JMP LOOP
    END