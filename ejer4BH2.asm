TITLE Ejercicio ejer4BH2

; Descripcion:
; Ejemplo de implementacion de operaciones logicas Booleanas.
; Optimizado manualmente.
; 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
; Textos para la Consola
dato    BYTE "Ingrese la temperatura", 0
continua    BYTE "Desea ingresar otra temperatura? (s/n) ", 0
resM    BYTE "mayor: ", 0
resP Byte "posicion: ",0
siCont Byte "s",0


; Variables
max SDWORD 0
pos DWORD 0
cont DWORD 0


.CODE
; Procedimiento principal
main PROC

 iniWhile:
        
	mov edx, OFFSET dato
	call WriteString
      call ReadInt
      call crlf
      inc cont

      .IF EAX > max 
           mov max, EAX
           mov EAX, cont
           mov pos, EAX
      .ENDIF


	mov edx, OFFSET continua
	call WriteString
      call ReadChar
      .IF AL == siCont
          JMP iniWhile
      .ENDIF

      mov edx, OFFSET resM
      call WriteString
      mov EAX, max
      call WriteInt
      call crlf

      mov edx, OFFSET resP
      call WriteString
      mov EAX, pos
      call WriteInt


    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main