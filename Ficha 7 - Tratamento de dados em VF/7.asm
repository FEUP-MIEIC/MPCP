include mpcp.inc
.xmm
.data
	v1 REAL4 3.0, 1.0, 2.0
	v2 REAL4 0.0, 3.0, 4.0
	Resultado REAL4 ?
	msg BYTE "Resultado: %f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

prodint PROTO C vectX:PTR REAL4, vectY:PTR REAL4, N:DWORD, resposta:PTR REAL4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke prodint, OFFSET v1, OFFSET v2, LENGTHOF v1, OFFSET Resultado

	; printf não aceita variaveis simple precison, por isso converter para dword
	;cvtss2si eax, Resultado
	invoke printf, OFFSET msg, EAX
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prodint PROC C USES ESI EDI vectX:PTR REAL4, vectY:PTR REAL4, N:DWORD, resposta:PTR REAL4
	mov ESI, vectX
	mov EDI, vectY
	mov ECX, N
	xorps xmm0, xmm0 ; acumulador

	@@:
		movss xmm1, REAL4 PTR [ESI]
		mulss xmm1, REAL4 PTR [EDI]
		add ESI, 4
		add EDI, 4
		addss xmm0, xmm1
		loop @B

	mov EAX, resposta
	movss REAL4 PTR [EAX], xmm0

	ret

prodint ENDP
end
