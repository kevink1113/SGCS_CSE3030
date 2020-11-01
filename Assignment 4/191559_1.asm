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
	call WriteString		; ��������� ������ �� ���
	mov ecx,KEYMAX			; Ű�� �ִ� ����
	mov edx,OFFSET keyStr   ; Ű �迭�� �ּ�
	;-----------------------------------------------------
	call readstring;		; Ű�� �Է¹ޱ� (ȸ�� ��)
	mov ecx, eax			; �Է¹��� Ű�� ���� ���� ����
	inc ecx
	shr ecx, 1

	mov keySize, ecx
	;sub keySize, 1

	mov esi, OFFSET keyStr	; esi�� keyStr �ʱ� �ּ� ����
	mov edi, OFFSET realKey	; edi�� "realKey" �迭 ù �ε��� �ʱ�ȭ.


	keyIn:	mov edx, esi			; ParseInteger32�� �Է��� EDX�� �����Ƿ�..
			call ParseInteger32		; ��ȣ�ִ� 10���� ���ڿ��� 32��Ʈ �������� ��ȯ�Ѵ�.
			mov [edi], eax
			;call DumpRegs			; EAX�� �°� ������ Ȯ��!
			add esi, 2				; �ε��� 2 ����
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
  
L1: mov ebx, ecx					; �̸� ����...tmp
	mov cl, realKey[edi]			; edi: key ���� ��
	;call dumpregs
	ror buffer[esi], cl

	mov ecx, ebx					; �ǵ�����

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
  
L1: mov ebx, ecx					; �̸� ����...tmp
	mov cl, realKey[edi]			; edi: key ���� ��
	;call dumpregs
	rol buffer[esi], cl

	mov ecx, ebx					; �ǵ�����

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