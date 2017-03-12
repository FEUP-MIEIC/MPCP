mov EAX, 1
mov ECX, 10

ciclo:
	cmp ECX, 0
	jz fim
	add EAX, 10
	dec ECX
	jmp ciclo
	
fim:
	; do something