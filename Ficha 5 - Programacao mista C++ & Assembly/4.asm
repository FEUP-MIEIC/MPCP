;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tornar imagem cinzenta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cinza PROC USES esi pixels: ptr byte, largura: dword, altura: dword
	; numero de pixels
	mov eax, altura
	mul largura
	mov ecx, eax

	mov esi, pixels
	@@:
		xor eax, eax
		mov dl, byte ptr [esi]
		add eax, edx
		mov dl, byte ptr [esi+1]
		add eax, edx
		mov dl, byte ptr [esi+2]
		add eax, edx

		mov dl, 3
		div dl

		; al contem o tom de cinza
		mov byte ptr [esi], al
		mov byte ptr [esi+1], al
		mov byte ptr [esi+2], al

		add esi, 4
		loop @B

	ret
cinza ENDP

afunc3 PROC USES esi pixels: ptr byte, largura: dword, altura: dword
	; tornar imagem cinzeta
	invoke cinza, pixels, largura, altura

	; definir limite de tom cinza
	mov dl, 127

	; numero de pixels
	mov eax, altura
	mul largura
	mov ecx, eax

	; apontador
	mov esi, pixels

	@@:
		; como as componentes RGB têm o mesmo valor, basta ler uma delas
		cmp byte ptr [esi], dl
		jg white

		; meter pixel a preto
		black: mov dword ptr [esi], 0FF000000h
		jmp nextIt

		; meter pixel a branco
		white: mov dword ptr [esi], 0FFFFFFFFh

		nextIt:
			add esi, 4
			loop @B

	ret
afunc3 ENDP

END
