TITLE Ejercicio BM01


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
error  BYTE "ERROR por n<1 o n>10 "
adios Byte "Adios ",0
intercambios BYTE "Total de intercambios: ",0


; Variables
min SDWORD 1000
n DWORD 0
nDec DWORD 0
temp SDWORD 0
array SDWORD 10 dup(?)
cont DWORD 0

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
    mov ECX, 0
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
        mov array[ECX], EAX
        add ECX, TYPE array
    .ENDW


    ;Ordenamiento seleccion directa
    mov EAX, n
    mov nDec, EAX
    dec nDec
    mov EAX, TYPE array
    mul n
    mov n, EAX
    mul nDec
    mov nDec, EAX
    mov EBX, 0
    .WHILE EBX < nDec
        mov ECX, EBX
        add ECX, TYPE array
        .WHILE ECX < n
            mov EAX, array[ECX]
            .iF array[EBX] > EAX
                xchg array[EBX], EAX
                mov array[ECX], EAX
                inc cont
            .ENDIF
            add ECX, TYPE array
        .ENDW
        add EBX, TYPE array
    .ENDW

    mov EBX, 0
    mov ECX, 1
    .WHILE EBX < n
        mov EAX, ECX
        call WriteInt
        mov EDX, OFFSET dato2
        call WriteString
        mov EAX, array[EBX]
        call WriteInt
        call crlf
        add EBX, TYPE array
        inc ECX
    .ENDW

    ;Muestra temperatura minima
    mov edx, OFFSET res
    call WriteString
    mov EAX, min
    call WriteInt
    call crlf

    ;Muestra total de intercambios
    mov EDX, OFFSET intercambios
    call WriteString
    mov EAX, cont
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