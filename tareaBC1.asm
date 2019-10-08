TITLE *MASM Template	(mult.asm)*

; Descripcion:
; Ejercicio 1 Tarea BC
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
msg BYTE "Dato ", 0
res BYTE "El resultado R=", 0
resh BYTE  "El resultado Rh=", 0
adios BYTE "HASTA LA VISTA", 0
A  SDWORD 7
B  SDWORD ?
D  SDWORD -15
R  LABEL  SDWORD

.CODE
; Procedimiento principal
main PROC
    
    MOV EAX, A
    NEG EAX
    MOV EBX, 9
    IMUL EBX
    MOV A, EAX

    MOV EDX, OFFSET msg
    CALL WriteString
   
    CALL ReadInt
    CDQ
    MOV EBX, D
    IDIV EBX
    INC EAX
    SUB A, EAX
    ADD A, 100
    MOV EAX, A

    CALL CrLf
    
    ; ++++++++++++
    
    MOV EDX, OFFSET res
    CALL WriteString
    MOV EAX, A
    CALL WriteInt

    CALL CrLf

    MOV EDX, OFFSET resh
    CALL WriteString
    CALL WriteHex

    CALL CrLf
    CALL CrLf
    MOV EDX, OFFSET adios
    CALL WriteString


        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main