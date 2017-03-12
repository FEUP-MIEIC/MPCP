xor EAX, EAX

ciclo:
	cmp EBX, 0
	jz fim
	shr EBX, 1
	adc EAX, 0
	jmp ciclo
	
fim:
	; do something