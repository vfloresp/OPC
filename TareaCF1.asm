TITLE TareaCF2					

INCLUDE myIrvine.inc

.data
txt1 BYTE "El resultado de la operacion real es: ", 0
adios BYTE "ADIOS",0
RA REAL8 2.0f
SB REAL8 3.0f
TC REAL8 -2.0f
UD REAL8 10.0f
VE REAL8 15.0f
res REAL8 ?

;En notacion postfija la expresión
;(RA + SB)/TC * UD - RA + VE queda
;RA SB + TC UD * / RA BE + - 

.code
main PROC
    finit
    ;call ShowFPUStack

    fld RA
    fld SB
    ;call ShowFPUStack
    faddp st(1), st(0)
    ;call ShowFPUStack
    
    fld TC
    fld UD
    ;call ShowFPUStack
    fmulp st(1),st(0)
    ;call ShowFPUStack

    
    fdivp st(1),st(0)
    ;call ShowFPUStack

    fld RA
    fld VE
    ;call ShowFPUStack
    faddp st(1), st(0)
    ;call ShowFPUStack
    fsubp st(1),st(0)
    
    mov EDX, OFFSET txt1
    call WriteString
    call WriteFloat
    fstp res
    call crlf
    mov EDX, OFFSET adios
    call WriteString
    
    EXIT
main ENDP

END main
