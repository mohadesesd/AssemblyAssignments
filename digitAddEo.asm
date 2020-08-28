section .data
	data:  dq 1234
section .text
	GLOBAL _start

_start:
	call digitAddEo

exit:
		mov rax,1
		mov rbx,0
		int 80h

digitAddEo: ;find sum of even positions and odd position by setting r9 flag. when r9 is zero we are in even position else we are in odd position
	mov rax, [data]
  mov r8, 10
	mov r10, 0
	mov r11, 0
	mov r9, 0
	loop:
	  mov rdx, 0
		div r8
		cmp r9, 1
		je odd
		even:
			add r10, rdx
			mov r9, 1
		return:
			cmp rax, 0
			jne loop
	mov rbx, r10
	mov rdx, r11
  jmp exit
	odd:
		add r11, rdx
		mov r9, 0
		jmp return
