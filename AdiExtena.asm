; Ejemplo de Adicion Extendida           (AdiExtena.asm)

; Este programa calcula la suma de dos enteros de 9 bytes.
; Estos enteros estan almacenados como arreglos ("op1" y "op2"),
; con el byte menos significativo almacenado en la direccion mas baja.
; El resultado quedara en el arreglo "suma". 

;INCLUDE myIrvine.inc
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib


.DATA
op1 BYTE 20h,34h,12h,98h,74h,06h,0A4h,0B2h,0A2h
op2 BYTE 30h,02h,45h,23h,00h,00h,87h,10h,80h
dirRet DWORD ?
cont DWORD 0

suma BYTE 10 dup(0) 	; = 01 22 C3 2B 06 74 BB 57 36 50h
; El almacenamiento para esta variable "suma" debe ser de un
; byte mas largo que el de los operandos "op1" y "op2"

.code
main PROC

; Calcula la adicion extendida
	push LENGTHOF op1
	push OFFSET op1
	push OFFSET op2
	push OFFSET suma

	call AdicionExtendida

	
	mov ESI, OFFSET op1
	mov ECX, 10
	mov EBX, 1
	call DumpMem

; Despliega la suma.
	push LENGTHOF suma
	push OFFSET suma
	call DespliegaSuma
	call Crlf
	
	exit
main ENDP

;--------------------------------------------------------
AdicionExtendida PROC
; DESCRIPCION:
;   Calcula la suma de dos entero extendidos almacenados como arreglos de bytes.
; RECIBE:
; Por medio del stack,
;   los apuntadores a los dos enteros, colocandolos en ESI y EDI;
;   el numero de bytes a ser sumados se guardara en ECX;
;   el apuntador a la variable que guardara la suma, en EBX.
; REGRESA:
;   Nada.
;--------------------------------------------------------
	pop dirRet
	pop ECX
	pop ESI
	pop EDI
	pop EBX

	mov cont, 0
	.WHILE cont<ECX
		mov AX, [ESI]
		add AX, [EDI]		;suma entre los dos arreglos
		add EDI, TYPE BYTE
		mov [EBX],AX		;guarda el elemento en EBX
		mov AX, 0
		adc [EDI],AX			;suma del carry al siguiente elemento
		add ESI, TYPE BYTE
		add EBX, TYPE BYTE
		inc cont
	.ENDW
	mov AX, 0 
	adc [EBX],AX				;Agrega el carry al ultimo indice

	push dirRet
	ret
AdicionExtendida ENDP

;-----------------------------------------------------------
DespliegaSuma PROC
; DESCRIPCION:
;   Despliega un entero largo que esta almacenado en orden
;   little endian (LSB to MSB).
;   La salida despliega el arreglo, con el resultado, en
;   hexadecimal, empezando con el MSB.
; RECIBE:
;   Por medio del stack,
;   el apuntador al arreglo con el resultado, en ESI;
;   el numero de bytes del arreglo, en ECX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
	pop dirRet
	pop ESI
	pop ECX

	mov cont, 0
	.WHILE cont<ECX


		inc cont
	.ENDW

	push dirRet
	ret
DespliegaSuma ENDP


END main