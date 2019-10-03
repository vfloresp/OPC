TITLE *MASM Template	(mult.asm)*

; Descripcion:
; Uso de Multiplicacion
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
adios    BYTE "ADIOS", 0

.CODE
; Procedimiento principal
main PROC

    mov EAX, 0
    mov EBX, 0
    mov EDX, 0
    mov AX, 1234h
    mov BX, 100h
    mul BX          ; DX:AX
    call DumpRegs
   
    ; ++++++++++++

    mov EDX, OFFSET adios        ; despliega "ADIOS"
    call WriteString
    call CrLf
        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main