section .data
	data:  dq 1278
section .text
	GLOBAL _start

_start:
	call digitAdd

exit:
		mov rax,1
		mov rbx,0
		int 80h

digitAdd: ;find each of digits by division by 10 each time
	mov rax, [data]
  mov r8, 10
	mov rbx, 0
	loop:
	  mov rdx, 0
		div r8
		add rbx, rdx
		cmp rax, 0
		jne loop
	mov rdx, rbx
	ret
