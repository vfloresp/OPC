TITLE Creating a File              (readFromFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElemMax=100

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo DWORD totElemMax+1 DUP(?)
eleArre DWORD ?    ; Elements recovered, in the array

adios BYTE mCr,mLf, "ADIOS.",mNul
byLei BYTE mCr,mLf, "Bytes Leidos: ",mNul
eleRec BYTE mCr,mLf, "Elementos recuperados: ",mNul

; Procedimiento printValues
dirRet DWORD ?

.CODE
main PROC

; Create the file
      mov EDX, OFFSET fName
      call OpenInputFile
      mov fHandle, EAX

; Read from the file
      mov EAX, fHandle
      mov EDX, OFFSET arreglo
      mov ECX, SIZEOF arreglo
      call readFromFile       ;EAX with the number of bytes read
      mov EDX, OFFSET byLei
      call WriteString
      call WriteInt
      call CrLf

; Display the array of values
      push OFFSET arreglo
      call printValues
      pop eleArre

; Elements recovered in the arreglo
      mov EDX, OFFSET eleRec
      call WriteString
      mov EAX, eleArre
      call WriteInt
      call CrLf
      
; Close the file
      mov EAX, fHandle
      call CloseFile

; Adios
      mov EDX, OFFSET adios
      call WriteString
      call CrLf

	EXIT
main ENDP

;------------------------------------------------------------
printValues PROC
;
; Print values from the array / buffer
; Receives: pop ESI points to the array / buffer
; Returns: The amount of elements in the array
;------------------------------------------------------------
      pop dirRet
      pop ESI

      mov ECX, [ESI]    ;the numbre of the elements, in first place
      add ESI, TYPE DWORD
      mov EAX, ECX
      call CrLf
      call WriteInt ;display it
      call CrLf

      mov EBX, 1 ;control variable
      .WHILE EBX <= ECX
            mov EAX, [ESI]
            add ESI, TYPE SDWORD
            call WriteInt  ;display it
            call CrLf  

            inc EBX
      .ENDW

      push ECX
      push dirRet

	RET
printValues ENDP

END main