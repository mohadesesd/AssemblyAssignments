section .data
	data:  dq 3
  data2: dq 5
section .bss
  max resq 0
  min resq 0
section .text
	GLOBAL _start

_start:
	call GCD_Calculator

exit:
		mov rax,1
		mov rbx,0
		int 80h

GCD_Calculator:   ;calculate GCD using euclid method
	mov rax, [data]
  mov rbx ,[data2]
  euclid_method:
				mov     rdx, 0
        div     rbx
        mov     rax, rbx
        mov     rbx, rdx
        cmp    rbx, 0
        jnz     euclid_method
  mov rdx, rax
	ret
