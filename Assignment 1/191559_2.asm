TITLE Assembly Programming HW1_2

INCLUDE irvine32.inc

.data
INCLUDE hw1_2.inc

.code
main PROC
	mov eax, 0
	mov al, [var1+3]
	sub al, '0' ; character
	;----------first----------

	mov ebx, 0
	mov bl, [var1+2]
	sub bl, '0' ; ebx = val
	mov ecx, ebx ; ecx = val
	add ebx, ebx ; ebx = 2*val
	add ebx, ebx ; ebx = 4*val
	add ebx, ebx ; ebx = 8*val
	sub ebx, ecx ; ebx = 7*val
	add eax, ebx
	;----------second----------

	mov ebx, 0
	mov bl, [var1+1]
	sub bl, '0' ; ebx=val
	mov ecx, ebx ; ecx=val
	add ebx, ebx ; ebx=2*val
	add ebx, ebx ; ebx=4*val
	add ebx, ebx ; ebx=8*val
	sub ebx, ecx ; ebx=7*val
   
	mov ecx, ebx ; ecx=7*val
	add ebx, ebx ; ebx=14*val
	add ebx, ebx ; ebx=28*val
	add ebx, ebx ; ebx=56*val
	sub ebx, ecx ; ebx=49*val
	add eax, ebx
	;----------third----------
	
	mov ebx, 0
	mov bl, [var1]
	sub bl, '0' ; ebx=val
	mov ecx, ebx ; ecx=val
	add ebx, ebx ; ebx=2*val
	add ebx, ebx ; ebx=4*val
	add ebx, ebx ; ebx=8*val
	sub ebx, ecx ; ebx=7*val
	mov ecx, ebx ; ecx=7*val
	add ebx, ebx ; ebx=14*val
	add ebx, ebx ; ebx=28*val
	add ebx, ebx ; ebx=56*val
	sub ebx, ecx ; ebx=49*val
	mov ecx, ebx ; ecx=49*val
	add ebx, ebx ; ebx=98*val
	add ebx, ebx ; ebx=196*val
	add ebx, ebx ; ebx=392*val
	sub ebx, ecx ; ebx=343*val (7^3)
	add eax, ebx
	;----------fourth----------

	call DumpRegs

	exit
main ENDP
END main