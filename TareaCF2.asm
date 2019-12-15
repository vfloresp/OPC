TITLE TareaCF2					

INCLUDE myIrvine.inc

.data
txt1 BYTE "Ingrese el factor a multiplicar: ",0
txt2 BYTE "Ingrese el numero de datos: ",0
txt3 BYTE "Ingrese el siguiente dato: ", 0
txt4 BYTE ": ", 0
adios BYTE "ADIOS",0
n DWORD ?
factor DWORD ?
indMin DWORD ?
menor DWORD ?
temp REAL8 ?
arrLista REAL8 0.0f,0.0f

.code
main PROC

    finit
    
    mov EDX, offset txt1
    call WriteString
    call ReadInt
    mov factor, EAX

    mov EDX, offset txt2
    call WriteString
    call ReadInt
    mov n, EAX

    mov ESI, offset arrLista
    call LeerLista

    call FacLista
    call MenorLista
    call Imprime

    EXIT
main ENDP


LeerLista PROC
    mov EDX, offset txt3
    call WriteString
    call ReadFloat

    call  ShowFPUStack
    fst temp
    call  ShowFPUStack

    mov arrLista[ESI], temp   
    add ESI, TYPE REAL8
    
LeerLista ENDP

FacLista PROC
    mov EBX, 0
    mov ESI, offset arrLista
    .while EBX <n
        fld arrLista[ESI]
        add ESI, TYPE REAL8
        inc EBX
    .endw

    mov EBX, 0
    .while EBX <n
        fmul factor
        fst arrLista[ESI]
        add ESI, TYPE REAL8
        inc EBX
    .endw
FacLista ENDP

MenorLista PROC
    mov EBX, 0
    mov ESI, offset arrLista
    .while EBX <n
        fld arrLista[ESI]
        add ESI, TYPE REAL8
        inc EBX
    .endw
MenorLista ENDP

imprime PROC
    mov EBX, 0
    mov ESI, offset arrLista
    .while EBX <n
        fld arrLista[ESI]
        add ESI, TYPE REAL8
        inc EBX
    .endw
imprime ENDP

END main