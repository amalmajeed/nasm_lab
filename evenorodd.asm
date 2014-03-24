;find if the given 2digit no is either odd or even
section .data
    msg1 : db 10,"enter 2-digit number"
    len  : equ $-msg1
    e    : db 10,"the number is even"
    le   : equ $-e
    o    : db 10,"the number is odd"
    lo   : equ $-o
    new  : db 10
    lenn : equ $-new
;print macro
%macro display 2
    mov eax , 4
    mov ebx , 1
    mov ecx , %1
    mov edx , %2
    int 80h
%endmacro
section .bss
    n1 : resb 2
section .txt
    global _start
    _start: 
            display msg1,len
            
            mov eax , 3
            mov ebx , 0
            mov ecx , n1
            mov edx , 2
            int 80h

            display n1,2
            
            mov al , byte[n1+1]
            sub ax , 30h
            mov bl , 2
            div bl    ;Ah=remainder , al=quotient
            cmp ah,0
            jne odd;if zf=0
            even:
                display e , le
                jmp exit
            odd:
                display o , lo
            exit:
            display new , lenn
            mov eax     , 1
            mov ebx     , 0
            int 80h
            

