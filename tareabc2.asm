TITLE *MASM Template	(tareabc2.asm)*

; Descripcion:
; Inciso 2 TareaBC.
; 
; Fecha de entrega:
; 07-10-2019

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA

Svector WORD 2002h, 4004h, 6006h, 8008h
Cvector SWORD -2,-4,-6,-8

.CODE
; Procedimiento principal
main PROC
    mov EAX, 00000000h
    mov EBX, 00000000h
    mov ECX, 00000000h
    mov EDX, 00000000h

    mov AX, Svector
    mov BX, [Svector+2]
    mov CX, [Svector+4]
    mov DX, [Svector+6]

    call DumpRegs
    call CrLf

    mov AX, Cvector
    mov BX, [Cvector+2]
    mov CX, [Cvector+4]
    mov DX, [Cvector+6]

    call DumpRegs
    call CrLf

    mov EAX, 00000000h
    mov EBX, 00000000h
    mov ECX, 00000000h
    mov EDX, 00000000h

    mov AX, Svector
    mov BX, Cvector
    mul EBX; 

    call DumpRegs
    call CrLf

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main