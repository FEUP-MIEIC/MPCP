include mpcp.inc
.xmm
.data
	PI REAL8 3.1415926535897932
	RAIO REAL8 4.0
	AREA REAL8 ?
	msg BYTE "Resultado: %f",13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	movsd xmm0, RAIO
	mulsd xmm0, xmm0
	mulsd xmm0, PI

	movsd AREA, xmm0

	invoke printf, offset msg, AREA
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
end