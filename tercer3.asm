TITLE *MASM Template	(tercero3.asm)*

; Descripcion:
; Tercer ejercicio del ensamblador
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
mnsga    BYTE "OSAC",0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET mnsga
    call WriteString        ; estado inicial del string
    call CrLf

    mov AL, mnsga
    xchg AL, mnsga+1
    xchg AL, mnsga+2
    xchg AL, mnsga+3
    mov mnsga, AL

    mov EDX, OFFSET mnsga        ; estado final del string
    call WriteString
    call CrLf
    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main