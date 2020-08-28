section .data
	data:  dq 13
	newLineC: db 0xA, 0xD
	yes: db "It's a Prime Number"
	lenyes: equ $-yes
	no: db  "It isn't a Prime Number"
	lenno: equ $-no

section .text
	GLOBAL _start

INC:
		inc r9
		jmp return

Yes:
		mov ecx, yes
		mov edx, lenyes
		mov eax, 4
		mov ebx, 1
		int 80h
		call newLine
		jmp exit

No:
		mov ecx, no
		mov edx, lenno
		mov eax, 4
		mov ebx, 1
		int 80h
		call newLine
		jmp exit

newLine:
		mov ecx, newLineC
		mov edx, 2
		mov eax, 4
		mov ebx, 1
		int 80h
		ret

_start:
	call Is_Prime

exit:
		mov rax,1
		mov rbx,0
		int 80h

Is_Prime:  ;count the number of factors of number and compare it with 2 to find out if it is a prime number or not
	mov rax, [data]
  mov rbx, rax
  mov r8, 1
	mov r9, 0
  mov r10, 2
  cmp rax, 1
  je No
	loop:
    mov rdx, 0
		div r8
		cmp rdx, 0
    je INC
    return:
      inc r8
      mov rax, rbx
      cmp rax, r8
		  jne loop
  inc r9
  cmp r9, r10
  je Yes
  call No
	ret
