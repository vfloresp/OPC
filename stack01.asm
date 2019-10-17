TITLE Ejercicio stack01

; Descripcion:
; Ejemplo de uso del Runtime Stack.
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
Adios BYTE "ADIOS.", 0

.CODE
; Procedimiento principal
main PROC
	mov EAX, 0
      mov EBX, 0
      
      push 12047506h
      
      pop AX
      pop BX

      call DumpRegs
	
	; ADIOS
	mov edx,OFFSET Adios
	call WriteString
      call CrLf
	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main