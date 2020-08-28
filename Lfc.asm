section .data
	data:  dq 12
  data2: dq 16
section .bss
  max resq 0
  min resq 0
section .text
	GLOBAL _start

_start:
	call LFC_Calculator

exit:
		mov rax,1
		mov rbx,0
		int 80h

LFC_Calculator: ;calculate LFC of two number using their GCd
	call GCD_Calculator
	mov rdx, 0
	mov rax, [data]
	mov rbx ,[data2]
	mul rbx
	div rcx
	mov rdx, rax
	ret

GCD_Calculator:
	mov rax, [data]
	mov rbx ,[data2]
	euclid_method:
			mov     rdx, 0
			div     rbx
			mov     rax, rbx
			mov     rbx, rdx
			cmp     rbx, 0
			jnz     euclid_method
	mov rcx, rax
	ret
