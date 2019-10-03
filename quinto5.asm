TITLE *MASM Template	(quinto5.asm)*

; Descripcion:
; Uso de "Type" PTR
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
texto    BYTE "--¿como Hola estan?", 0
adios    BYTE "ADIOS", 0

.CODE
; Procedimiento principal
main PROC

    call CrLf
    mov EDX, OFFSET texto        ; estado inicial de "texto"
    call WriteString
    call CrLf

    ; ++++++++
     mov EAX, DWORD PTR [texto+3]
     xchg EAX, DWORD PTR [texto+8]
     mov DWORD PTR [texto+3], EAX

    call WriteString
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