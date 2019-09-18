; ----- TASK 12 --------- CHARACTER INPUT OUTPUT ---------------

; --------------------------------------------------------------
;  Input key presses from the keyboard until Enter is pressed.
; --------------------------------------------------------------
	CLO		; Close unwanted windows.
	MOV	BL,C0	; Make BL point to the first mem addr of the VDU.
Rep:
	IN	00	; Wait for key press - Store it in AL.
	MOV	[BL],AL	; Display the character in the VDU.
	INC	BL	; Make BL point to the next mem addr.
	JZ	End	; End the program if the BL register reaches the end of the VDU.
	CMP	AL,0D	; Was it the Enter key? (ASCII 0D)
	JNZ	Rep	; No - jump back.  Yes - end.
End:
	END
; --------------------------------------------------------------