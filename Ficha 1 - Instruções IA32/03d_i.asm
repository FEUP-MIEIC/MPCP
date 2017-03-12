include mpcp.inc

.data
	val DWORD 10110b
	msg BYTE "A sequencia 10110 foi encontrada %d vezes", 13,10,0
.code

main PROC C

	; inicializar registos

	mov EBX, 10110000001011010110b
	xor EAX, EAX
	
	ciclo:
		cmp EBX, 0
		jz fim
		mov ECX, EBX
		shr EBX, 5
		and ECX, val
		cmp ECX, val
		jne ciclo
		inc EAX
		jmp ciclo
	
	fim:
		invoke printf, OFFSET msg, EAX
		invoke _getch
		invoke ExitProcess, 0
	
	
	
main ENDP

end