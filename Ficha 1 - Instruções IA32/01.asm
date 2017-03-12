; Exercicio 1

; alinea a)

xor EAX, EAX

; alinea b)

dec DWORD PTR [300500ACh]

; alinea c)

mov EAX, EBX
cmp EBX, ECX
jge fim
mov EAX, ECX

fim: ;;;;;

; alinea d)

test EDX, 80000000h
jz fim
neg EDX

fim: ;;;;;

; alinea e)

xor EAX, EAX
mov AX, BX ; EAX <- 16 LSB de EBX
shr EBX, 16
cmp AX, BX
je igual

igual: ;;;;;
