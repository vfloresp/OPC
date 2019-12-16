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

;variables
opcion DWORD ?
max DWORD ?
xmax DWORD ?
xActual DWORD ?
valx REAL8 ?
valSin REAL8 ?
valPi REAL8 3.14159
val180 REAL8 180.0
dirRet DWORD ?
dirRet2 DWORD ?
valn DWORD ?
valParidad SDWORD ?
valFac DWORD ?
valSig SDWORD ?
exp DWORD ?
aux REAL8 ?
valPot REAL8 ?
valIter REAL8 ?
arraySen REAL8 37 dup(?)
temp REAL8 ?

.code
main PROC
finit   ; starts up the FPU
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
    call ReadFloat
    call grdArad
    mov EAX,6
    push EAX
    call seno
    fstp valx
    call WriteFloat
    call CrLf
    JMP menu
;Calculo de sin(x) para x en radianes
op2:
    mov EDX, offset strDato2
    call WriteString
    call CrLf
    call ReadFloat
    mov EAX,6
    push EAX
    call seno
    call ShowFPUStack
    fstp valx
    call WriteFloat
    call CrLf
    JMP menu
;Calculo de tabla de sin(x) hasta el valor x 
op3:
    mov EDX, offset strDato3
    call WriteString
    call CrLf
    call ReadFloat
    call llenarTabla
    call escribirTabla
    JMP menu
;Termino de la ejecucion
fin:
    mov EDX, offset strFin
    call WriteString
    EXIT

main ENDP

;Procedimiento para calcular la funcion trigonometrica de sin(x)
seno PROC
; Calcula la funcion trigonometrica de seno
; Recibe:  Stack: n ST(0)=x
; Regresa: ST(0) = x
;           ST(1) = suma de 0 hasta n de 
;          (-1)^n * x^(2n+1) / (2n+1)!
; Utiliza recursion
    pop dirRet
    pop valn
    fstp valx

    push valn
    call factorial      ;Calcula el factorial (2n+1)!
    pop valFac

    push valn           ;Calcula el valor (-1)^n
    call signo
    pop valSig

    push valn           ;calcula el exponente x^(2n+1)
    fld valx
    call potencia
    fstp valPot

    fild valSig         ;Opera los valores obtenidos en la iteracion
    fild valFac
    fdiv
    fmul valPot

    fstp valIter

    .IF valn < 1            ;Caso en que termina la recursion
        fld valIter
        fld valx
        
    .ELSE                  ;Se vuelve a llamar al procedimiento seno
        dec valn
        push dirRet
        push valn
        fld valIter
        fld valx
        call seno

        pop dirRet
        fstp valx
        fadd
        fld valx
        
    .ENDIF

    push dirRet
    RET
seno ENDP

factorial PROC
; Calcula (2n+1)!
; Recibe:  Stack: n
; Regresa: Stack: (2n+1)!
; Utiliza la variable dirRet
    pop dirRet2
    pop EBX
    shl EBX,1
    inc EBX     ;Se obtiene el valor 2n+1
    
    mov EAX, 1
    .WHILE EBX>1
        mul EBX
        dec EBX
    .ENDW

    push EAX
    push dirRet2
    RET
factorial ENDP

signo PROC
; Calcula (-1)^n
; Recibe:  Stack: n
; Regresa: Stack: (-1)^n
; Utiliza la variable dirRet
    pop dirRet2
    pop EAX
    shr EAX,1
    jc impar
    mov EAX, 1
    JMP final
impar:
    mov EAX,-1
final:
    push EAX
    push dirRet2
    RET
signo ENDP

;Procedimiento para calcular x^(2n+1)
potencia PROC
; Calcula x^(2n+1)
; Recibe:  Stack: n ST(0)=x
; Regresa: ST(0)= x^(2n+1)
; Utiliza la variable dirRet
    pop dirRet2
    pop EAX
    mov EBX,2
    mul EBX
    inc EAX    ;Se obtiene el valor 2n+1

    mov exp, EAX
    mov EBX,1
    fst aux
    .WHILE EBX < exp
        fmul aux
        inc EBX
    .ENDW

    push dirRet2  
    RET
potencia ENDP

grdArad PROC
; Calcula el valor en radianes del parametro recibido
; Recibe:  ST(0) = x
; Regresa: ST(0) = valor de x en radianes
    fmul valPi
    fdiv val180
    RET
grdArad ENDP

radAgrad PROC
; Calcula el valor en grados del parametro recibido
; Recibe:  ST(0) = x
; Regresa: ST(0) = valor de x en grados
    fmul val180
    fdiv valPi
    RET
radAgrad ENDP

llenarTabla PROC 
    pop dirRet
    fist xmax
    mov EBX, 0
    mov ESI, offset arraySen
    .WHILE EBX < xmax
        push EBX
        push dirRet
        call seno
        fstp valx
        fist xActual
        mov [ESI], EBX
        add ESI, TYPE arraySen
        push EBX
        push dirRet
        call radAgrad
        pop EAX
        mov [ESI], EAX
        add ESI, TYPE 
        mov EAX, xActual
        mov [ESI], EAX
        add ESI, TYPE arraySen
        add EBX, 10
    .ENDW
    push dirRet
llenarTabla ENDP

escribirTabla PROC
    pop dirRet
    mov EBX, 0
    mov EDI, offset arraySen
    mov ECX, sizeof arraySen
    mov max, ECX
    .WHILE EBX < max
        fild [EDI]
        add EDI, TYPE arraySen
        call WriteFloat
        fstp temp
        .IF (EBX % 3 == 0)
            call CrLf
        .ENDIF
        inc EBX
    .ENDW
    push dirRet
escribirTabla ENDP

END main