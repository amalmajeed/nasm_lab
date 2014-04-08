; largest and smallest in an array
; smallest has some bug ! (need to fix it )
section .data
    msg  : db "enter size         : "
    len  : equ $-msg
    msg1 : db "enter the elements : -",10
    len1 : equ $-msg1
    msg2 : db "largest            : "
    len2 : equ $-msg2
    msg3 : db "smallest           : "
    len3 : equ $-msg3
    new  : db 10
section .bss
           array    resb   50
           count    resb   1
           count1   resb   1
           count2   resb   1
           no1             resb   1
           no2      resb   1
           large    resb   1
           small    resb   1
           temp     resb   1
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

section .text
global _start
    _start:
            disp msg         , len
            read no1         , 1
            read no2         , 1
            read temp        , 1
            mov cl           , byte[no1]
            mov ch           , byte[no2]
            sub cx           , 3030h
            mov al           , 10
            mul cl
            add al           , ch
            mov byte[count]  , al
            mov byte[count1] , al
            mov byte[count2] , al

            disp msg1        , len1
            mov esi          , array
            insert:
                    push esi
                    read no1        , 1
                    read no2        , 1
                    read temp       , 1
                    mov cl          , byte[no1]
                    mov ch          , byte[no2]
                    sub cx          , 3030h
                    mov al          , 10
                    mul cl
                    add al          , ch
                    mov ah          , 0
                    pop esi
                    mov byte[esi]   , al
                    inc esi
                    dec byte[count]
                    cmp byte[count] , 0
                    jne insert
            disp msg2  , len2
            mov esi    , array
            mov al     , byte[esi]  ;assume the largest
            largeloop:
                    inc esi
                    cmp al               , byte[esi]
                    jg next
                    movzx ax             , byte[esi]
                    next:
                        dec byte[count1]
                        cmp byte[count1],0
                        jne largeloop
            mov dl        , 10
            mov dh        , 00
            div dl
            add ax        , 3030h
            mov byte[no1] , al
            mov byte[no2] , ah
            disp no1      , 1
            disp no2      , 1
            disp new      , 1


            ;smallest
            disp msg3     , len3
            mov esi       , array
            mov al        , byte[esi]  ;assume the smallest
            smallloop:
                    inc esi
                    cmp al   , byte[esi]
                    jc snext
                    movzx ax , byte[esi]
                    snext:
                        dec byte[count2]
                        cmp byte[count2],0
                        jne smallloop
            mov dl        , 10
            mov dh        , 00
            div dl
            add ax        , 3030h
            mov byte[no1] , al
            mov byte[no2] , ah
            disp no1      , 1
            disp no2      , 1

            exit:
            disp new      , 1
            mov eax       , 1
            mov ebx       , 0
            int 80h





