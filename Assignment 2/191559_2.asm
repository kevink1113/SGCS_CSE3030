include Irvine32.inc
BUFMAX = 42
KEYMAX = 12

.data
promptText BYTE "Enter a plain Text: ",0
promptKey BYTE "Enter a key: ",0

promptOriginal BYTE "Original Text: ",0
strEncrypt BYTE "Encrypted Text: ",0
strDecrypt BYTE "Decrypted Text: ",0
promptBye BYTE "Bye!",0

buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD ?
keyStr BYTE KEYMAX+1 DUP(0)
keySize DWORD ?

.code
main PROC
	iterate:
		call EnterPlainText
		call InputKey
	
		mov edx, OFFSET promptOriginal
		call DisplayMessage

		call TranslateBuffer   
		mov edx,OFFSET strEncrypt   
		call DisplayMessage
		call TranslateBuffer   
		mov edx,OFFSET strDecrypt   
		call DisplayMessage
		call Crlf
	jmp iterate
	exit
main ENDP

EnterPlainText PROC
	pushad
	mov edx,OFFSET promptText   
	call WriteString
	mov ecx,BUFMAX
	mov edx,OFFSET buffer   
	call ReadString
	;------
	cmp ax, 0
	je finn
	;------

	mov bufSize,eax   
	;call Crlf
	popad
	ret
EnterPlainText ENDP

InputKey PROC
	pushad
	mov edx,OFFSET promptKey
	call WriteString
	mov ecx,KEYMAX
	mov edx,OFFSET keyStr   
	call ReadString
	mov keySize,eax   
	call Crlf
	popad
	ret
InputKey ENDP

TranslateBuffer PROC
	pushad
	mov esi,0   
	mov edi,0
	mov ecx,bufSize   
  
L1: mov al,keyStr[edi]
	xor buffer[esi],al
	inc esi   
	inc edi   
	cmp edi,keySize   
	jb L2
	mov edi,0   
L2: loop L1   

	popad
ret
TranslateBuffer ENDP

DisplayMessage PROC
	pushad
	call WriteString
	mov edx,OFFSET buffer   
	call WriteString
	call Crlf
	;call Crlf
popad
ret
DisplayMessage ENDP

jmp pyeon

pyeon:
	ret


finn:
	mov edx, OFFSET promptBye
	call WriteString

exit
END main