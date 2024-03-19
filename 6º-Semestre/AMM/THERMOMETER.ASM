    ORG 0
    ON:
        MOV AL, 80
        OUT 3
    LOOP:
	IN 3
	AND AL, 1
        CMP AL, 1
        JZ OFF
        JMP LOOP

    OFF:
        AND AL, 7F
        OUT 3
        JMP ON

        END
