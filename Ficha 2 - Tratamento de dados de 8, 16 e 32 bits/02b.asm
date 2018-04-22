include mpcp.inc

.data
	wseq SWORD -5,-4,-3,-2,-1,0,1,2,3,127
	dwseq SDWORD 10 DUP (?)
	
.code


main PROC C

	mov ESI, OFFSET wseq
	mov EDI, OFFSET dwseq
	mov ECX, LENGTHOF wseq
	
	ciclo:
		mov AX, [ESI]
		CWDE
		mov [EDI], EAX
		
		add ESI, TYPE wseq
		add EDI, TYPE dwseq
		loop ciclo
		
	invoke ExitProcess, 0
		
main ENDP

end