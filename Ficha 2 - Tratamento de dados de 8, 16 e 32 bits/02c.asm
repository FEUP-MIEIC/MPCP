include mpcp.inc

.data
	bseq SBYTE -5,-4,-3,-2,-1,0,1,2,3,127, 127
	msg BYTE "0- BYTE", 13, 10, "1- WORD", 13, 10,"2- DWORD", 13, 10, "Resposta: %d", 13, 10, 0
.code


main PROC C

	mov ESI, OFFSET bseq
	mov ECX, LENGTHOF bseq
	xor EAX, EAX

	ciclo:
		jecxz isBYTE
		movsx EBX, BYTE PTR [ESI]
		add EAX, EBX
		add ESI, TYPE bseq
		loop ciclo
		
	
	isBYTE:
		cmp EAX, -128
		jl isWORD
		cmp EAX, 127
		jg isWORD
		; se não, está dentro da gama BYTE
		mov EBX, 0
		jmp fim

	isWORD:
		cmp EAX, -32768
		jl isDWORD
		cmp EAX, 32767
		jg isDWORD
		; se não, está dentro da gama WORD
		mov EBX, 1
		jmp fim

	isDWORD:
		mov EBX, 2
		
	fim:
		invoke printf, OFFSET msg, EBX
		invoke _getch
		invoke ExitProcess, 0
		
main ENDP

end