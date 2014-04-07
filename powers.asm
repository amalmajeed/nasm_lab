;calculate x^y 
section .data
    msg  : db "enter x : "
    len  : equ $-msg
    msg1 : db "enter y : "
    len1 : equ $-msg1
    new  : db 10
    msg3 : db "x^y     : "
    len3 : equ $-msg3
section .bss
           no1     resb   1
           no2     resb   1
           ans     resb   1
           temp    resb   1
           x       resb   1
           y       resb   1
           count   resb   1
;display macro
%macro disp 2
    mov eax   , 4
    mov ebx   , 1
    mov ecx   , %1
    mov edx   , %2
    int 80h
%endmacro
;read macro
%macro read 2
    mov eax   , 3
    mov ebx   , 0
    mov ecx   , %1
    mov edx   , %2
    int 80h
%endmacro

section .txt
global _start
    _start:
            ;read x
            disp msg    , len
            read no1    , 1
            read no2    , 1
            read temp   , 1
            mov cl      , byte[no1]
            mov ch      , byte[no2]
            sub cx      , 3030h
            mov al      , 10
            mul cl
            add al      , ch
            mov byte[x] , al
            ;disp new,1
            ;read y
            disp msg1   , len1
            read no1    , 1
            read no2    , 1
            read temp   , 1
            mov cl      , byte[no1]
            mov ch      , byte[no2]
            sub cx      , 3030h
            mov al      , 10
            mul cl
            add al      , ch
            mov byte[y] , al
            ;disp new   , 1
            ;calculating part !
            disp msg3 , len3
            movzx ecx , byte[y]
            movzx eax , byte[x]
            mov ebx   , eax
            loop:
                mul ebx
                dec ecx
                cmp ecx,00
                jne loop
            div ebx
            push 29h
            mov byte[count],9 ;upto 9 digits in ans
            loop1:
                    mov ebx         , 10
                    mov edx         , 0
                    div bx
                    add dl          , 30h ;remainder in dx
                    push dx
                    dec byte[count]
                    cmp byte[count] , 0
                    jne loop1
            mov eax,0
            pop ax
            print:
                mov byte[ans] , al
                disp ans      , 1
                mov eax       , 0
                pop ax
                cmp al        , 29h
                jne print
            exit:
                disp new      , 1
                mov eax       , 1
                mov ebx       , 0
                int 80h



