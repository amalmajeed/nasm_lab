;generating fibonacci series upto a limit
section .data
    msg    : db "enter the limit( 3<n<12 & 2digit-format ) : "
    len    : equ $-msg
    msg1   : db "series ->"
    len1   : equ $-msg1
    new    : db " ",10,13
    lnew   : equ $-new
    first  : db "00"
    second : db "01"

section .bss
           count   resb   1
           third   resb   4
           no1     resb   1
           no2     resb   1
           temp    resb   1
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
        disp msg , len
        read no1 , 1
        read no2 , 1
        mov ah   , 00
        mov cl   , byte[no1]
        mov ch   , byte[no2]
        sub cx   , 3030h
        mov al   , 10
        mul cl
        add al   , ch
        mov byte[count],al

        
        disp msg1       , len1
        disp new        , lnew
        disp first      , 2
        disp new        , lnew
        disp second     , 2
        disp new        , lnew
        disp second     , 2
        sub byte[count] , 3     ;the first , second & third printed
        disp new , lnew

        mov ax   , 01
        push ax
        push ax
        fib:
            pop bx
            pop ax
            add ax  , bx
            push bx
            push ax
            mov ah  , 00
            mov dl  , 10
            div dl
            add ax  , 3030h
            mov byte[no1],al
            mov byte[no2],ah
            disp no1        , 1
            disp no2        , 1
            disp new        , lnew
            dec byte[count]
            mov al,byte[count]
            cmp al,00
            jne fib
        exit:
        disp new , lnew
        mov eax  , 1
        mov ebx  , 0
        int 80h
            



        

