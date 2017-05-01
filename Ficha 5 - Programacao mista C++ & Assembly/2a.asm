;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aumentar a intensidade da cor somando uma constante K às componentes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
afunc3 PROC USES edi pixels: ptr byte, largura: dword, altura:dword
	LOCAL x: DWORD, y: DWORD

	; definir posicao do pixel
	mov x, 0 ; [0, largura-1]
	mov y, 0 ; [0, altura-1]

	; calcular posicao do pixel em memoria
	; POS = pixels + [(y-1)*largura + (x-1)]*4
	mov eax, y
	mul largura
	add eax, x
	shl eax, 2

	mov edi, pixels
	add edi, eax

	; mudar a cor para preto
	mov dword ptr [edi], 0FF000000h
	ret
afunc3 ENDP

END
