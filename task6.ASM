; ----- TASK 6 ------- USING ASCII CODES ---------------
; ------------------------------------------------------
	CLO		; Close unwanted windows.

	MOV AL,48	; Store 'H' in the AL register
	MOV BL,45	; Store 'E' in the BL register
	MOV CL,4C	; Store 'L' in the CL register
	MOV DL,4F	; Store 'O' in the DL register

	; Write out HELLO in memory locations from C0 to C4
	MOV [C0],AL
	MOV [C1],BL
	MOV [C2],CL
	MOV [C3],CL
	MOV [C4],DL

	END
; ------------------------------------------------------