; ----- TASK 8 ------- COUNTING AND JUMP ---------------
; ------------------------------------------------------
	MOV	BL,40	; Initial value stored in BL

Rep:			; Jump back to this label
	ADD	BL,3	; Add three to BL
	JMP	Rep	; Jump back to Rep

	END		; Program Ends

; ------------------------------------------------------