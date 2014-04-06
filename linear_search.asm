;perform a linear search in an array of numbers

section .data
    msg  : db "enter the size of the array      : ",10
    len  : equ $-msg
    msg1 : db "enter the array                  : ",10
    len1 : equ $-msg1
    msg2 : db "enter the element to be searched : "
    len2 : equ $-msg2
    msg3 : db "found at                         : "
    len3 : equ $-msg3
    msg4 : db "not found ",10,13
    len4 : equ $-msg4
    new  : db "",10,13
    lnew : equ $-new

%macro disp 2
    mov eax   , 4
    mov ebx   , 1
    mov ecx   , %1
    mov edx   , %2
    int 80h
%endmacro
%macro read 2
    mov eax   , 3
    mov ebx   , 0
    mov ecx   , %1
    mov edx   , %2
    int 80h
%endmacro

section .bss
    num resb 10
    key resb 1
    temp resb 1
    size resb 1

section .txt
global _start
    _start:
            disp msg  , len
            read size , 2
            disp msg1 , len1

            mov cl    , byte[size]
            sub cl    , 30h
            mov ch    , 00
            mov esi   , num      ;esi pointing to array

            insert: 
                push esi
                push cx
                read temp  , 2
                pop cx
                pop esi
                mov al , byte[temp]
                mov byte[esi], al
                inc esi
                dec cl
                cmp cl        , 00
                jg insert

            disp msg2 , len2
            read key  , 2
            mov bl    , byte[key]
            sub bl    , 30h

            mov cl    , 00             ;count for comparing
            mov ch    , 00
            mov dl    , byte[size]
            mov esi   , num

            search: 
                mov al    , byte[esi]
                sub al    , 30h
                cmp al    , bl
                je found
                inc cl
                inc esi
                cmp dl    , cl
                ja search
                disp msg4 , len4
                jmp exit
            
            found:
                push cx
                disp msg3      , len3
                pop cx
                inc cl
                add cl         , 30h
                mov byte[temp] , cl
                disp temp      , 1
                disp new       , lnew
            exit:
                mov eax , 1
                mov ebx , 0
                int 80h

