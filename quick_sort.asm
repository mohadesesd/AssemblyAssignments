;at the end for testing the sorted array just set the break point as print_each_element_of_array and then check the r15 each time
section .data
  array dq 10, 7, 8, 9, 1, 5
  len equ ($-array)/8

section .text
  global _start

_start:
  xor rax, rax
  push rax
  mov rax, len
  dec rax
  push rax
  mov rsi, array
  call quick_sort
  pop r14
  mov r13, 0
  print_each_element_of_array:
    cmp r13, len
    jge exit
    mov r15, [rsi + 8 * r13]
    inc r13
    jmp print_each_element_of_array
exit:
  mov rax, 60
  mov rdi, 0
  syscall
; [rbp+16] low
;[rbp + 24] high
quick_sort:
  enter 0, 0
  mov r8, [rbp + 16]
  cmp [rbp + 24], r8
  jnl return
  push qword [rbp + 24]
  push qword [rbp + 16]
  call partition
  pop r8
  pop r8
  sub rbx, 1
  push qword [rbp + 24]
  push rbx
  call quick_sort
  pop rbx
  pop r8
  inc rbx
  inc rbx
  push rbx
  push qword [rbp + 16]
  call quick_sort
  pop r8
  pop rbx
  return:
  leave
  ret 0

partition:
  enter 0, 0
  mov rbx, [rbp + 24]
  mov rdx, [rbp + 16]
  mov r9, [rsi + 8*rdx]
  mov r10, [rbp + 24]
  loop:
    cmp r10, rdx
    jnl no
    cmp [rsi + 8 * r10], r9
    jnl no_1
    mov r11, [rsi + 8 * rbx]
    mov r12, [rsi + 8 * r10]
    mov [rsi + 8 * r10], r11
    mov [rsi + 8 * rbx], r12

    inc rbx
    no_1:
    inc r10
    jmp loop
  no:
    mov r11, [rsi + 8 * rbx]
    mov r12, [rsi + 8 * rdx]
    mov [rsi + 8 * rdx], r11
    mov [rsi + 8 * rbx], r12
  leave
  ret 
