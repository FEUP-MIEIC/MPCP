include mpcp.inc
.xmm
.data
	ponto REAL8 3.0
	coeficientes REAL8 4.0, 1.0, 2.0, 3.0 ; 4x^3 + x^2 + 2x + 3
	polinomio REAL8 ?
	msg BYTE "Resultado %f", 13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
horner PROTO C xval: REAL8, coefs:PTR REAL8, ncoefs:DWORD, res:PTR REAL8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke horner, ponto, OFFSET coeficientes, LENGTHOF coeficientes, OFFSET polinomio
	; printf não aceita variaveis double precison, por isso converter para dword
	cvtsd2si eax, polinomio
	invoke printf, OFFSET msg, EAX
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
horner PROC C USES ESI xval: REAL8, coefs:PTR REAL8, ncoefs:DWORD, res:PTR REAL8
	mov ESI, coefs
	
	; coeficiente de grau ncoefs-1
	movsd xmm0, REAL8 ptr [ESI]
	mulsd xmm0, xval
	add ESI, 8
	
	mov ECX, ncoefs
	sub ECX, 2

	@@:
		addsd xmm0, REAL8 ptr [ESI]
		mulsd xmm0, xval
		add ESI, 8
		loop @B
	
	; adicionar coeficiente de grau 0
	addsd xmm0, REAL8 ptr [ESI]
	movsd REAL8 PTR res, xmm0
	
	ret
		
horner ENDP
end