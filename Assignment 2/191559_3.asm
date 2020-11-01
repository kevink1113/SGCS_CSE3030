include irvine32.inc

stringmax = 42
searchmax = 42

.data
	typeastring BYTE "TYPE_A_String: ",0
	wordforsearch BYTE "A_Word_for_Search: ",0
	found BYTE "Found",0
	notfound BYTE "Not found",0
	promptBye BYTE "Bye!",0

	string BYTE stringmax+1 DUP(0)
	search BYTE searchmax+1 DUP(0)

	stringlen DWORD ?
	searchlen DWORD ?

.code
main PROC
	iterate:
		mov edx, OFFSET typeastring
		call WriteString
	
		call InputString
	
		mov edx, OFFSET wordforsearch
		call WriteString

		call InputSearch
		call SearchPro

		call DumpRegs
	jmp iterate
exit
main ENDP

InputString PROC
	;call DumpRegs
	pushad
	mov ecx, stringmax
	mov edx, OFFSET string
	call ReadString
	;-----
	cmp ax, 0
	je finn
	;-----
	mov stringlen, eax
	popad
	ret
InputString ENDP

InputSearch PROC
	pushad
	mov ecx, searchmax
	mov edx, OFFSET search
	call ReadString
	mov searchlen, eax
	popad
	ret
InputSearch ENDP

SearchPro PROC
	pushad
	mov esi, 0
	mov edi, 0
	mov ecx, stringlen
	sub ecx, searchlen ; iteratetime = (stinglen-searchlen)
	;mov edx, searchlen
	;call DumpRegs
	add ecx, searchlen


	L1:	mov al, search[edi]
		cmp string[esi], al
		je equal
		inc esi ; if not found, increment only string index
		jmp notequalf ; and make search index 0
		equal:
			inc esi
			inc edi ; if found, increment all
			jmp realfin

		notequalf:
			mov edi, 0
			jmp realfin

		realfin:

		;mov edx, searchlen
		;call DumpRegs

		cmp edi, searchlen
		je CheckLast
		
	loop L1
	;call DumpRegs
	jmp notsuccess

	CheckLast:
		;add esi, 1
		cmp string[esi], ' '
		je success
		cmp string[esi], '.'
		je success
		cmp string[esi], 0
		je success
		jmp notsuccess

	success:
		mov edx, OFFSET found
		call WriteString
		call Crlf
		jmp main
		ret
		jmp main
		jmp con

	notsuccess:	
		mov edx, OFFSET notfound
		call WriteString
		call Crlf
		jmp main
	
	con:

ret
jmp main
exit
SearchPro ENDP



finn:
	mov edx, OFFSET promptBye
	call WriteString

exit
END main