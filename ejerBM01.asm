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


; Variables
min SDWORD 1000
n DWORD 0
nDec DWORD 0
temp SDWORD 0
array SDWORD 10 dup(?)
iArr DWORD OFFSET array
iArr2 DWORD OFFSET array

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
        mov array[EBX], EAX
        add iArr, TYPE array
        ;Guarda los valores en el arreglo

    .ENDW
    mov EBX, 0
    mov iArr, OFFSET array
    .WHILE EBX < n
        mov EAX, array[EBX]
        call WriteInt
        call crlf
        inc EBX
    .ENDW

    ;Ordenamiento seleccion directa
    mov iArr, OFFSET array
    mov EAX, n
    mov nDec, EAX
    dec nDec
    mov EBX, 0
    .WHILE EBX < nDec
        mov ECX, EBX
        inc ECX
        mov EAX, iArr
        add EAX, TYPE array
        mov [iArr2], EAX
        .WHILE ECX < n
            mov EDX, [iArr2]
            .iF [iArr] > EDX
                xchg [iArr], EDX
                mov [iArr2], EDX
            .ENDIF
            inc ECX
            add iArr2, TYPE array
        .ENDW
        inc EBX
        add iArr, TYPE array
    .ENDW

    mov EBX, 0
    mov iArr, OFFSET array
    .WHILE EBX < n
        mov EAX, [iArr]
        call WriteInt
        call crlf
        inc EBX
    .ENDW

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