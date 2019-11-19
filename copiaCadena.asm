TITLE Procedimiento para copiar cadenas

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

maxLen = 100

.DATA
cadena1 BYTE 100 dup(?),0
cadena2 BYTE 100 dup(?),0
introCad BYTE "Introduzca la cadena incial:  ",0
finCad BYTE "La cadena copiada: ",0
adios BYTE mCr,mLf, "ADIOS.",mNul
byEscri BYTE mCr,mLf, "Bytes Escritos: ",mNul

; Var
dirRet DWORD ?
charCount DWORD 0

.CODE
main PROC

; Recibe la cadena inicial
      mov EDX, OFFSET introCad
      call WriteString
      call ReadString

      mov EDX, OFFSET cadena1
      mov ECX, maxLen
      call ReadString
      mov charCount, EAX
      

; LLama el metodo para copiar la cadena
      push OFFSET cadena1
      push OFFSET cadena2
      push charCount
      
     
      
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
copiaCad PROC
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
copiaCad ENDP

END main