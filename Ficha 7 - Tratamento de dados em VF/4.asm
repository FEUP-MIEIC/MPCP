include mpcp.inc
.xmm
.data
	varX REAL8 3.0
	varY REAL8 4.0
	varR REAL8 ?
	msg BYTE "Resultado: %f", 13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dist PROTO C x:REAL8, y:REAL8, ptrD: PTR REAL8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke dist, varX, varY, OFFSET varR
	invoke printf, offset msg, varR
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dist PROC C x:REAL8, y:REAL8, ptrD: PTR REAL8
	; x*x
	movsd xmm0, x
	mulsd xmm0, xmm0
	; y*y
	movsd xmm1, y
	mulsd xmm1, xmm1
	; x^2+y^2
	addsd xmm0, xmm1
	; sqrt(x^2+y^2)
	sqrtsd xmm0, xmm0
	
	mov EAX, ptrD
	movsd real8 ptr [EAX], xmm0

	ret
dist ENDP
end