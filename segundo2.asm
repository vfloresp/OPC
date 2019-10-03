TITLE *MASM Template	(segundo2.asm)*

; Descripcion:
; Segundo ejercicio en ensamblador.
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
uno    BYTE 1, 2
dos    WORD 3, 4
tres   DWORD 5, 6
cuatro BYTE "Hola", 0

.CODE
; Procedimiento principal
main PROC

    mov ESI, OFFSET uno
    mov ECX, 14
    mov EBX, TYPE uno
    call DumpMem   
    call CrLf

    mov EDX, OFFSET cuatro
    call WriteString
    call CrLf

    movzx EAX, uno+1
    movzx EBX, dos+2
    mov ECX, tres+4
    movzx EDX, cuatro+3
    call DumpRegs    ; solo ver EAX, EBX, ECX y EDX
    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main