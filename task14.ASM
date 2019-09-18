;------ TASK 14 - Traffic lights With Delay ---------------------
	CLO		; Close unwanted windows
	MOV 	AL,90	; Store 10010000 in AL (Red-Red)
	OUT 	01  	; Send AL to Port One (The traffic lights)
Start:
	MOV 	AL,8	; Perform a delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,D0	; Store 11010000 in AL (Red+Yellow :: Red)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,6	; Perform a shorter delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,30	; Store 00110000 in AL (Green :: Red)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,14	; Perform a longer delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,50	; Store 01010000 in AL (Yellow :: Red)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,6	; Perform a shorter delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,90	; Store 10010000 in AL (Red :: Red)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,8	; Perform a delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,98	; Store 10011000 in AL (Red-Red :: Yellow)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,6	; Perform a shorter delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,84	; Store 10000100 in AL (Red :: Green)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,14	; Perform a longer delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,88	; Store 10001000 in AL (Red :: Yellow)
	OUT 	01  	; Send AL to Port 1
	
	MOV 	AL,6	; Perform a shorter delay.
	CALL 	60  	; Call the delay procedure at address [60]
	MOV 	AL,90	; Store 10010000 in AL (Red :: Red)
	OUT 	01  	; Send AL to Port 1
	JMP 	Start	; Jump back to the start.

; ----- Time Delay Procedure Stored At Address [30] -------------
	ORG	60	; Generate machine code from address [30]

	PUSH	AL	; Save AL on the stack.
	PUSHF		; Save the CPU flags on the stack.
Rep:
	DEC	AL	; Subtract one from AL.
	JNZ	REP	; Jump back to Rep if AL was not Zero.

	POPF		; Restore the CPU flags from the stack.
	POP	AL	; Restore AL from the stack.

	RET		; Return from the procedure.
; ---------------------------------------------------------------
	END
; ---------------------------------------------------------------
