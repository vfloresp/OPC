TITLE Ejercicio ejer4BH1

; Descripcion:
; Ejemplo de implementacion de operaciones logicas Booleanas.
; Como los compiladores.
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
falso=0
verda=1
datoA    BYTE "Dato A: ", mnul
datoB    BYTE "Dato B: ", mnul
datoC    BYTE "Dato C: ", mnul
impri01 BYTE "C = B-A: ", mnul
impri02 BYTE "C = B*10: ", mnul
Adios BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul

; Variables
boo1    BYTE ?    ; para llevar un valor logico Booleano
boo2    BYTE ?
A    SDWORD ?
B    SDWORD ?
CC    SDWORD ?

.CODE
; Procedimiento principal
main PROC
	mov edx, OFFSET datoA
	call WriteString
      call ReadInt
      mov A, EAX

	mov edx, OFFSET datoB
	call WriteString
      call ReadInt
      mov B, EAX

	mov edx, OFFSET datoC
	call WriteString
      call ReadInt
      mov CC, EAX

	; IF(  (A > B) && (C <= 5)  ) 
      MOV boo1, false    ; para A > B
      MOV boo2, false    ; para C <= 5
      ; (A > B)
      MOV EBX, B
      CMP A, EBX
      JLE eq1    ; salta por A <= B
      MOV boo1, verda
eq1:
      ; (C <= 5)
	CMP CC, 5
      JG eq2     ; salta por C > 5
      MOV boo2, verda
eq2:
	; boo1 && boo2
      MOV CL, boo1
      TEST CL, boo2
      JZ eqelse    ; salta por falso de (A > B) && (C <= 5)
      ; Verdadero de (A > B) && (C <= 5)
          sub EBX, A
          mov CC, EBX
          mov edx, OFFSET impri01
       JMP eqfinif
eqelse:
          imul EBX, 10
          mov CC, EBX
          mov edx, OFFSET impri02
eqfinif:  

	call WriteString
      mov EAX, CC
      call WriteInt
      call CrLf
        		
	; ADIOS
	mov edx,OFFSET Adios
	call WriteString
	
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main