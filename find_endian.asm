;Find if the system uses big-endian or little-endian memory management 
section .data
    big       : db "arch is Big-Endian ",10,13
    lit       : db "arch is Little-Endian",10,13
    blen      : equ $-big
    llen      : equ $-lit

section .text
global _start
_start:
        mov eax     , 0xffff0000
        push eax
        pop ax
        pop bx
        cmp bx      , 0xffff
        je little

        bigend :
            mov eax , 4
            mov ebx , 1
            mov ecx , big
            mov edx , blen
            int 80h
            jmp end
        little:
            mov eax , 4
            mov ebx , 1
            mov ecx , lit
            mov edx , llen
            int 80h
        end:
            mov eax , 1
            mov ebx , 0
            int 80h

             

