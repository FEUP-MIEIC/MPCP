include mpcp.inc

;; declaracoes de dados (variaveis globais)
.data
	msg BYTE "isto EXEMplo teste nao sei ARroz MuStArDa", 13,10,0

;; seccao de codigo principal 
.code

LCASE PROTO C pointer: ptr BYTE, len: DWORD

main PROC C
	;; (parte principal)
	invoke LCASE, OFFSET msg, LENGTHOF msg 
	invoke printf, OFFSET msg
	;; Terminar o programa
	invoke	ExitProcess, 0
main ENDP

;; -----------------------------
;; codigo de outras rotinas

LCASE PROC C USES EDI pointer: ptr BYTE, len: DWORD
	; ASCII a = 97 -> z = 122
	; ASCII A = 65 -> Z = 90
	
	mov ECX, len
	mov EDI, pointer
	
	@@:
		mov AL, [EDI]
		cmp AL, 97
		jl isUpper
		cmp AL, 122
		jg isUpper
		sub AL, 32
		mov [EDI], AL
	
	isUpper:
		inc EDI
		loop @B
		
	ret
LCASE ENDP

end