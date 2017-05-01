include mpcp.inc
.xmm
.data
	PI REAL8 3.14159265
	f_x REAL8 ?
	x REAL8 -5.0
	msg BYTE "Resultado: %f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

rotF PROTO argX:REAL8, resultado:PTR REAL8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke rotF, x, OFFSET f_x
	invoke printf, OFFSET msg, f_x
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

rotF PROC argX:REAL8, resultado:PTR REAL8

	xorps xmm0, xmm0
	comisd xmm0, argX
	jc @F

	; x < 0
		mov eax, 4
		cvtsi2sd xmm1, eax
		subsd xmm1, argX ; 4-x
		sqrtsd xmm1, xmm1 ; sqrt(4-x)
		mov eax, 1
		cvtsi2sd xmm0, eax
		divsd xmm0, xmm1 ; 1/sqrt(4-x)
		jmp fim

	@@:
	; x => 0
		movsd xmm0, argX
		addsd xmm0, PI ; x + PI
		mulsd xmm0, xmm0 ; (x + PI)^2
		mulsd xmm0, xmm0 ; (x + PI)^3
		sqrtsd xmm0, xmm0 ; sqrt((x + PI)^3)


	; colocar resultado na memoria
	fim:
		mov eax, resultado
		movsd REAL8 PTR [eax], xmm0
		ret
rotF ENDP
end
