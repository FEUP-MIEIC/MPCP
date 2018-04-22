include mpcp.inc

.data
	bseq SBYTE -5,-4,-3,-2,-1,0,1,2,3,127
	wseq SWORD 10 DUP (?)
	
.code


main PROC C

	mov ESI, OFFSET bseq
	mov EDI, OFFSET wseq
	mov ECX, LENGTHOF bseq
	
	ciclo:
		mov AL, [ESI]
		CBW
		mov [EDI], AX
		
		add ESI, TYPE bseq
		add EDI, TYPE wseq
		loop ciclo
		
	invoke ExitProcess, 0
		
main ENDP

end