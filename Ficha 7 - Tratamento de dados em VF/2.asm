include mpcp.inc
.xmm
.data
	A REAL4 4.0
	B REAL4 2.0
	C_ REAL4 1.0
	D REAL4 5.0
	E REAL4 5.0
	R REAL8 ?
	msg BYTE "Resultado: %f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	; A - B
	movss xmm0, A
	subss xmm0, B
	; D + A + E
	movss xmm1, D
	addss xmm1, A
	addss xmm1, E

	; xmm0 / xmm1
	divss xmm0, xmm1

	; multiplicar por C
	mulss xmm0, C_

	; mover resultado para memoria
	cvtss2sd xmm0, xmm0
	movsd R, xmm0 ; printf precisa de argumentos em double

	invoke printf, offset msg, R
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
end