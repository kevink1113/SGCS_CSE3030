TITLE TEST code : Arithmetic Operations

INCLUDE irvine32.inc

.data
INCLUDE hw1_1.inc

.code
main PROC
	;----------eval1-------------
	mov eax, val1
	add eax, val1
	add eax, val1	; 3*val1
	add eax, eax	; 6*val1
	add eax, eax	; 12*val1

	mov ecx, val2 ; ecx := val2
	add ecx, ecx ; ecx := 2*val2
	add ecx, val2 ; ecx := 3*val2
	add ecx, ecx ; ecx := 6*val2
	add ecx, ecx ; ecx := 12*val2
	add ecx, val2 ; ecx := 13*val2
	add ecx, ecx ; ecx := 26*val2
	add ecx, ecx ; ecx := 52*val2
	sub ecx, val2 ; ecx := 51*val2

	add eax, ecx ; eax := 12*val1+51*val2

	mov ebx, val4 ; ebx := val4
	sub ebx, val3 ; ebx := val4-val3
	mov ecx, ebx ; ecx := val4-val3
	add ebx, ebx ; ebx := 2*(val4-val3)
	add ebx, ebx ; ebx := 4*(val4-val3)
	add ebx, ecx ; ebx := 5*(val4-val3)

	sub eax, ebx ; eax := 12*val1 + 51*val2 - 5*(val4-val3)

	call DumpRegs; eax==431-> SUCCESS!! (1AF)

	;----------eval2-------------
	mov eax, val1 ; eax=val1
	add eax, eax ; eax=2*val1
	add eax, eax ; eax=4*val1
	add eax, eax ; eax=8*val1
	sub eax, val1 ; eax=7*val1
	add eax, eax ; eax=14*val1

	mov ebx, val2 ; ebx=val2
	add ebx, ebx ; ebx=2*val2
	add ebx, ebx ; ebx=4*val2
	add ebx, ebx ; ebx=8*val2
	sub ebx, val2 ; ebx=7*val2
	add ebx, ebx ; ebx=14*val2
	sub ebx, val2 ; ebx=13*val2
	add eax, ebx ; eax=14*val1 + 13*val2

	mov ebx, val3 ; ebx=val3
	sub ebx, val4 ; ebx=val3-val4
	mov ecx, ebx ; ecx=val3-val4
	add ebx, ebx ; ebx=2*(val3-val4)
	add ebx, ebx ; ebx=4*(val3-val4)
	add ebx, ebx ; ebx=8*(val3-val4)
	add ebx, ebx ; ebx=16*(val3-val4)
	sub ebx, ecx ; ebx=15*(val3-val4)
	
	sub eax, ebx ; eax=14*val1 + 13*val2 - 15*(val3-val4)
	
	call DumpRegs ; eax== -3383-> SUCCESS!! (FFFFF2C9)
	
	;----------eval3-------------
	mov eax, val1 ; eax=val1
	add eax, val2 ; eax=val1+val2
	add eax, val3 ; eax=val1+val2+val3
	mov ebx, eax ; ebx=val1+val2+val3
	add eax, eax ; eax=2*(val1+val2+val3)
	add eax, ebx ; eax=3*(val1+val2+val3)
	
	mov ebx, val1 ; ebx=val1
	add ebx, ebx ; ebx=2*val1
	add ebx, ebx ; ebx=4*val1
	mov ecx, ebx ; ecx=4*val1
	add ebx, ebx ; ebx=8*val1
	add ebx, ebx ; ebx=16*val1
	add ebx, ecx ; ebx=20*val1

	sub eax, ebx ; eax=3*(val1+val2+val3)-20*val1


	mov ebx, val2 ; ebx=val2;
	add ebx, val4 ; ebx=val2+val4
	add ebx, val4 ; ebx=val2+2*val4
	add ebx, val4 ; ebx=val2+3*val4
	
	sub eax, ebx ; eax=3*(val1 + val2 + val3) - 20*val1 - (val2 + 3*val4)

	call DumpRegs ; eax== 494-> SUCCESS!! (1EE)

	exit
main ENDP
END main