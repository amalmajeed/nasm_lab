;Cube of a 2 digit number (limitation of max 5 digit result)
section .data
    msg  : db "enter the number (2digit) : "
    len  : equ $-msg
    msg1 : db "its cube is "
    len1 : equ $-msg1
    new  : db 10,13,""
    lnew : equ $-new

section .bss 
           no1     resb   1
           no2     resb   1
           temp    resb   1
           count   resb   1
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

section .text
global _start
    _start:
            disp msg  , len
            read no1  , 1
            read no2  , 1
            disp new  , lnew
            disp msg1 , len1

            mov cl    , byte[no1]  ;tens place
            mov ch    , byte[no2]  ;ones place
            sub cx    , 3030h      ;convert to hex
            mov al    , 10
            mul cl
            add al    , ch
            mov cx    , ax      ;cx contains the 2 digit number

            ;cubing
            mul cx
            mul cx

            ;displaying the result
            push 29h
            mov byte[count],5    ;16bit register can hold upto 65536 
            loop:
                mov ebx , 10
                mov edx , 0     ;16bit div dx will have remainder and ax the quotient
                div bx
                add dl  , 30h
                push dx
                sub byte[count],1
                cmp byte[count],0
                jne loop

            mov eax,0
            pop ax
            print:
                mov byte[temp] , al
                disp temp      , 1
                mov eax        , 0
                pop ax
                cmp al         , 29h
                jne print
            
            exit:
                disp new , lnew
                mov eax  , 1
                mov ebx  , 0
                int 80h
