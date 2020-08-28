section .data
	data:   dq 0x123

section .text
	GLOBAL _start

_start:
	mov rax, [data]
	call BCD_To_BIN

exit:
		mov rax,1
		mov rbx,0
		int 80h

BCD_To_BIN:
	and rax, 0xF00 ;to calculate most significant digit
									;(256 in hex(BCD) = 100 in decimal ,
									;so we should use 64 + 32 + 4 to reach 100
									;,and we can reach these numbers by division 256 by 2(right shift)
									;,and add 64 and 32 and 4 to reach 100 the same thing we did in the presentation 7 for 2 digit BCD number)
	shr rax, 1
	shr rax, 1
	mov r8, rax
	shr rax, 1
	mov r9, rax
	shr rax, 1
	shr rax, 1
	shr rax, 1
	mov r10, rax
	mov rax, r8
	add rax, r9
	add rax, r10
	mov r8, rax
	mov rax, [data]
	and rax, 0x0F0 ;to calculate middle digit
									;(16 in hex(BCD)is same as 10 in decimal)
									; we should use 8 + 2 to reach 10
	shr rax, 1
	mov r9, rax
	shr rax, 1
	shr rax, 1
	mov r10, rax
	mov rax, r9
	add rax, r10
	mov r9, rax
	mov rax, [data]
	and rax, 0x00F ; to calculate least significant digit
									; 1 in hex is same as 1 in decimal
	add rax, r9
	add rax, r8
	ret
