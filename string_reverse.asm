;reverse a string
section .data
    msg  : db "enter string   : "
    len  : equ $-msg
    msg1 : db "the reverse is : "
    len1 : equ $-msg1
    new  : db 10
section .bss
           string   resb   20
           char     resb   1
           count    resb   1
;display macro
%macro disp 2
    mov eax , 4
    mov ebx , 1
    mov ecx , %1
    mov edx , %2
    int 80h
%endmacro
;read macro
%macro read 2
    mov eax , 3
    mov ebx , 0
    mov ecx , %1
    mov edx , %2
    int 80h
%endmacro

section .txt
global _start:
    _start:
            ;read the string
            disp msg    , len
            read string , '\n'
            ;display
            disp new    , 1
            disp msg1   , len1
            disp new    , 1
            push 29h
            mov esi     , string
            loop:
                mov al  , byte[esi]
                mov ah  , 00
                push ax
                inc esi
                inc byte[count]
                cmp byte[count],100
                jne loop
            mov ax,00
            pop ax
            printrev:
                mov byte[char] , al
                disp char      , 1
                pop ax
                cmp ax         , 29h
                jne printrev
            exit:
                disp new , 1
                mov eax  , 1
                mov ebx  , 0
                int 80h

