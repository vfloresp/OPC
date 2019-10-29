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
arrayi SDWORD 40h, 20h, 30h, 50h, 10h
nuni DWORD LENGTHOF arrayi
suma SDWORD ?
arrayr SDWORD 5 DUP(?)

txti BYTE mcr,mlf,"DumpMem de arrayi.",mnul
txtr BYTE mcr,mlf,"DumpMem de arrayr.",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC sycArrdw, variables locales
arr1d DWORD ?
unidades DWORD ?
arr2d DWORD ?
dirRet DWORD ?

.CODE
main PROC

    ; call sycArrdw(arrayi, nuni, arrayr)
    push OFFSET arrayi
    push nuni
    push OFFSET arrayr
    call sycArrdw
    pop suma

    ; Despliega un dump de memoria de arrayi.
    mov edx, OFFSET txti
    call WriteString
    mov esi, OFFSET arrayi
    mov ECX, nuni
    mov EBX, TYPE arrayi
    call DumpMem
    call Crlf

    ; Despliega un dump de memoria de arrayr.
    mov edx, OFFSET txtr
    call WriteString
    mov ESI, OFFSET arrayr
    mov ECX, nuni
    mov EBX, TYPE arrayr
    call DumpMem
    call Crlf

    mov edx, OFFSET adios
    call WriteString
    call Crlf

    EXIT
main ENDP

sycArrdw PROC
; sycArrdw(arr1d, unidades, arr2d)
; Copia un arreglo dw en otro, restandole 30h a cada elemento del segundo arreglo,
; ademas suma todos los elementos del primer arreglo.
; Recibe
;     Stack: @arr1d, unidades, @arr2d
; Regresa
;     Stack: suma de los elementos de arr2d
; Varibles automaticas y locales
; arr1d, unidades, arr2d, dirRet

;   Argumentos o parametros pasados en el stack
    pop dirRet
    pop arr2d
    pop unidades
    pop arr1d

    ;Valores iniciales
    mov eax, 0 ;acumulador
    mov ebx, 0 ;variable de control
    mov esi, arr1d  ;arreglo con los datos
    mov edi, arr2d  ;arreglo donde quedara la resta de cada elemento

    
    .WHILE ebx < unidades
        mov ecx, [esi]      ;arreglo apuntado por arr1d
        sub ecx, 30h
        add eax, ecx         ;acumulando
        mov [edi], ecx      ;guarda en arreglo añuntado por arr2d
        inc ebx             ;incrementando variable de control
        add esi, TYPE SDWORD  ;incrimenta el registro indirecto
        add edi, TYPE SDWORD   ;incrimenta el registro indirecto
    .ENDW
    push eax
    push dirRet

    RET
sycArrdw ENDP

END main