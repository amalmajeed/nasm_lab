;print all the digits upto a given digit.
section .data
    msg           : db "enter a number "
    msg2          : db 10
    len           : equ $-msg
    len2          : equ $-msg2
    num db '0'

section .bss
    n      : resb 1

section .text
    global _start
    _start :
            mov eax , 4
            mov ebx , 1
            mov ecx , msg
            mov edx , len
            int 80h

            mov eax , 3
            mov ebx , 0
            mov ecx , n
            mov edx , 1
            int 80h

            loop:
                mov eax , 4
                mov ebx , 1
                mov ecx , num   ; print the ASCII val
                mov edx , 2
                int 80h

                mov eax , 4
                mov ebx , 1
                mov ecx , msg2
                mov edx , len2
                int 80h

                sub byte[num] , 30h ;convert to hex
                sub byte[n]   , 30h   ;convert to hex for cmp
                mov ah        , byte[n]
                cmp ah        , byte[num]
                je exit
                inc byte[num]
                add byte[num] , 30h
                add byte[n]   , 30h
                jmp loop
            exit:
                mov eax , 1
                mov ebx , 0
                int 80h
