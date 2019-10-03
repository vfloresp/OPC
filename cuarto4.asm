TITLE *MASM Template	(cuarto4.asm)*

; Descripcion:
; Representacion de datos almacenados en memoria y uso de DumpMem
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
texto1    BYTE "++++ Representacion de Alfa en DWORD",0
texto2   BYTE "++++ Representacion de Beta en BYTE",0
Beta    LABEL BYTE
Alfa    DWORD 12345678h    ; How is the DWORD stored in memory?
adios    BYTE "ADIOS", 0

.CODE
; Procedimiento principal
main PROC

    call CrLf
    mov EDX, OFFSET texto1
    call WriteString

    mov ESI, OFFSET Alfa    ; Starting Offest, or Addres, of Alfa
    mov ECX, LENGTHOF Alfa    ; 1 element
    mov EBX, TYPE Alfa    ; 4 bytes
    call DumpMem
    call CrLf

    ; ++++++++
    mov EDX, OFFSET texto2
    call WriteString

    mov ESI, OFFSET Beta    ; Starting Offest, or Addres, of Alfa
    mov ECX, LENGTHOF Beta+3    ; 4 elements
    mov EBX, TYPE Beta    ; 1 bytes
    call DumpMem
    call CrLf

    
    ; ++++++++++++

    mov EDX, OFFSET adios        ; despliega "ADIOS"
    call WriteString
    call CrLf
        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main