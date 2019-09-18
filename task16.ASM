; ----- TASK 16 - Traffic Lights with delay and data tables ----
	CLO		; Close unwanted windows
	JMP Start	; Skip past the data table / config

; ----- Light States -------------------------------------------
	DB 90		; 10010000 (Red :: Red)
	DB D0		; 11010000 (Red+Yellow :: Red)
	DB 30		; 00110000 (Green :: Red)
	DB 50		; 01010000 (Yellow :: Red)
	DB 90		; 10010000 (Red :: Red)
	DB 98		; 10011000 (Red :: Red+Yellow)
	DB 84		; 10000100 (Red :: Green)
	DB 88		; 10001000 (Red :: Yellow)
	
; ----- Delay time length for the light states ------------------
	DB 12		; Green light
	DB 4		; Yellow Light
	DB 8		; Red Light
	DB 6		; Red+Yellow Light

Start:
	MOV BL,03	; 02 is the start address of the data table
	JMP Loop	; Begin the Loop

; ----- Time Delay Procedure Stored At Address [20] ------------
	ORG 20
Delay:
	PUSH CL		; Save CL on the stack
	PUSHF		; Save the 20lags on the stack
Rep:
	DEC CL		; Decrement CL
	JNZ Rep		; Keep going until CL becomes zero
	
	POPF		; Restore the flags from the stack
	POP CL		; Restore the previous value of CL from the stack
	RET		; Go back to wherever you called me from

; ----- Loop through the data table ---------------------------
Loop:
	MOV AL,[BL]	; Copy data from table to AL
	OUT 01		; Send AL to Port 1 (The traffic lights)
	
	; Decide which light state Delay time to use.
	; Saving a bit of spacing here for better readability.
	CMP AL,D0	JZ RedYellowDelay
	CMP AL,30	JZ GreenDelay
	CMP AL,50	JZ YellowDelay
	CMP AL,98	JZ RedYellowDelay
	CMP AL,84	JZ GreenDelay
	CMP AL,88	JZ YellowDelay
	JMP RedDelay

; ----- Restore procedure at address [50] ----------------------
	ORG	50
	POP CL		; Get rid of the instr pointer saved in stack
	CMP AL,88	; Is this the last item in light states data table?
	JZ Start	; If yes, jump to Start and set the start address
	INC BL		; If no, then point BL to the next entry
	JMP Loop	; Continue the Loop

YellowDelay:
	MOV CL,[C]	; Retrieve Delaytime for yellow light state in CL
	CALL 20		; Call the Delay subroutine
	CALL 50		; Go back to where the Loop continues (Restore)

RedDelay:
	MOV CL,[D]	; Retrieve Delaytime for red light state in CL
	CALL 20		; Call the Delay subroutine
	CALL 50		; Go back to where the Loop continues (Restore)

GreenDelay:
	MOV CL,[B]	; Retrieve Delaytime for green light state in CL
	CALL 20		; Call the Delay subroutine
	CALL 50		; Go back to where the Loop continues (Restore)

RedYellowDelay:
	MOV CL,[E]	; Retrieve Delaytime for red+yellow light state in CL
	CALL 20		; Call the Delay subroutine
	CALL 50		; Go back to where the Loop continues (Restore)

; ----- Program Ends -------------------------------------------
	END
