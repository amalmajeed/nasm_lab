;Find the largest in an array of size 10

section .data
    msg1 : db 10,"largest :"
    len1 : equ $-msg1 
    msg2 : db "enter number "
    len2 : equ $-msg2
    new  : db 10
    lenn : equ $-new

;defining print macros 
%macro display 2
    mov eax , 4
    mov ebx , 1
    mov ecx , %1
    mov edx , %2
    int 80h
%endmacro
;defining read macro
%macro input 2
    mov eax , 3
    mov ebx , 0
    mov ecx , %1
    mov edx , %2
    int 80h
%endmacro

section .bss 
    num : resb 3
    lar : resb 5
section .txt
global _start
       _start:
            mov esi , num  ;offset in esi
            mov edi , 10   ;no of input
            nextnum:
                display msg2 , len2
                input esi    , 5
                add esi      , 5
                dec edi
                jnz nextnum
            mov esi , num ;offset in esi
            mov edi , 10 ;no of input
            loop:
                mov eax , [esi] ;assume the largest in eax
                jmp check
                next:
                add esi , 5
                mov ebx , [esi]
                cmp eax , ebx
                jl loop
                check:
                dec edi
                jnz next

            mov [lar]    , eax
            display msg1 , len1
            display lar  , 5
            display new  , lenn
            mov eax      , 1
            mov ebx      , 0
            int 80h

                

