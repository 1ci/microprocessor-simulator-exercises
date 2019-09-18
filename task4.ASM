; ----- EXAMPLE 1 ------- ARITHMETIC ---------------------------

; ===== DIVIDE BY ZERO =========================================
	CLO		; Close unwanted windows.
	MOV AL,2	; Copy a 2 into the AL register.
	DIV AL,0	; Divide AL by 0.
	END		; Program ends
; ===== Program Ends ===========================================