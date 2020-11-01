include Irvine32.inc
BUFMAX = 42
KEYMAX = 30

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

realKey BYTE 12 DUP(0)

keySize DWORD ?
keyInLen BYTE ?
shiftlen BYTE ?

.code
main PROC
	iterate:
		call EnterPlainText
		call InputKey
	
		mov edx, OFFSET promptOriginal
		call DisplayMessage

		call TranslateBuffer   
		;---------------------
		;-------------------------> 
		mov edx,OFFSET strEncrypt   
		call DisplayMessage

		call ReturnBuffer			;--->2  
		mov edx,OFFSET strDecrypt   
		call DisplayMessage
		call Crlf
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
	mov edx, OFFSET promptKey
	call WriteString		; 여기까지는 정해진 것 출력
	mov ecx,KEYMAX			; 키의 최대 길이
	mov edx,OFFSET keyStr   ; 키 배열의 주소
	;-----------------------------------------------------
	call readstring;		; 키들 입력받기 (회전 수)
	mov ecx, eax			; 입력받은 키의 실제 길이 저장
	inc ecx
	shr ecx, 1

	mov keySize, ecx
	;sub keySize, 1

	mov esi, OFFSET keyStr	; esi에 keyStr 초기 주소 저장
	mov edi, OFFSET realKey	; edi에 "realKey" 배열 첫 인덱스 초기화.


	keyIn:	mov edx, esi			; ParseInteger32는 입력을 EDX로 받으므로..
			call ParseInteger32		; 부호있는 10진수 문자열을 32비트 이진수로 변환한다.
			mov [edi], eax
			;call DumpRegs			; EAX에 맞게 들어갔는지 확인!
			add esi, 2				; 인덱스 2 증가
			inc edi
	loop keyIn

	call crlf
	call crlf

	;---------------------------

	popad
	ret
InputKey ENDP


TranslateBuffer PROC
	pushad
	mov esi,0   
	mov edi, 0
	;mov edi, OFFSET realKey
	mov ecx, bufSize 
  
L1: mov ebx, ecx					; 미리 저장...tmp
	mov cl, realKey[edi]			; edi: key 안의 값
	;call dumpregs
	ror buffer[esi], cl

	mov ecx, ebx					; 되돌리기

	inc esi   
	inc edi
	cmp edi, keySize
	jb L2
	mov edi,0   
L2: loop L1   

	popad
ret
TranslateBuffer ENDP

ReturnBuffer PROC
	pushad
	mov esi,0   
	mov edi, 0
	;mov edi, OFFSET realKey
	mov ecx, bufSize 
  
L1: mov ebx, ecx					; 미리 저장...tmp
	mov cl, realKey[edi]			; edi: key 안의 값
	;call dumpregs
	rol buffer[esi], cl

	mov ecx, ebx					; 되돌리기

	inc esi   
	inc edi
	cmp edi, keySize   
	jb L2
	mov edi,0   
L2: loop L1   

	popad
ret
ReturnBuffer ENDP

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