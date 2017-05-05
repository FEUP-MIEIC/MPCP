include mpcp.inc
.xmm
.data
	a1 REAL8 0.278393
	a2 REAL8 0.230389
	a3 REAL8 0.000972
	a4 REAL8 0.078108
	one REAL8 1.0
	erf_x REAL8 ?
	x REAL8 -1.0
	msg BYTE "Resultado: %f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

erfpos PROTO argX:REAL8, res:PTR REAL8
erf PROTO argX: REAL8, res:PTR REAL8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke erf, x, OFFSET erf_x
	invoke printf, OFFSET msg, erf_x
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
erfpos PROC argX:REAL8, res:PTR REAL8
	xorps xmm0, xmm0 ; acumulador do resultado
	movsd xmm2, one

	movsd xmm1, argX
	mulsd xmm1, a1
	addsd xmm0, xmm1 ; a1*x

	movsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, a2
	addsd xmm0, xmm1 ; a1*x + a2*x^2

	movsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, a3
	addsd xmm0, xmm1 ; a1*x + a2*x^2 + a3*x^3

	movsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, argX
	mulsd xmm1, a4
	addsd xmm0, xmm1 ; a1*x + a2*x^2 + a3*x^3 + a4*x^4

	addsd xmm0, xmm2 ; a1*x + a2*x^2 + a3*x^3 + a4*x^4 + 1

	mulsd xmm0, xmm0
	mulsd xmm0, xmm0

	divsd xmm2, xmm0 ; 1 / (a1*x + a2*x^2 + a3*x^3 + a4*x^4 + 1)^4

	movsd xmm0, one
	subsd xmm0, xmm2 ; 1 - 1/(a1*x + a2*x^2 + a3*x^3 + a4*x^4 + 1)^4

	mov eax, res
	movsd REAL8 PTR [eax], xmm0

	ret
erfpos ENDP

erf PROC argX: REAL8, res:PTR REAL8
	LOCAL abs:REAL8
	mov eax, res
	movsd xmm0, argX
	xorps xmm1, xmm1
	comisd  xmm0, xmm1
	jb negativo

	; argX > 0
	positivo:
		invoke erfpos, argX, eax
		jmp fim

	; argX < 0
	negativo:
		subsd xmm1, xmm0 ; |x|
		movsd abs, xmm1
		invoke erfpos, abs, eax
		xorps xmm0, xmm0
		subsd xmm0, REAL8 PTR [eax]
		movsd REAL8 PTR[eax], xmm0

	fim:
		ret

erf ENDP
end
