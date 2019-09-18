; ----- EXAMPLE 1 ------- ARITHMETIC ---------------------------

; ===== WORK OUT 2 MULTIPLIED BY 2 =============================
	CLO		; Close unwanted windows.
	MOV AL,2	; Copy a 2 into the AL register.
	MOV BL,2	; Copy a 2 into the BL register.
	MUL AL,BL	; Multiply AL by BL. Answer goes into AL.
	END		; Program ends
; ===== Program Ends ===========================================