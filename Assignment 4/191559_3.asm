INCLUDE Irvine32.inc

.data
	prompt1		BYTE "Enter a Multiplier : ", 0
	prompt2		BYTE "Enter a Multiplicand : ", 0
	prtResult	BYTE "Product : ", 0
	bye			BYTE "Bye!",0

.code
main PROC
	iterate:
		mov edx, OFFSET prompt1
		call WriteString
		call ReadHex ; enter a multiplier(eax)
		cmp eax, 0
		je finn
		mov ecx, eax ; ecx works as a temporary storage for EAX.

		mov edx, OFFSET prompt2
		call WriteString
		call ReadHex ; enter a multiplicand(ebx)
		mov ebx, eax
		mov eax, ecx ; temporary back.

		call BitwiseMultiply
		mov edx, OFFSET prtResult
		call WriteString
		call WriteHex
		call Crlf
		call Crlf
	jmp iterate
finn:
	mov edx, OFFSET bye
	call WriteString
exit
main ENDP

BitwiseMultiply PROC
	mov edx, 0
	mov cl, 0
	L1:	shr eax, 1
		jc add_by_shift
		inc cl
		jmp next
	add_by_shift:
		shl ebx, cl
		add edx, ebx
		shl ebx, 1
		mov cl, 0
	next:
		cmp eax, 0
		je return
		jmp L1
	return:
		mov eax, edx
		ret
BitwiseMultiply ENDP
END main