include mpcp.inc

.data
	vecSize WORD 9
	vec SDWORD 3, -3, -6, 6, 5, 1000, -5, 2000, 5
	msg BYTE "Resultado %d", 13, 10, 0
.code

main PROC C

	; definir limites
	mov EAX, 3
	mov EBX, 6
	
	mov ESI, OFFSET vec
	xor ECX, ECX
	mov CX, vecSize
	xor ESP, ESP ; contador
	
ciclo:
	mov EDX, [ESI]
	; EDX >= EAX ?
	cmp EDX, EAX
	jl outRange
	
	; EDX <= EBX ?
	cmp EDX, EBX
	jg outRange
	
	; ambas condições são verdadeiras
	inc ESP
	
	outRange:
		add ESI, TYPE vec
		loop ciclo
	
	mov ECX, ESP
	invoke printf, OFFSET msg, ECX
	invoke _getch
	invoke ExitProcess, 0
	
	
	
main ENDP

end