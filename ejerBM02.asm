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
num DWORD 0
index DWORD 0
nDec DWORD 0
temp SDWORD 0
array SDWORD 10 dup(?)
cont DWORD 0
resul DWORD 0
arrT DWORD ?
dirRet DWORD ?
signN SDWORD 0

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

    push OFFSET array
    push n 
    call VecSelDir
    pop resul

    mov esi, OFFSET array
    mov ecx, 10
    mov ebx, 4
    call DumpMem

    mov EBX, 0
    mov ECX, 1
    .WHILE ECX <= n
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
    mov EAX, resul
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

    VecSelDir PROC
    ;ordenamiento
        pop dirRet
        pop num
        pop arrT

        ;Ordenamiento seleccion directa
        mov EAX, num
        mov nDec, EAX
        dec nDec
        mov EBX, 0
        mov edi, arrT
        .WHILE EBX < nDec
            mov esi, edi
            add esi, TYPE SDWORD
            mov ECX, EBX
            inc ECX
            .WHILE ECX < n
                mov EAX, [edi]
                mov signN, EAX
                mov EAX, [esi]
                .iF signN > EAX
                    xchg [edi], EAX
                    mov [esi], EAX
                    inc cont
                .ENDIF
                inc ECX
                add esi, TYPE SDWORD
            .ENDW
            inc EBX
            add edi, TYPE SDWORD
        .ENDW

        push cont
        push dirRet
        RET
    VecSelDir ENDP

main ENDP
END main