;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code

afunc2 PROC USES edi pixels: ptr byte, largura: sdword, altura:sdword
;; preencher com a funcionalidade pretendida
	
	; R <- G | G <- B | B <- R
	
	mov EAX, largura
	mul altura
	mov ECX, EAX ; ECX - numero de pixels
	
	mov EDI, pixels
	
	ciclo:
		mov BL, [EDI] ; BL - Blue
		mov AH, [EDI + 1] ; AH - Green
		mov AL, [EDI + 2] ; AL - Red
		
		mov [EDI + 2], AH
		mov [EDI + 1], BL
		mov [EDI], AL
		
		add EDI, 4
		
		loop ciclo

	ret
afunc2 ENDP

END
