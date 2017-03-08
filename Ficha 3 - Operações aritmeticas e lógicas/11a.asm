include mpcp.inc

.data
	seqNum DWORD 9,1,0
	msg BYTE "Media: %d", 13, 10, 0
	
.code

main PROC C

	mov EBX, OFFSET seqNum
	mov ECX, LENGTHOF seqNum
	xor EAX, EAX
	
	adder:
		add EAX, [EBX]
		add EBX, TYPE seqNum
		loop adder
	
	mov EBX, LENGTHOF seqNum
	div EBX
	
	; resultado div inteira fica em EAX
	; resto fica em EDX
	; se Resto > Num elementos [EBX] / 2, incrementar EAX
	shr EBX, 1
	cmp EDX, EBX
	jbe noRound
	inc EAX
	
	noRound:
		invoke printf, OFFSET msg, EAX
		invoke _getch
		invoke ExitProcess, 0
	
	
	
main ENDP

end