include mpcp.inc
.xmm
.data
	s REAL4 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0
	a REAL4 5.0
	aux REAL8 ?
	msg BYTE "%f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

scaleSeq PROTO seq:PTR REAL4, N:DWORD, alfa:REAL4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke scaleSeq, OFFSET s, LENGTHOF s, a

	mov ecx, LENGTHOF s
	mov esi, OFFSET s
	@@:
		push ecx
		cvtss2sd xmm0, REAL4 PTR [esi]
		movsd aux, xmm0
		invoke printf, OFFSET msg, aux ; o print não imprime REAL4
		pop ecx
		add esi, 4
		loop @B
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scaleSeq PROC seq:PTR REAL4, N:DWORD, alfa:REAL4
	mov esi, seq
	mov ecx, N
	shr ecx, 2
	movss xmm0, alfa
	shufps xmm0, xmm0, 00000000b
	@@:
		movaps xmm1, REAL4 PTR [esi]
		mulps xmm1, xmm0
		movaps REAL4 PTR [esi], xmm1
		add esi, 16
		loop @B

	ret
scaleSeq ENDP
end
