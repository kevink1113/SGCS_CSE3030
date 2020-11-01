INCLUDE Irvine32.inc

.data
	MenuPrompt	     BYTE "1. x AND y"     ,0dh,0ah
                     BYTE "2. x OR y"      ,0dh,0ah
                     BYTE "3. NOT x"       ,0dh,0ah
                     BYTE "4. X XOR y"     ,0dh,0ah
                     BYTE "5. Exit program",0

	prompt1 BYTE "Enter x : ",0
	prompt2 BYTE "Enter y : ",0
	resultAND   BYTE "Result of x AND y : ",0
	resultOR    BYTE "Result of x OR y : ",0
	resultNOT   BYTE "Result of x NOT y : ",0
	resultXOR   BYTE "Result of x XOR y : ",0
	choose		BYTE "Choose Calculation Mode : ",0
	change		BYTE "Do you want to change the mode(Y/N)? : ",0
	bye			BYTE "Bye!",0
	wantChange	BYTE 5 DUP(0)

	caseTable BYTE 1
		   DWORD AND_op
	EntrySize = ($ - caseTable )
		   BYTE 2
		   DWORD OR_op
		   BYTE 3
		   DWORD NOT_op
		   BYTE 4
		   DWORD XOR_op
		   BYTE 5
		   DWORD exitProgram
	NumberOfEntries = ($ - caseTable) / EntrySize

.code
main PROC
	Menu:
		   mov edx, OFFSET MenuPrompt
		   call WriteString
		   call Crlf
		   call Crlf
	getInput:
		   mov edx, OFFSET choose
		   call WriteString
		   call ReadInt
		   cmp al, 5
		   ja getInput
		   cmp ax, 1
		   jb getInput

		   call selectProcedure
		   jc quit
		   call Crlf
		   jmp Menu
	quit: exit
main ENDP

selectProcedure PROC
		   push ebx
		   push ecx
		   mov ebx, OFFSET caseTable
		   mov ecx, NumberOfEntries

	L1:	   cmp al, [ebx]
		   jne L2
		   call NEAR PTR [ebx + 1]
		   jmp L3

	L2:    add ebx, EntrySize
		   loop L1

	L3:    pop ecx
		   pop ebx
		   ret
selectProcedure ENDP

AND_op PROC
       pushad
       mov edx, OFFSET prompt1
       call WriteString
       call ReadHex
	   ;call dumpregs;;;;;;;
       mov ebx, eax
       mov edx, OFFSET prompt2
       call WriteString
       call ReadHex
       and eax, ebx
       mov edx, OFFSET resultAND
       call WriteString
       call WriteHex; ->changed
	   call Crlf
	   call Crlf
	   
	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET wantChange
			call ReadString	; Yes or No input
			call Crlf

			mov dl, wantChange[0]
			;call dumpregs;

			cmp dl, 'N'
			je AND_op

			cmp dl, 'Y'
			je main
		jmp change_loop
	   
       popad
       ret
AND_op ENDP

OR_op PROC
       pushad
       mov edx, OFFSET prompt1
       call WriteString
       call ReadHex
       mov ebx, eax
       mov edx, OFFSET prompt2
       call WriteString
       call ReadHex
       or eax, ebx
       mov edx, OFFSET resultOR
       call WriteString
       call WriteHex; ->changed
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET wantChange
			call ReadString	; Yes or No input
			call Crlf

			mov dl, wantChange[0]
			;call dumpregs;

			cmp dl, 'N'
			je OR_op

			cmp dl, 'Y'
			je main
		jmp change_loop

       popad
       ret
OR_op ENDP

NOT_op PROC
       pushad
       mov edx, OFFSET prompt1
       call WriteString
       call ReadHex
       not eax
       mov edx, OFFSET resultNOT
       call WriteString
       call WriteHex; ->changed
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET wantChange
			call ReadString	; Yes or No input
			call Crlf

			mov dl, wantChange[0]
			;call dumpregs;

			cmp dl, 'N'
			je NOT_op

			cmp dl, 'Y'
			je main
		jmp change_loop

       popad
       ret
NOT_op ENDP

XOR_op PROC
       pushad
       mov edx, OFFSET prompt1
       call WriteString
       call ReadHex
       mov ebx, eax
       mov edx, OFFSET prompt2
       call WriteString
       call ReadHex
       xor eax, ebx
       mov edx, OFFSET resultXOR
       call WriteString
       call WriteHex; ->changed
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET wantChange
			call ReadString	; Yes or No input
			call Crlf

			mov dl, wantChange[0]
			;call dumpregs;

			cmp dl, 'N'
			je XOR_op

			cmp dl, 'Y'
			je main
		jmp change_loop

       popad
       ret
XOR_op ENDP  

exitProgram PROC  
      mov edx, OFFSET bye
	  call WriteString
	  stc
      ret

exitProgram ENDP   

END main  