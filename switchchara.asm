TITLE Ejercicio switchchara

; Descripcion:
; Ejemplo de implementacion de la Estructura Algoritmica Switch.
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
; Textos para la Consola
mcr=0Dh
mlf=0Ah
mnul=0h
titulo BYTE mcr, mlf, "Ejemplo de Switch.", mcr, mlf, "Tecle el dato char: ", mnul
impri01 BYTE "Caracter: ", mnul
impri02 BYTE "Caracter default: ", mnul
Adios BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul

; Variables
char    BYTE ?,0
caseD BYTE 'D',0
caseG BYTE 'G',0
 
.CODE
; Procedimiento principal
main PROC
	mov edx,OFFSET titulo
	call WriteString

	; char = scan (+++)
	call ReadChar
      mov char, AL
      
	; SWITCH(char)
      .IF AL == caseD
        mov char, 'E'
      .ELSEIF AL == caseG
        mov char, 'F'   
      .ENDIF
      CALL crlf
      mov edx, OFFSET char
      call WriteString
      
		
	; ADIOS
	mov edx,OFFSET Adios
	call WriteString
	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main