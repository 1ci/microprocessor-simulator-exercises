; ===== Seven Segment Displays Port 02 =================
	JMP 	Start	; Skip past the data table / config
	DB	20	; Hardware Timer Interrupt Vector

	DB	FB	; 1111 1011 (0)
	DB	0B	; 0000 1011 (1)
	DB	B7	; 1011 0111 (2)
	DB	9F	; 1001 1111 (3)
	DB	4F	; 0100 1111 (4)
	DB	DD	; 1101 1101 (5)
	DB	FD	; 1111 1101 (6)
	DB	8B	; 1000 1011 (7)
	DB	FF	; 1111 1111 (8)
	DB	DF	; 1101 1111 (9)
Start:
	CALL	70	; Reset everything
	STI	; Set the interrupt flag
Idle:
	JMP	Idle	; Wait for interrupt

; ===== Hardware Timer Handler =========================
	ORG	20
	CLI	; Clear the interrupt flag to prevent crashes
	CALL	80	; Count up
	STI	; Set the interrupt flag back again
	IRET	; Return from the interrupt

; ===== Procedure to reset the right side pointer ======
	ORG	30
	MOV	BL,04	; Reset right-hand side pointer
	RET

; ===== Procedure to reset the left side pointer =======
	ORG	40
	MOV	CL,04	; Reset left-hand side pointer
	RET

; ===== Procedure to reset the right-hand side =========
	ORG	50
	;PUSH	AL	; Save AL on stack
	;PUSHF	; Save the flags
	MOV	AL,[03]	; Get right side null
	OUT	02	; Update the display
	;POPF	; Restore flags
	;POP	AL	; Restore AL
	RET	; Return from the procedure

; ===== Procedure to reset the left-hand side ==========
	ORG	60
	;PUSH	AL	; Save AL on stack
	;PUSHF	; Save the flags
	MOV	AL,[03]	; Get right side null
	AND	AL,FE	; Convert AL to left side null
	OUT	02	; Update the display
	;POPF	; Restore flags
	;POP	AL	; Restore AL
	RET	; Return from the procedure

; ===== Procedure to reset everything ==================
	ORG	70
	CALL	30	; Reset the right-hand side pointer
	CALL	40	; Reset the left-hand side pointer
	CALL	50	; Reset the right-hand side (visually)
	CALL	60	; Reset the left-hand side (visually)
	RET

; ===== Procedure to count up ==========================
	ORG	80
	;PUSH	AL	; Save AL on stack
	;PUSHF	; Save the flags
	CMP	BL,0D	; Have we reached the right-hand side end?
	JZ	Next
	MOV	AL,[BL]	; Get data of what BL points to
	OUT	02	; Update the display
	INC	BL	; Go to the next right-hand side number
	;POPF	; Restore the flags
	;POP	AL	; Restore AL
	RET	; Return from the procedure
Next:
	CMP	CL,0D	; Should we start over from 00?
	JZ	Restart
	CALL	30	; Reset the right-hand side pointer
	MOV	AL,[03]	; Set right-hand side null
	OUT	02	; Update the display
	MOV	AL,[CL]	; Get data of what CL points to
	AND	AL,FE	; Convert AL to left-side
	OUT	02	; Update the display
	INC	CL	; Go to the next left-hand side number
	;POPF	; Restore the flags
	;POP	AL	; Restore AL
	RET	; Return from the procedure
Restart:
	CALL	70	; Reset everything
	;POPF	; Restore the flags
	;POP	AL	; Restore AL
	RET	; Return from the procedure
	
	END
; ======================================================