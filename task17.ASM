; ----- TASK 17 ------- Text I/O -------------------------------

; THE MAIN PROGRAM
	MOV	BL,71	; [71] is the address where the text will
			; be stored. The procedure uses this.

	CALL	08	; The procedure at [08] reads in text and
			; places it starting from the address
			; in BL.

			; BL should still contain [71] here.

	CALL	2C	; This procedure displays the text on the
			; simulated screen.

	HALT		; DON'T USE "END" HERE BY MISTAKE OR THE CODE
    			; FOR THE PROCEDURES WILL NOT BE GENERATED

; --------------------------------------------------------------
; A PROCEDURE TO READ IN THE TEXT
	ORG	08	; Code starts from address [08]

	PUSH	AL	; Save AL onto the stack
	PUSH	BL	; Save BL onto the stack
	PUSHF		; Save the CPU flags onto the stack

Rep:
	IN	00	; Input from port 00 (keyboard)
	CMP	AL,0D	; Was key press the Enter key?
	JZ	Stop	; If yes, then jump to Stop
	MOV	[BL],AL	; Copy keypress to RAM at position [BL]
	INC	BL	; BL points to the next location.
	CMP	BL,B0	; Have we reached the end of the dedicated RAM for storage?
	JZ Stop		; If yes, jump to Stop
	JMP	Rep	; Else - Jump back to get the next character

Stop:
	MOV	AL,0	; This is the NULL end marker
	MOV	[BL],AL	; Copy NULL character to this position.
	
	POPF		; Restore flags from the stack
	POP	BL	; Restore BL from the stack
	POP	AL	; Restore AL from the stack
	
	RET		; Return from the procedure.

; --------------------------------------------------------------
; A PROCEDURE TO DISPLAY TEXT ON THE SIMULATED SCREEN
	ORG	2C	; Code starts from address [2C]
	
	MOV	CL,C0	; Make CL point to the first VDU addr.
Loop:
	MOV	AL,[BL]	; Copy the data that BL is pointing to in AL
	PUSH	AL	; Send the character as a parameter to the lowercase procedure
	CALL	45	; Call the lowercase procedure at [45]
	POP	AL	; Retrieve the output of the lowercase procedure
	MOV	[CL],AL	; Print the character in the VDU
	INC BL	; Make BL point to the next char stored in RAM.
	INC	CL	; Make CL point to the next VDU addr.
	CMP	AL,00	; Have we reached the end of the string of text?
	JNZ	Loop	; If not, continue displaying characters
	
	RET		; Else - return from this procedure

; --------------------------------------------------------------
; A PROCEDURE TO CONVERT AN UPPERCASE CHARACTER TO LOWERCASE
	ORG	45	; Code starts at address [45]
	
	POP	DL	; Get the return address
	POP	AL	; Retrieve the parameter /character to be lowercased/
	PUSH	BL	; Save BL's value on the stack
	PUSH	CL	; Save CL's value on the stack
	PUSHF	; And the flags too
	
	CALL	6C	; Use BL as a temporary register to store the original char
	SUB	BL,41	; Check if the character is below 'A'
	JS	Continue	; Continue if it's not within the low range
	
	CALL	6C	; Use BL as a temporary register to store the original char
	MOV	CL,5A	; Let CL store the value of upperase 'Z'
	SUB	CL,BL	; Is the character above 'Z'?
	JS	Continue	; Continue
	
	ADD	AL,20	; Convert to lowercase
	
Continue:
	POPF	; Restore the flags and old register values
	POP	CL
	POP	BL
	PUSH	AL	; Send back the modified character as output in the stack
	PUSH	DL	; Restore the return address
	
	RET	; Return from the procedure

; --------------------------------------------------------------
; A PROCEDURE TO COPY THE VALUE OF AL TO BL USING THE STACK
	ORG	6C	; Code begins at RAM address [6C]
	PUSH	AL	; Do the copying part
	POP	BL
	RET	; Return from the procedure

; --------------------------------------------------------------
	END		; It is correct to use END at the end.
; --------------------------------------------------------------
