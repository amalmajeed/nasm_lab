section .data
    msg      : db "enter the size of the array : "
    len      : equ $-msg
    msg1     : db "elements of the array       : -",10
    len1     : equ $-msg1
    msg2     : db "array sum = "
    len2     : equ $-msg2
    msg3     : db "array average ="
    len3     : equ $-msg3
    new      : db "",10,13
    lnew     : equ $-new
section .bss
           sum     resb   1
           sum1    resb   1
           sum2    resb   1
           avg     resb   1
           size    resb   1
           count   resb   1
           array   resb   10
           temp    resb   1

;macros to display
%macro disp 2
    mov eax    , 4
    mov ebx    , 1
    mov ecx    , %1
    mov edx    , %2
    int 80h
%endmacro
;macro to read
%macro read 2
    mov eax    , 3
    mov ebx    , 0
    mov ecx    , %1
    mov edx    , %2
    int 80h
%endmacro

section .txt
global _start
    _start:
            disp msg      , len
            read size     , 2
            disp msg1     , len1

            mov cl        , byte[size]
            sub cl        , 30h           ;keeping the n for the loop
            mov ch        , 00
            mov esi       , array
            mov byte[sum] , 00
            insert:
                    push esi
                    push cx
                    read temp , 2
                    pop cx
                    pop esi
                    mov al    , byte[temp]
                    sub al    , 30h
                    add byte[sum], al
                    mov byte[esi],al
                    inc esi
                    dec cl
                    cmp cl    , 00
                    jg insert
            mov al , byte[sum]
            mov ah , 00
            mov cl , 10
            div cl
            add ax , 3030h
            mov byte[sum1] , al
            mov byte[sum2] , ah
            disp msg2      , len2
            disp sum1     , 1
            disp sum2     , 1
            mov cl        , byte[size]
            sub cl        , 30h
            mov al        , byte[sum]
            div cl
            add ax        , 3030h
            mov byte[avg] , al
            disp new      , lnew
            disp msg3     , len3
            disp avg      , 1
            disp new      , lnew
            exit:
                mov eax , 1
                mov ebx , 0
                int 80h

