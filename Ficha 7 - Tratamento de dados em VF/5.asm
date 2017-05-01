include mpcp.inc
.xmm
.data
	coef3 REAL8 1.5
	coef1 REAL8 -12.5
	coef0 REAL8 7.0
	precisao REAL8 0.1
	tabela real8 101 DUP (?)
	msg BYTE "p(%f) = %f", 13,10,0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calc_poly_tab PROTO C tab:PTR REAL8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke calc_poly_tab, OFFSET tabela
	invoke _getch
	invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calc_poly_tab PROC C USES ESI tab:PTR REAL8
	LOCAL x:REAL8, f:REAL8
	
	mov ECX, 101
	mov ESI, tab
	xorps xmm0, xmm0 ; variavel x
	
	@@:
		; x*(1.5x^2-12.5)
		movsd xmm1, xmm0
		mulsd xmm1, xmm0 ; x^2
		mulsd xmm1, coef3 ; 1.5*x^2
		addsd xmm1, coef1 ; 1.5x^2-12.5
		mulsd xmm1, xmm0 ; 1.5x^3-12.5x
		addsd xmm1, coef0 ; 1.5x^3-12.5x+7
		
		; colocar na memoria
		movsd real8 ptr [ESI], xmm1

		; imprimir
		push ECX
		movsd x, xmm0
		movsd f, xmm1 
		invoke printf, OFFSET msg,x,f
		pop ECX
		
		; proxima iteração
		movsd xmm0, x ; printf pode alterar registos xmm
		add ESI, 8
		addsd xmm0, precisao
		loop @B
	ret
		
calc_poly_tab ENDP
end