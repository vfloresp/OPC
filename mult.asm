TITLE *MASM Template	(mult.asm)*

; Descripcion:
; Ejercicio 1 Tarea BC
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
A  SDWORD 7
B  LABEL  SDWORD
D  SDWORD -15
R  LABEL  SDWORD

.CODE
; Procedimiento principal
main PROC

    MOV EAX, A
    MOV EBX, -1
    MUL EBX
    call DumpRegs
   
    ; ++++++++++++

    ;mov EDX, OFFSET adios       
    ;call WriteString
    ;call CrLf
        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main