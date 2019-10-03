TITLE *MASM Template	(primer1.asm)*

; Descripcion:
; Mi primer programa.
; 
; Fecha de ultima modificacion:
; 01-oct-2019

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
mensaje BYTE 0dh,0ah,"Ejemplo de programa fuente MASM",0dh,0ah,0
mensMem BYTE 0dh,0ah,"Ejemplo de DumpMem",0dh,0ah,0
nl BYTE 0dh,0ah,0

uno DWORD 56h
dos DWORD 100h
tres DWORD 200h
cuatro DWORD ?

cinco BYTE 34
seis sWORD -271
siete SDWORD -7563

.CODE
; Procedimiento principal
main PROC
    call Clrscr

    mov edx,OFFSET mensaje
    call WriteString

    mov eax, 1000h
    mov ebx, 2000h
    mov ecx, 3000h
    call DumpRegs

    add eax, uno
    add ebx, dos
    call DumpRegs

    mov edx,OFFSET mensMem
    call WriteString

    add ecx, tres
    mov cuatro, ecx
    mov esi, OFFSET uno
    mov ecx, 4
    mov ebx, TYPE uno
    call DumpMem   

    call CrLf
    mov eax, siete
    call WriteInt

    mov edx,OFFSET nl
    call WriteString

    movsx eax, seis
    call WriteInt

    mov edx,OFFSET nl
    call WriteString
    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main