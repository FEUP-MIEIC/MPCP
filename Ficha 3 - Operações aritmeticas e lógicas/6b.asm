include mpcp.inc
.data 
	num DWORD 2
	msg BYTE "Resultado %d", 13, 10, 0
.code
	
main PROC C
	
	mov EBX, [num];
	mov EAX, [num];
	
	; 18 = 16 + 2 = 2^4 + 2^1
	sal EAX, 4
	sal EBX, 1
	
	add EAX, EBX
	
	invoke printf, OFFSET msg, EAX
	invoke _getch
	invoke ExitProcess, 0
	

main ENDP

end