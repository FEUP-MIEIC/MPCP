include mpcp.inc
.data 
	seqNum DWORD 1,2,4,0,100,2,3
	msg BYTE "O maximo e' %d e minimo e' %d", 13, 10, 0

.code

main PROC C
	mov ecx, LENGTHOF seqNum
	dec ecx
	mov eax, OFFSET seqNum
	
	; como vou assumir primeiro elemento como max. e min. atualizei endereço e contador para elem. seguinte
	; ebx -> min
	; edx <- max
	mov ebx, [eax]
	mov edx, [eax]
	add eax, TYPE seqNum
	
	ciclo:
	
	.IF [eax] < ebx
		mov ebx, [eax]
	.ENDIF

	.IF [eax] > edx
		mov edx, [eax]
	.ENDIF
	
	add eax, TYPE seqNum
	loop ciclo
	
	; terminar
	invoke printf, OFFSET msg, edx, ebx
	invoke _getch
	invoke ExitProcess, 0

main ENDP

end