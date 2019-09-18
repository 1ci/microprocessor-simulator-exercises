; ----- TASK 7 ------- COUNTING AND JUMP ---------------
; ------------------------------------------------------
	MOV	BL,40	; Initial value stored in BL

Rep:			; Jump back to this label
	DEC	BL	; Subtract ONE from BL
	JMP	Rep	; Jump back to Rep

	END		; Program Ends

; ------------------------------------------------------