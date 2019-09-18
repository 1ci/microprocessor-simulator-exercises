; ----- TASK 10 ------- COUNTING AND JUMP --------------
; ------------------------------------------------------
	CLO		; Close windows
	MOV AL,1	; Store 1 in AL
	MOV BL,0	; Store 0 in AL
Loop:
	MOV BL,[70]	; Get the cached/previous value of AL and put it in BL.
	MOV [70],AL	; Cache the most recent value of AL into some RAM addr.
	ADD AL,BL	; Add the two numbers. Result goes in AL.
	JMP Loop	; Continue the loop.
	
	END
; ------------------------------------------------------