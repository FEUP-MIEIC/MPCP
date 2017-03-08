include mpcp.inc

.data
	vecSize WORD 9
	val SDWORD 5
	vec SDWORD 5, -3, -4, -4, 0, 5, -5, 0, 5
	msg BYTE "Resultado : %d", 10, 13, 0
.code

main PROC C

	; calcular abs de val e colocar em EAX
	mov EAX, val
	test EAX, 80000000h
	jz valPositive
	neg EAX
	
valPositive:
	mov ESI, OFFSET vec
	xor ECX, ECX
	mov CX, vecSize
	xor EDX, EDX ; counter
	
ciclo:
	mov EBX, [ESI] ; valor da seq
	test EBX, 80000000h ; calcular abs
	jz positive
	neg EBX
		
	positive:
		cmp EBX, EAX
		jne notEqual
		inc EDX
	
notEqual:
	add ESI, TYPE vec
	loop ciclo
		
	mov ECX, EDX

	invoke printf, OFFSET msg, ECX
	invoke _getch
	invoke ExitProcess, 0
	
	
	
main ENDP

end