section .data
	data:  dq 6
  newLineC: db 0xA, 0xD
	yes: db "It's a Complete Number"
	lenyes: equ $-yes
	no: db  "It isn't a Complete Number"
	lenno: equ $-no

section .bss
    numr  resb  16

section .text
	GLOBAL _start

Sum:
			add r9, r8
			jmp return

Yes:
			  mov ecx, yes
				mov edx, lenyes
				mov eax, 4
				mov ebx, 1
				int 80h
				call newLine
				jmp print_all_factors

No:
			mov ecx, no
			mov edx, lenno
			mov eax, 4
			mov ebx, 1
			int 80h
			call newLine
			jmp exit

print_all_factors: ;find the factors and print them by the functions we used in presentation for converting number to string that are: numStr, nAgain, cAgain
			mov rax, [data]
			mov r8, 1
			loop2:
				xor rdx, rdx
				div r8
				cmp rdx, 0
				je print_factor
				continue:
					inc r8
					xor rax, rax
					mov rax, [data]
					cmp rax, r8
					jne loop2
				jmp exit

print_factor:
				mov rax, r8
				call numStr
				mov ecx, numr
				mov edx, 16
				mov eax, 4
				mov ebx, 1
				int 80h
				call newLine
				jmp continue

numStr:
			sub rdx, rdx
			mov rbx, 10
			sub rcx, rcx

nAgain:
			cmp rax, 9
			jle cEnd
			div rbx
			push dx
			inc cx
			sub rdx, rdx
			jmp nAgain

cEnd:
			mov rsi, numr

cAgain:
			add al, 0x30
			mov [rsi], al
			inc rsi
			dec cx
			jl nEnd
			pop ax
			jmp cAgain

nEnd:
			 ret

newLine:
			mov ecx, newLineC
			mov edx, 2
			mov eax, 4
			mov ebx, 1
			int 80h
			ret

_start:
	call Is_Complete

exit:
		mov rax,1
		mov rbx,0
		int 80h

Is_Complete: ;find sum of factors of a number and compare it with the number to find out if it is complete or not
		mov rax, [data]
		mov rbx, rax
		mov r8, 1
		mov r9, 0
		mov r10, rax
		cmp rax, 1
		je No
		loop1:
			xor rdx, rdx
			div r8
			cmp rdx, 0
			je Sum
			return:
			    inc r8
			    mov rax, rbx
					cmp rax, r8
				  jne loop1
		cmp r9, r10
		je Yes
		call No
