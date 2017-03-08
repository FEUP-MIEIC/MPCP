include mpcp.inc
.data 
	seqNum SDWORD 1,2,4,0,100,-256, -1, 200
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
		cmp [eax], ebx
		jge notMin
		mov ebx, [eax]
	
	notMin:
		cmp edx, [eax]
		jge notMax
		mov edx, [eax]
	
	notMax:	
		add eax, TYPE seqNum
	
	loop ciclo
	
	; terminar
	invoke printf, OFFSET msg, edx, ebx
	invoke _getch
	invoke ExitProcess, 0

main ENDP

end