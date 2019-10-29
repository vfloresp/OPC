TITLE Program Template          (InvStrBK02.asm)

; Este programa invierte un String.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
unaCade BYTE "Gabriel Garcia Marquez",0
tamCade DWORD LENGTHOF unaCade - 1

;Area de texto de impresion
impini BYTE "Cadena Inicial:  ",0
impfin BYTE "Cadena Invertida:  ",0


.CODE
main PROC

    mov EDX, OFFSET impini
    Call WriteString
    mov EDX, OFFSET unaCade
    Call WriteString
    Call Crlf
    
    ;Guardar en el stack el contenido del arreglo unaCade
    mov ESI,0
    .WHILE ESI < tamCade
        movzx ax, unaCade[ESI]
        push ax
        inc ESI
    .ENDW

    ;Recuperar del stack el contenido del arreglo unaCade
    mov ESI,0
    .WHILE ESI < tamCade
        pop ax
        mov unaCade[ESI],al
        inc ESI
    .ENDW

    mov EDX, OFFSET impfin
    Call WriteString
    mov EDX, OFFSET unaCade
    Call WriteString
    Call Crlf    


    exit
main ENDP

END main