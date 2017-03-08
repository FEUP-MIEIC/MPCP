include mpcp.inc
.data 

	msg BYTE "Resultado %d", 13, 10, 0
.code
	
main PROC C
	
	mov EAX, 2
	mov EDX, 18
	
	mul EDX
	
	; EDX:EAX
	jc r64bits
	
	; Resultado é representavel com 32 bits
	invoke printf, OFFSET msg, EAX
	invoke _getch
	invoke ExitProcess, 0
	
r64bits:
	invoke _getch
	invoke ExitProcess, 0

main ENDP

end