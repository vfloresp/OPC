TITLE *MASM Template	(mult.asm)*

; Descripcion:
; Ejercicio for clase
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
msg BYTE "Dato ",0
n DWORD ?
res DWORD 0
aux DWORD 1
suma DWORD 1
adios BYTE "Resultado ",0


.CODE
; Procedimiento principal
main PROC
    

    MOV EDX, OFFSET msg
    CALL WriteString
   
    CALL ReadInt
    MOV EBX,EAX

inWhile:  
        CMP aux, EBX
        JA outWhile
        INC aux
        MOV EAX, suma
        ADD res, EAX
        ADD suma, 3 
        JMP inWhile
outWhile:  

    CALL CrLf
    
    ; ++++++++++++

    MOV EDX, OFFSET adios
    CALL WriteString

    MOV EAX, res
    CALL WriteInt

    CALL CrLf




        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main