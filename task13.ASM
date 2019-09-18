; ----- TASK 13 --------- CHARACTER INPUT OUTPUT ---------------

; --------------------------------------------------------------
;  Input key presses from the keyboard until Enter is pressed.
; --------------------------------------------------------------
	CLO		; Close unwanted windows.
	MOV	BL,80	; Make BL point to the first mem addr we dedicated for storage
Rep:
	IN	00	; Wait for key press - Store it in AL.
	MOV	[BL],AL	; Store the character in the RAM addr BL is pointing to.
	
	CMP	BL,BF	; Have we reached the end of the dedicated RAM for storage?
	JZ	Display	; If yes, display the characters that we've input so far.
	INC	BL	; Else - make BL point to the next mem addr.

	CMP	AL,0D	; Was the Enter key pressed? (ASCII 0D)
	JNZ	Rep	; No - jump back.  Yes - display the chars we've input.

Display:
	MOV	BL,80	; Make BL point to the first mem addr we dedicated for storage
	MOV	AL,C0	; Make AL point to the first VDU addr.
Loop:
	MOV	DL,[BL]	; Copy the data that BL is pointing to in DL.
	MOV	[AL],DL	; Copy data of DL to the VDU.

	CMP	BL,BF	; Have we reached the end of the dedicated RAM?
	JZ	End	; If yes, end the program.

	CMP	DL,0D	; Have we reached the end of the string of text? (Enter key)
	JZ	End	; Yes? Then end the loop.

	INC	BL	; Increment to the next stored character
	INC	AL	; Increment to the next VDU RAM location
	JMP	Loop	; Continue the loop
End:
	END
; --------------------------------------------------------------