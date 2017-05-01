include mpcp.inc

.data
	O_FRASES BYTE "Numero de frases : %d", 13,10,0
	O_PALAVRAS BYTE "Numero de palavras da frase 2: %d", 13,10,0
	buf BYTE "Frase 1. Isto e outra frase com algumas palavras. Mais uma frase. Outra. Arroz",0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; proto ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NUM_FRASES PROTO C BUFFER:PTR BYTE
NUM_PALAVRAS PROTO C BUFFER:PTR BYTE, N:DWORD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; main ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC C
	invoke NUM_FRASES, OFFSET buf
	invoke printf, OFFSET O_FRASES, EAX
	
	invoke NUM_PALAVRAS, OFFSET buf, 2
	invoke printf, OFFSET O_PALAVRAS, EAX
		
	_end:
		invoke _getch
		invoke	ExitProcess, 0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; other procedures ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NUM_FRASES PROC C USES ESI BUFFER:PTR BYTE

	mov ESI, BUFFER
	xor ECX, ECX
	
	@@:
		lodsb
		cmp AL, 0 ; verificar se chegou ao fim do texto
		je fim
		
		cmp AL, 46 ; 46 ASCII do ponto final
		jne @B
		inc ECX
		jmp @B
	
	fim:
		mov EAX, ECX
	
	ret
NUM_FRASES ENDP

NUM_PALAVRAS PROC C USES ESI BUFFER:PTR BYTE, N:DWORD
	
	mov ESI, BUFFER
	mov ECX, 1
	
	@@:
		cmp ECX, N
		je FRASE_ENCONTRADA
		
		FRASE_SEGUINTE:
			lodsb
			cmp AL, 0 ; verificar se chegou ao fim do texto
			je FRASE_NAO_ENCONTRADA
			
			cmp AL, 46 ; 46 ASCII do ponto final
			jne FRASE_SEGUINTE
			inc ECX
			jmp @B
	
	FRASE_ENCONTRADA:
		xor ECX, ECX
		; esi aponta para o inicio da frase
		@@:
			lodsb
			cmp AL, 46 ; verificar se chegou ao fim da frase
			je FIM
			
			cmp AL, 32 ; 32 ASCII do espaço
			jne @B
			inc ECX
			jmp @B
	
	FIM:
		mov EAX, ECX
		ret
		
	FRASE_NAO_ENCONTRADA:
		mov EAX, 0
		ret
NUM_PALAVRAS ENDP			
end