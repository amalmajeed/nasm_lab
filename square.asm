;To find the square of a single digit no

section .data 
    msg      : db "enter the no : "
    len      : equ $-msg
    msg2     : db "square is    : "
    len2     : equ $-msg2
    newline  : db 10
    nlen     : equ $-newline
section .bss
    num      : resb 1
    squ      : resb 2
section .txt
    global _start 
    _start:
            mov eax , 4
            mov ebx , 1
            mov ecx , msg
            mov edx , len
            int 80h

            mov eax , 3
            mov ebx , 0
            mov ecx , num
            mov edx , 1
            int 80h

            mov al , byte[num]
            sub al , 30h
            mov cl , al
            mov ch , 00
            mov ah , 00
            mul cx     ;ax and cx is multiplied
            mov cl , 10
            div cl     ;split into 2 seperate digits
            add ax        , 3030h
            mov word[squ] , ax

            mov eax , 4
            mov ebx , 1
            mov ecx , msg2
            mov edx , len2
            int 80h

            mov eax , 4
            mov ebx , 1
            mov ecx , squ
            mov edx , 2
            int 80h

            mov eax , 4
            mov ebx , 1
            mov ecx , newline
            mov edx , nlen
            int 80h
            ;EXIT
            mov eax , 1
            mov ebx , 0
            int 80h


