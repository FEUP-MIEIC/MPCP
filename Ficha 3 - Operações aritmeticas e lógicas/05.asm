include mpcp.inc
.data 
	val1 WORD 10
	val2 WORD 5
	msg BYTE "Resultado %d", 13, 10, 0
.code
	
main PROC C
	
	xor EAX, EAX

	mov AX, WORD PTR [val1]
	mov DX, WORD PTR [val2]
	 
	mul DX

	shl EDX, 16
	add EAX, EDX
	
	; terminar
	invoke printf, OFFSET msg, EAX
	invoke _getch
	invoke ExitProcess, 0

main ENDP

end