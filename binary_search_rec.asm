section .data
    array dq 1, 2, 3, 4, 5, 10, 11, 12, 14, 15, 90
    len equ ($-array)/8
    key dq 11
    index dq -1


section .text
    global _start

_start:

    mov rax, len
    dec rax
    push rax ;high

    mov rax, 0
    push rax ;low

    mov rax, [key]
    push rax ;key

    mov rsi, array

    call binary_search

exit:
    mov ebx, 0
    mov eax, 1
    int 80h

binary_search:
    enter 8, 0
    mov rax, [rbp + 32]
    mov rbx, [rbp + 24]
    mov rcx, [rbp + 16]
if:
    cmp rbx, rax
    jle else
    leave
    ret 24

else:
    sub rax, rbx
    mov r11, 1
    cmp rax, r11
    mov r10, 2
    div r10
    add rax, rbx ;mid
    mov r8, rax
    mov rax, [rbp + 32]
    mov [rbp - 8], r8
    cmp rcx, [rsi + 8 * r8]
    je equal_to_mid
    jg right_side_of_array
    jl left_side_of_array
    leave
    ret 24

equal_to_mid:
    mov [index], r8
    leave
    ret 24

left_side_of_array:
    dec r8
    push r8
    push rbx
    push rcx

    call binary_search
    leave
    ret 24

right_side_of_array:
    inc r8
    push rax
    push r8
    push rcx

    call binary_search
    leave
    ret 24
