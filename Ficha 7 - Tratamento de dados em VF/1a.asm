include mpcp.inc
.xmm
.data
	B REAL8 7.8
	M REAL8 3.6
	N REAL8 3.6
	msg BYTE "Resultado: %f",13,10,0
	P REAL8 ?
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	xorpd xmm1, xmm1
	movsd xmm0, N
	addsd xmm0, B
	mulsd xmm0, M
	subsd xmm1, xmm0
	movsd P, xmm1
	
	invoke printf, offset msg, P
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
end