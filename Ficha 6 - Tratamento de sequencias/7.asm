include mpcp.inc

.data
	text BYTE "abcdEfGhiJk",0
	find_str BYTE "k",0
	output BYTE "Resultado : %d",13,10,0
.code
; proto
stringLength PROTO C string:PTR BYTE
BUSCA PROTO C string: PTR BYTE, subString : PTR BYTE

; main
main PROC C
	
	invoke BUSCA, OFFSET text, OFFSET find_str
	
	invoke printf, OFFSET output, EAX
		
	_end:
		invoke _getch
		invoke	ExitProcess, 0
main ENDP

;; -----------------------------
;; other procedures

; returns on EAX the length of string, excluding \0
stringLength PROC C USES ESI string:PTR BYTE
	xor EAX, EAX
	mov ESI, string
	
	@@:
		inc EAX
		inc ESI
		cmp BYTE PTR [ESI - 1], 0
		loopne @B
	
	; acerta valor EAX
	dec EAX
	ret
stringLength ENDP

BUSCA PROC C USES ESI EDI string: PTR BYTE, subString : PTR BYTE
	LOCAL string_len : DWORD , subString_len : DWORD
	
	; calcular tamanho do texto
	invoke stringLength, string
	mov string_len, EAX
	
	; calcular tamanho do texto a encontrar
	invoke stringLength, subString
	mov subString_len, EAX
	
	
	; Comparar char a char
	mov ESI, string
	mov EDI, subString
	mov ECX, string_len
	@@:
		mov EBX, ESI
		push ECX
		mov ECX, subString_len
		repe cmpsb
		je found 
		
		; Se a flag Z não está ativa e o ciclo terminou, a substring não foi encontrada
		mov EDI, subString
		mov ESI, EBX
		inc ESI	; ESI fica a apontar para o proximo char
		pop ECX
		loop @B 
	
	fim:
		mov EAX, -1
		ret
		
	found:
		; Se Z=1 e o ciclo acabou, é garantido que a string foi encontradp
		mov EAX, ESI
		sub EAX, subString_len
		sub EAX, string
		ret 

BUSCA ENDP		

end