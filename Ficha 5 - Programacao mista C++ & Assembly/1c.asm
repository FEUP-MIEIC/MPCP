;; Funcao 2 em linguagem assembly
;; Valor de retorno: nenhum
.686
.model flat, C

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aumentar a intensidade da cor somando uma constante K às componentes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
afunc2 PROC USES edi pixels: ptr byte, largura: dword, altura: dword
	LOCAL k:byte
	; calcular numero de pixels
	mov eax, largura
	mul altura
	mov ecx, eax

	; mover apontador para edi
	mov edi, pixels
	xor edx, edx
	@@:
		; se edx for 3, o byte atual corresponde ao 'alpha', como tal avançar para pixel seguinte
		cmp edx, 3
		cmove edx, 0
		je next_it

		xor eax, eax
		mov al, byte ptr [edi]
		add al, k
		jnc no_carry
		mov al, 255

		no_carry:
			mov byte ptr [edi], al
			inc edx

		next_it:
			inc edi
			loop @B

	ret
afunc2 ENDP

END
