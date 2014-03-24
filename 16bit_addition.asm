;Addition of two 2 digit no's
section .data
    msg      : db "Enter a 16 bit number : "
    len      : equ $-msg
    msg1     : db "The sum is            : "
    len1     : equ $-msg1
    newline  : db 10
    lenn     : equ $-newline

section .bss
    num1     : resb 2
    num2     : resb 2
    temp1    : resb 1
    temp2    : resb 1


section .text

global _start
_start:
    mov eax    , 4
    mov ebx    , 1
    mov ecx    , msg
    mov edx    , len
    int 80h

    mov eax    , 3
    mov ebx    , 0
    mov ecx    , num1
    mov edx    , 3           ; read the next 3 bytes
    int 80h

    mov eax    , 4
    mov ebx    , 1
    mov ecx    , msg
    mov edx    , len
    int 80h

    mov eax    , 3
    mov ebx    , 0
    mov ecx    , num2
    mov edx    , 3
    int 80h

    mov eax    , 4
    mov ebx    , 1
    mov ecx    , msg1
    mov edx    , len1
    int 80h

mov cl , byte[num1]       ;cl will have the tens place digit
mov ch , byte[num1+1]     ;ch will have the ones place digit
mov bl , byte[num2]
mov bh , byte[num2+1]
sub cx , 3030h            ;convert from ASCII to hex
sub bx , 3030h
mov al , 10
mul cl
add al , ch
mov dl , al
mov al , 10
mul bl
add al , bh
add al , dl
mov cl , 10
div cl                  ;split into 2 seperate digits    
add ax          , 3030h            ;convert back to ASCII
mov byte[temp1] , al
mov byte[temp2] , ah

    mov eax , 4
    mov ebx , 1
    mov ecx , temp1
    mov edx , 1
    int 80h

    mov eax , 4
    mov ebx , 1
    mov ecx , temp2
    mov edx , 1
    int 80h

    mov eax , 4
    mov ebx , 1
    mov ecx , newline
    mov edx , lenn
    int 80h

    mov eax , 1
    mov ebx , 0
    int 80h




