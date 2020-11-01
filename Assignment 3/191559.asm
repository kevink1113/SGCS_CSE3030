INCLUDE irvine32.inc

.data
INCLUDE hw3.inc
CODE_A BYTE '1'
CODE_B BYTE '01'
CODE_C BYTE '000'
CODE_D BYTE '0011'
CODE_E BYTE '0010'
buffer BYTE 32 DUP(0), 0
strRes BYTE 32 DUP(0), 0

.code
main PROC
	mov cl, 0
	mov esi, 0
	mov ebp, 1
	mov edi, CODE01
	call shiftAndPrint
	mov strRes[esi], 0
	
	
	mov edx, OFFSET strRes ; time to print result!
	call WriteString

	exit
main ENDP

shiftAndPrint PROC
	mov eax, edi ; set eax to original number

	cmp cl, 32
	jae finn;
	cmp cl, 29
	je long29
	cmp cl, 30
	je long30
	cmp cl, 31
	je long31

	mov dl, cl ; dl:tmp
	sub cl, 28 ; cl-28
	neg cl ; 28-cl

	shr eax, cl; cl: sum of before character's length
	mov cl, dl ; tmp back in
	jmp pyeon

	long28:
		and al, 00001111b
		jmp longfin
	long29:
		and al, 00000111b
		jmp longfin
	long30:
		and al, 00000011b
		jmp longfin
	long31:
		and al, 000000001b
		jmp longfin
	
	pyeon:

	and eax, 00000000000000000000000000001111b ; to make comparision accurate
	
	cmp al, 0011b ; is D?
	je printD

	cmp al, 0010b ; is E?
	je printE

	shr eax, 1 ; shift right 1 to make length 3
	cmp al, 0 ; is C?
	je printC

	shr eax, 1 ; length 2
	cmp al, 01b ; is B?
	je printB

	shr eax, 1 ; length 1
	cmp al, 1 ; is A?
	je printA


	longfin:
		cmp al, 000b
		je printC
		cmp al, 01b
		je printB
		cmp al, 1b
		je printA

shiftAndPrint ENDP


printA:
	mov strRes[esi], 'A'
	inc esi
	add cl, 1
	call shiftAndPrint

printB:
	mov strRes[esi], 'B'
	inc esi
	add cl, 2
	call shiftAndPrint
	
printC:
	mov strRes[esi], 'C'
	inc esi
	add cl,3
	call shiftAndPrint

printD:
	mov strRes[esi], 'D'
	inc esi
	add cl, 4
	call shiftAndPrint

printE:
	mov strRes[esi], 'E'
	inc esi
	add cl, 4
	call shiftAndPrint


finn:
	mov edx, OFFSET strRes ; time to print result!
	mov strRes[esi], 0
	call WriteString
	call Crlf
	inc ebp

	cmp ebp, 2
	je second
	cmp ebp, 3
	je third
	cmp ebp, 4
	je fourth
	cmp ebp, 5
	je fifth

	jmp noo ; neither
	second:
		mov cl, 0
		mov esi, 0
		mov edi, CODE02
		call shiftAndPrint
		inc ebp
	third:
		mov cl, 0
		mov esi, 0
		mov edi, CODE03
		call shiftAndPrint
		inc ebp
	fourth:
		mov cl, 0
		mov esi, 0
		mov edi, CODE04
		call shiftAndPrint
		inc ebp
	fifth:
		mov cl, 0
		mov esi, 0
		mov edi, CODE05
		call shiftAndPrint
		inc ebp

	noo:

exit
END main