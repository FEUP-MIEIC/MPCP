include mpcp.inc


.data
	msg BYTE "123456789", 0
	output_error BYTE "The arguments are invalid!", 13,10,0
	output BYTE "The string was shrinked with sucess! Result:", 13, 10, 0
.code
; proto
SHRINK_RIGTH PROTO C string:ptr byte, len:dword, n:dword
SHRINK_LEFT PROTO C string:ptr byte, len:dword, n:dword
TRIM PROTO C string:ptr byte, len:dword, N:dword, M:dword

; main
main PROC C

	invoke TRIM, OFFSET msg, LENGTHOF msg, 1,1
	; checks return value on EAX
	cmp EAX, 0
	jne @F

	; sucess
	invoke printf, OFFSET output
	invoke printf, OFFSET msg
	jmp _end

	; error
	@@:
		invoke printf, OFFSET output_error

	_end:
		invoke _getch
		invoke	ExitProcess, 0
main ENDP

;; -----------------------------
;; other procedures

SHRINK_LEFT PROC C USES ESI string:ptr byte, len:dword, n:dword
	; validate arguments
	mov EAX, len
	dec EAX ; lengthof counts the null character
	cmp EAX, n
	jg @F
	je end_p

	; arguments are invalid, N > len
	mov EAX, -1
	ret

	@@:
		mov ESI, string
		add ESI, n
		mov BYTE PTR [ESI], 0

	end_p:
		mov EAX, 0
		ret
SHRINK_LEFT ENDP

SHRINK_RIGTH PROC C USES ESI EDI string:ptr byte, len:dword, n:dword
	; validate arguments
	mov EAX, len
	dec EAX ; lengthof counts the null character
	cmp EAX, n
	jg @F
	je end_p

	; arguments are invalid, N > len
	mov EAX, -1
	ret

	@@:
		; EDI points for the first char of string
		mov EDI, string

		; ESI points to the first char to keep on right side
		mov ESI, string
		add ESI, EAX
		sub ESI, n

		; ECX has the number of chars to keep
		mov ECX, len

		; loop
		rep movsb

		; Inserts the null character
		mov EDI, 0

	end_p:
		mov EAX, 0
		ret
SHRINK_RIGTH ENDP

; N -> right
; M -> left
TRIM PROC C USES ESI EDI string:ptr byte, len:dword, N:dword, M:dword
	mov EDX, M
	add EDX, N
	mov EAX, len
	dec EAX ; lengthof counts the null character
	cmp EAX, EDX ; if M+N > len, arguments are invalid
	jg @F
	je end_p

	; invalid
	mov EAX, -1
	ret

	@@:
		; remove N right side characters
		mov ESI, string
		add ESI, len
		sub ESI, N
		mov byte ptr [ESI], 0

		; remove M left side chars
		mov ECX, len
		sub ECX, M
		sub ECX, N
		inc ECX ; to include null char \0
		mov EDI, string
		mov ESI, string
		add ESI, M
		rep movsb


	end_p:
		mov EAX, 0
		ret

TRIM ENDP

end
