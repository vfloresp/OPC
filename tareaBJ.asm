TITLE Ejercicio ejer4BH2

; Descripcion:
; Tarea BJ
; Uso de arreglos
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
; Textos para la Consola
inicio BYTE "Dato n:", 0
dato1  BYTE "Teclee la ", 0
dato2  BYTE " temperatura: ",0 
res    BYTE "Minimo de las temperaturas: ",0
par    BYTE "P", 0
impar  BYTE "I",0
error  BYTE "ERROR por n<1 o n>10 "
adios Byte "Adios ",0


; Variables
min SDWORD 1000
n DWORD 0
temp SDWORD 0


.CODE
; Procedimiento principal
main PROC
    ;Lee el dato inicial y lo valida
    mov edx, OFFSET inicio
    call WriteString
    call ReadInt
    call crlf
    mov n, EAX
    mov EAX,1
    mov EBX, 10
    .IF (n<EAX) || (n>EBX)
        JMP err
    .ENDIF

    ;Ciclo para leer los datos
    mov EBX, 0
    .WHILE EBX<n
        inc EBX
        mov edx, OFFSET dato1
        call WriteString
        mov EAX, EBX
        call WriteInt
        mov edx, OFFSET dato2
        call WriteString
        call ReadInt
        ;Guarda el valor minimo
        .IF EAX<min
            mov min, EAX
        .ENDIF
        ;Guarda los valores en el arreglo

    .ENDW
    ;Imprime el arreglo con la paridad 

    ;Muestra temperatura minima
    mov edx, OFFSET res
    call WriteString
    mov EAX, min
    call WriteInt
    call crlf
    JMP fin
err: 
    mov edx, OFFSET error
    call WriteString 
    call crlf
    
fin:
    mov edx, OFFSET adios
    call WriteString 

    exit
main ENDP
END main