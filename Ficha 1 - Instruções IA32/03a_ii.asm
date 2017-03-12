mov EAX, 1
mov ECX, 10

ciclo:
	jecxz
	add EAX, 10
	dec ECX
	jmp ciclo
	
fim:
	; do something