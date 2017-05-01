;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Colocar a preto o pixel mais intenso de cada linha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
afunc3 PROC USES edi ebx esi pixels: ptr byte, largura: dword, altura: dword

	; loop que percorre as linhas
	mov ecx, altura
	mov edi, pixels
	ciclo:
		push ecx
		mov ecx, largura
		xor ebx, ebx ; registo que preserva o valor do pixel mais intenso
		mov esi, edi ; registo que preserva o endereço do pixel mais intenso
		@@:
			; loop que percorre todos os pixels de uma linha
			xor eax, eax
			xor edx, edx
			mov dl, byte ptr [edi]
			add eax, edx
			mov dl, byte ptr [edi+1]
			add eax, edx
			mov dl, byte ptr [edi+2]
			add eax, edx

			mov dl, 3
			div dl

			cmp eax, ebx
			jng nextIt
			mov ebx, eax
			mov esi, edi

			nextIt:
				; atualizar endereço
				add edi, 4
				loop @B
		; mudar cor do pixel mais intenso para vermelho
		mov dword ptr [esi], 00FF0000h
		pop ecx
		loop ciclo
	ret
afunc3 ENDP

END
