TITLE Program Template          (OpArrArg.asm)

; Este programa llama un procedimiento con pasaje por stack.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

;SIMBOLOS
mcr=0dh
mlf=0ah
mnul=0h

.DATA
; PROC main

n DWORD ?
fila byte 7
columna byte 13

txtN BYTE "Teclee el dato n: ",mnul
txtD1 BYTE "Teclee el ",mnul
txtD2 BYTE " salario: ",mnul
txtRes BYTE "Resultado: ",mnul
adios BYTE "ADIOS.",mnul

; PROC Salarios, variables locales
salario DWORD ?
dirRet DWORD ?
suma DWORD ?
num DWORD ?

; PROC Possal, variables locales
nDato DWORD ? ;numero de dato
dRet DWORD ?

.CODE
main PROC

    call Clrscr

    mov DL, columna;columna 14
    mov DH, fila
    call Gotoxy
    inc fila
   
    mov EDX, OFFSET txtN
    call WriteString

    call ReadInt
    mov n, EAX

   
    call CrlF

    push n
    call Salarios
    pop suma

    mov DL, columna;columna 14
    mov DH, fila
    call Gotoxy
    inc fila

    mov EDX, OFFSET txtRes
    call WriteString
    mov EAX, suma
    call WriteInt
    call crlf

    mov DL, columna;columna 14
    mov DH, fila
    call Gotoxy
    inc fila
   
    mov EDX, OFFSET adios
    call WriteString

    EXIT
main ENDP

Salarios PROC

    pop dirRet
    pop num
    mov EBX,1
    mov ECX,0
   
    .WHILE EBX <= n
        push EBX
        call Possal
       
        call ReadInt
        mov salario, EAX
   
        ADD ECX, salario
        INC EBX

        call Crlf

    .ENDW

    push ECX
    push dirRet

    RET
Salarios ENDP


Possal PROC
    pop dRet
    mov DL, columna;columna 14
    mov DH, fila
    call Gotoxy

    pop nDato
    mov EDX, OFFSET txtD1
    call WriteString
    mov EAX, nDato
    call WriteInt
     
    mov EDX, OFFSET txtD2
    call WriteString

    inc fila

    push dRet
    RET
Possal ENDP

END main