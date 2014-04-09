;sorting in descending order
section .data
    msg           : db "Enter size of the array(0<n<10) : "
    len           : equ $-msg
    msg1          : db "Enter the array(a[i]<10) : ",10
    len1          : equ $-msg1
    msg2          : db "The sorted array is         : ",10
    len2          : equ $-msg2
    new           : db 10

section .bss
    num    resb   10
    temp   resb   1
    siz    resb   1

section .text
global _start:
_start:

%macro disp 2
    mov eax       , 4
    mov ebx       , 0
    mov ecx       , %1
    mov edx       , %2
    int 80h
%endmacro

%macro read 2
    mov eax       , 3
    mov ebx       , 0
    mov ecx       , %1
    mov edx       , %2
    int 80h
%endmacro

disp msg      , len
read siz      , 2
disp msg1     , len1

mov cl        , byte[siz]
sub cl        , 30h
mov ch        , 00
mov esi       , num
back2:
    push esi
    push cx
    read temp     , 2
    pop cx
    pop esi
    mov al        , byte[temp]
    mov byte[esi] , al
    inc esi
    dec cl
    cmp cl        , 00
    jg back2


disp msg2,len2

mov cl,00
mov ch,00
mov dl,byte[siz]
dec dl                    ;n-1 in dl
loop:
    mov cl,dl
    mov esi,num
loop1:                     ;logic of bubble sort complexity : n^2
    mov al,byte[esi]
    inc esi
    mov bl,byte[esi]
    cmp al,bl
    jnc fwd
    mov byte[esi],al      
    dec esi
    mov byte[esi],bl
    inc esi
    fwd:
        dec cl
        cmp cl,00h
        jg loop1
        dec dl
        cmp dl,00h
        jg loop

mov bl,byte[siz]
mov bh,00h
mov esi,num
loop2:
    mov al,byte[esi]
    mov byte[temp],al
    inc esi
    push esi
    push bx
    disp temp,1
    disp new,1
    pop bx
    pop esi
    dec bl
    cmp bl,00h
    jg loop2

exit:
    mov eax  , 1
    mov ebx  , 0
    int 80h








