;factorial of a number 
section .data
    msg  : db "enter the no (n<9) : "
    len  : equ $-msg
    msg1 : db "its factorial is   : "
    len1 : equ $-msg1
    new  : db 10
section .bss
           no1     resb   1
           no2     resb   1
           ans     resb   1
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

section .txt
global _start
_start :
        disp msg      , len
        read no1      , 1
        read no2      , 1
        disp new      , 1
        disp msg1     , len1
        mov cl        , byte[no1]
        mov ch        , byte[no2]
        sub cx        , 3030h
        mov al        , 10
        mul cl
        add al        , ch
        mov byte[no1] , al

        cmp ax        , 00
        jne next
        jmp ans10

        next : 
                cmp ax,01
                jne findfact
        ans10  :
                mov bx        , 1
                mov byte[ans] , bl
                add byte[ans] , 30h
                disp ans      , 1
                jmp exit
        findfact:
                movzx ecx , byte[no1] ;store the number in ecx
                mov eax   , 1
                fact:
                    mul ecx
                    dec ecx
                    cmp ecx  , 01
                    jge fact
        print:
                push 29h
                mov byte[count],5      ;display upto 5digits
                loop:
                    mov ebx,10
                    mov edx,0
                    div bx       ;eax contains the factorial
                    add dl,30h   ;the dx will contain the remainder
                    push dx
                    dec byte[count]
                    cmp byte[count],0
                    jne loop
                mov eax,0
                pop ax
                print1:
                        mov byte[no1] , al
                        disp no1      , 1
                        mov eax       , 0
                        pop ax
                        cmp al        , 29h
                        jne print1
        exit:
              disp new , 1
              mov eax  , 1
              mov ebx  , 0
              int 80h
                



