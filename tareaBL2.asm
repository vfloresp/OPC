TITLE Tarea BL2

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
; Textos para la Consola
inicio BYTE "String: ", 0
dato1  BYTE "Caracter ", 0
dato2  BYTE "o: ",0 
mayuscula  BYTE " - MAYUSCULA",0
minuscula  BYTE " - minuscula",0
noAlfa BYTE " - Char no alfa",0
conversion BYTE "Conversion: ",0
adios Byte "Adios ",0,0


; Variables
cadena BYTE 31 dup(0)
imp BYTE ?,0
n DWORD ?

.CODE
; Procedimiento principal
main PROC
    ;Lee el dato inicial y lo valida
    mov edx, OFFSET inicio
    call WriteString
    mov EDX, OFFSET cadena
    mov ECX, 31
    call ReadString
    mov n, EAX
    
    mov EBX, 1
    mov ECX, OFFSET cadena
    .WHILE EBX<=n
        mov edx, OFFSET dato1
        call WriteString
        mov EAX, EBX
        call WriteInt
        mov edx, OFFSET dato2
        call WriteString
        mov AL, BYTE PTR [ECX]
        mov imp, AL
        mov edx, OFFSET imp
        call WriteString
        
        .IF (AL >= 41h) && (AL <= 5Ah)
            mov edx, OFFSET mayuscula
            add AL, 20h
            mov [ECX], AL
        .ELSEIF (AL >= 61h) && (AL <= 7Ah)
            mov edx, OFFSET minuscula
            sub AL, 20h
            mov [ECX], AL
        .ELSE
            mov edx, OFFSET noAlfa
        .ENDIF
        call WriteString
        call crlf
        inc EBX
        add ECX, TYPE cadena
    .ENDW

    mov edx, OFFSET conversion
    call WriteString
    mov edx, OFFSET cadena
    call WriteString
    call crlf    
fin:
    mov edx, OFFSET adios
    call WriteString 

    exit
main ENDP
END main