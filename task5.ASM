; ----- EXAMPLE 2 ------- HEXADECIMAL --------------------------

; ===== CONTROL THE TRAFFIC LIGHTS =============================

	CLO		; Close unwanted windows
	MOV AL,90	; Store 10010000 in AL (Red-Red)
	OUT 01		; Send AL to Port One (The traffic lights)
Loop:
	MOV AL,D0	; Store 11010000 in AL (Red+Yellow-Red)
	OUT 01		; Send AL to Port 1
	NOP		; Do nothing for 1 clock cycle
	MOV AL,30	; Store 00110000 in AL (Green-Red)
	OUT 01		; Send AL to Port 1
	NOP NOP NOP NOP ; Do nothing for 4 clock cycles
	MOV AL,50	; Store 01010000 in AL (Yellow-Red)
	OUT 01		; Send AL to Port 1
	NOP		; Do nothing for 1 clock cycle
	MOV AL,90	; Store 10010000 in AL (Red-Red)
	OUT 01		; Send AL to Port 1
	NOP NOP		; Do nothing for 2 clock cycles
	MOV AL,98	; Store 10011000 in AL (Red-Red+Yellow)
	OUT 01		; Send AL to Port 1
	NOP		; Do nothing for 1 clock cycle
	MOV AL,84	; Store 10000100 in AL (Red-Green)
	OUT 01		; Send AL to Port 1
	NOP NOP NOP NOP	; Do nothing for 4 clock cycles
	MOV AL,88	; Store 10001000 in AL (Red-Yellow)
	OUT 01		; Send AL to Port 1
	NOP		; Do nothing for 1 clock cycle
	MOV AL,90	; Store 10010000 in AL (Red-Red)
	OUT 01		; Send AL to Port 1
	NOP		; Do nothing for 1 clock cycle
	JMP Loop	; Jump back to the start of the Loop
	END		; End the program

; ===== Program Ends ==========================================