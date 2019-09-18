;---- TASK 15 - A procedure to double a number -----------------------
	CLO 		; Close unwanted windows
Loop:
	MOV 	AL,7 	; Put 7 into AL
	CALL 	40 	; Call the doubling procedure at address [40]
	JMP 	Loop 	; Loop through the main program

;---- A procedure at [40] to double a number. Answer goes into AL ----
	ORG 	40
	MUL 	AL,2 	; Double AL
	RET 		; Return from the procedure

;---- Program Ends ----
	END
