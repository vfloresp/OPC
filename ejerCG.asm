TITLE funcion trigonometrica seno

; Floating point sample

INCLUDE myIrvine.inc

.data
strMenu BYTE "Indique la opcion del menu que desea realizar:",0
strOp1 BYTE "1)Calculo de sin(x) con x en grados",0
strOp2 BYTE "2)Calculo del valor sin(x) con x en radianes",0
strOp3 BYTE "3)Generar tabla de los valores de 0 a x grados de sin(x)",0
strOp4 BYTE "4)Salir del menu",0
strDato1 BYTE "Introduzca el valor en grados para el que desea calular sin(x)",0
strDato2 BYTE "Introduzca el valor en radianes para el que desea calular sin(x)",0
strDato3 BYTE "Introduzca el valor entre 0 y 360 hasta el que desea generar la tabla de sin(x)",0
strFin BYTE "ADIOS",0
opcion DWORD ?

.code
main PROC
;Ciclo para mostrar las opciones del menu 
menu:
    mov EDX, offset strMenu
    call WriteString
    call CrLf
    mov EDX, offset strOp1
    call WriteString
    call CrLf
    mov EDX, offset strOp2
    call WriteString
    call CrLf
    mov EDX, offset strOp3
    call WriteString
    call CrLf
    mov EDX, offset strOp4
    call WriteString
    call CrLf
    call ReadInt
    mov opcion, EAX
    call CrLf

    .IF opcion == 1
        JMP op1
    .ELSEIF opcion == 2
        JMP op2
    .ELSEIF opcion == 3
        JMP op3
    .ELSE
        JMP fin
    .ENDIF

;Calculo de sin(x) para x en grados
op1:
    mov EDX, offset strDato1
    call WriteString
    call CrLf
    call ReadInt
    JMP menu
;Calculo de sin(x) para x en radianes
op2:
    mov EDX, offset strDato2
    call WriteString
    call CrLf
    call ReadInt
    JMP menu
;Calculo de tabla de sin(x) hasta el valor x 
op3:
    mov EDX, offset strDato3
    call WriteString
    call CrLf
    call ReadInt
    JMP menu
;Termino de la ejecucion
fin:
    mov EDX, offset strFin
    call WriteString
    EXIT

main ENDP

;Procedimiento para calcular la funcion trigonometrica de sin(x)
seno PROC

seno ENDP

;Procedimiento para calcular (2n-1)!
factorial PROC

factorial ENDP

;Procedimiento para calcular (-1)^n
signo PROC

signo ENDP

;Procedimiento para calcular x^(2n+1)
potencia PROC

potencia ENDP

;Procedimiento para pasar grados a radianes
grdArad PROC

grdArad ENDP

;Procedimiento para pasar radianes a grados
radAgrad PROC

radAgrad ENDP

END main