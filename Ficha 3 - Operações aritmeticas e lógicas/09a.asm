include mpcp.inc
.data 
	

.code

main PROC C

	; inicializar para testar
	mov AL, 5
	mov AH, 5
	
	mov BL, 5
	mov BH, 0
	
	mov CL, 6
	
	; código

	cmp AL, AH
	jbe segundaProposicao ; E-logico é F
	
	cmp BL, BH
	jbe segundaProposicao; E-logico é F
	
	; E-logico é T, logo não é preciso testar a segunda proposicao (T || ? = T)
	jmp true
	
	; Testar segunda proposicao, porque a primeira falhou
	segundaProposicao:
		cmp AH, CL
		jb true
		jmp false
	
	true:
		;mov ecx, 1
		inc ECX
	
	false:
		;mov ecx, 0
	
	
	; terminar
	invoke _getch
	invoke ExitProcess, 0

main ENDP

end