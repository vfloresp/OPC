TITLE Creating a File              (createFileNum.asm)

Comment !
Use of File procedures.
!

INCLUDE myIrvine.inc

mCr=0dh
mLf=0ah
mNul=00h
totElem=50

.DATA
fHandle DWORD ?
fName BYTE "two.bin",mNul
arreglo DWORD totElem+1 DUP(?)

adios BYTE mCr,mLf, "ADIOS.",mNul
byEscri BYTE mCr,mLf, "Bytes Escritos: ",mNul

; Procedimiento GenerateValues
dirRet DWORD ?

.CODE
main PROC

; Create the file
      mov EDX, OFFSET fName
      call CreateOutputFile
      mov fHandle, EAX
      

; Generate the array of values
      push OFFSET arreglo
      push totElem
      call generateValues
      
; Write into the file
      mov EAX, fHandle
      mov EDX, OFFSET arreglo
      mov ECX, SIZEOF arreglo
      call WriteToFile
      mov EDX, OFFSET byEscri
      call WriteString
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
generateValues PROC
;
; Generates values from -1,-2,-3,... and stores in an array.
; Receives: pop ECX = number of elements, pop ESI points to the array
; Returns: nothing, the result is intrinsec in the array
;------------------------------------------------------------
      pop dirRet
      pop ECX
      pop ESI

      mov [ESI],ECX ;The number of elements in the buffer
      add ESI, TYPE SDWORD
      mov EAX, ECX
      call WriteInt
      call CrLf

      mov EBX, 1 ;control variable
      .WHILE EBX <= ECX
            mov EAX, EBX
            neg EAX
            call WriteInt  ;EAX has the negative value
            call CrLf   ;display it
      
            mov [ESI],EAX     ;storing the nagative value
            add ESI, TYPE SDWORD
            inc EBX
      .ENDW

      push dirRet

	RET
generateValues ENDP

END main