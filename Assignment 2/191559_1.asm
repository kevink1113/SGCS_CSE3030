include irvine32.inc

inputMAX = 42

.data
	promptStart BYTE "Type_A_String_To_Reverse: ",0
	promptRes BYTE "Reversed_String: ",0
	promptBye BYTE "Bye!",0

    ;var byte ? ; for taking input
    ;var1 byte ? ; for saving reverse string

	var byte 42 DUP(0)
	var1 byte 42 DUP(0)

	len DWORD ?
.code

main PROC
	iterate:
		mov edx, OFFSET promptStart
		call WriteString

		call reverse ; calling reverse method
	jmp iterate
exit
main ENDP

reverse PROC
    mov edx , OFFSET var
    
	mov ecx, inputMAX
	call ReadString ; taking input ^

	;------------------
	;INT 21h
	;cmp var[0], 0Dh
	cmp ax, 0
	je finn
	;------------------

	mov len, eax
    mov ecx,eax ;number of char
    
	mov esi,0
    l1:
        movzx edx,var[esi] ; move char to edx
        push edx ; push in stack
        inc esi
    loop l1
    ; now saving in other string
    mov ecx ,eax 
    mov esi , 0
    
    l2:
        pop ebx ; retrun last char

		cmp bl, ' '
		je con

		cmp bl, 'Z'			; is upper case?
		jbe toLower			; if yes jmp to toLower 
		
		cmp bl, 'z'			; is lower case?
		jbe toHigher		; if yes jmp to toHigher


		toLower:
			cmp bl, 'A'
			jb con
			add bl, 32
			jmp con

		toHigher:
			cmp bl, 'a'
			jb con
			sub bl, 32
			jmp con

		con:

        mov var1[esi],bl
        inc esi
    loop l2

	mov edx, OFFSET promptRes
	call WriteString
	
	mov eax, len
	;---
	mov var1[eax], 0
	;---
    mov edx , OFFSET var1

    call WriteString
    call crlf

jmp pyeon

pyeon:
	ret

finn:
	mov edx, OFFSET promptBye
	call WriteString
	
exit


reverse ENDP

END main