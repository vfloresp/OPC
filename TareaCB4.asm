; Tarea CB Ejercicio 4

; Este programa convierte una DWORD a una cadena ASCII
; y convierte una SDWORD a una cadena ASCII
; ambos casos en representación decimal
; Los parametros de entrada estan dado por dwrd y dsword
; La salida se guarda en sdwrd y ssdwrd

INCLUDE myIrvine.inc

.DATA
dwrd DWORD 0Ah
dswrd DWORD 0Ah
sdwrd BYTE 11 dup(?)
ssdwrd BYTE 12 dup(?)
dirRet DWORD ?
cont DWORD 0
logitud DWORD 0


.code
main PROC

; Manda llamar la funcion de dwToStr y despliega el resultado

    push dwrd
    push OFFSET sdwrd
    call dwToStr
    mov EDX, OFFSET sdwrd
    call WriteString

; Manda llamar la funcion de dwToStr y despliega el resultado
    
    push sdwrd
    push OFFSET ssdwrd
    call swdToStr
    mov EDX, OFFSET sdwrd
    call WriteString
	
	exit
main ENDP

;--------------------------------------------------------
dwToStr PROC
; DESCRIPCION:
;   Convierte una DWORD a una cadena ASCII en representación decimal
; RECIBE:
; Por medio del stack,
;   el valor de la DWORD que guarda en ESI
;   la dirección dónde se desea la string que guarda en EDI
; REGRESA:
;   Nada.
;--------------------------------------------------------
	pop dirRet
    pop EDI
    pop ESI

    mov logitud, TYPE DWORD
    mov cont, 0

    .WHILE cont< longitud
        mov AL, BYTE PTR [ESI]
        .IF AL> 57
            mov [EDI],0
            add ESI, TYPE BYTE
            sub AL, 64
            add [ESI],AL
            sub ESI, TYPE BYTE
        .ELSE
            mov [EDI],AL
        .ENDIF
        add ESI, TYPE BYTE
        add EDI, TYPE BYTE 
        inc cont
    .ENDW 



	push dirRet
	ret
dwToStr ENDP

;-----------------------------------------------------------
swdToStr PROC
; DESCRIPCION:
;   Convierte una SDWORD a una cadena ASCII en representación decimal
; RECIBE:
;   el valor de la SDWORD que guarda en ESI
;   la dirección dónde se desea la string que guarda en EDI
; REGRESA:
;   Nada.
;-----------------------------------------------------------
	pop dirRet
	pop EDI
    pop ESI

    .WHILE cont< longitud
    mov AL, BYTE PTR [ESI]
    .IF AL> 57
        mov [EDI],0
        add ESI, TYPE BYTE
        sub AL, 64
        add [ESI],AL
        sub ESI, TYPE BYTE
    .ELSE
        mov [EDI],AL
    .ENDIF
    add ESI, TYPE BYTE
    add EDI, TYPE BYTE 
    inc cont
    .ENDW 


	push dirRet
	ret
swdToStr ENDP


END main