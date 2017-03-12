xor EAX, EAX
xor ECX, EBX

ciclo:
	jecxz fim
	shr ECX, 1
	jc ciclo
	inc EAX
	
fim:
	; print EAX