section .data
    hello: db 'Hello World',10 
    hellolen : equ $-hello ;length of 'Hello World' string

section .text
    global _start

_start:
        mov eax,4      ;sys call for write
        mov ebx,1      ;file descriptor 1 - standard output
        mov ecx,hello  ;offset of hello as the 2nd arg
        mov edx,hellolen
        int 80h        
        
        mov eax,1      ;sys call for exit
        mov ebx,0
        int 80h
