	org 0
START:	
	MOV AL,48
	OUT 1
	MOV AL, 0
	OUT 1
	ADD BL,1
	CMP BL,0A
	JZ FIM
	JMP START
FIM:	END