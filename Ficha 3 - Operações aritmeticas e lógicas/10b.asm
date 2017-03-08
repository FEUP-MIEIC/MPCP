include mpcp.inc

.data
	vecSize WORD 9
	val DWORD 0FFh ; 255
	vec SDWORD 5, -3, -4, 256, 255, 1000, -5, 2000, 5

.code

main PROC C

	
	mov ESI, OFFSET vec
	xor ECX, ECX
	mov CX, vecSize
	
	
ciclo:
	mov EAX, [ESI] ; valor da seq
	test EAX, 80000000h ; calcular abs
	jz positive
	neg EAX
		
	positive:
		cmp EAX, val
		jae doNothing
		mov DWORD PTR [ESI], 0
	
	doNothing:
		add ESI, TYPE vec
		loop ciclo
	

	invoke _getch
	invoke ExitProcess, 0
	
	
	
main ENDP

end