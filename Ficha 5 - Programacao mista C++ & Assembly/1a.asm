;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code

afunc2 PROC USES edi pixels: ptr byte, largura: dword, altura: dword
	; Coloca byte B = 0

	; calcular numero de pixels
	mov eax, largura
	mul altura
	mov ecx, eax
	; mover apontador para edi
	mov edi, pixels
	@@:
		mov byte ptr [edi], 0
		add edi, 4
		loop @B

	ret
afunc2 ENDP

END
