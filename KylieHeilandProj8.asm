; This program is used to calculate the greatest common divisor between two signed integers.
; Kylie Heiland
; 11 / 30 / 22


INCLUDE Irvine32.inc
GCD2 PROTO, x:DWORD, y:DWORD
.386
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
carriageReturn BYTE ' ', 13, 10, 0                ; Used as a new line to separate the random strings from one another.

temp DWORD ?                                      ; Holds the eax value.

; Displays a menu asking the user to make a selection.
menu BYTE "---- Greatest Common Divisor ----", 0

int1 DWORD ? 
int2 DWORD ?

result BYTE "Greatest common divisor of (", 0
result2 BYTE ", ", 0
result3 BYTE ") calculated by loop is: ", 0
result4 BYTE "Calculated by recursion is: ", 0


.code
    main proc
    mov eax, 0                                   ; Makes the eax register 0.
    

    mov edx, OFFSET menu                         ; Prints "---- Greatest Common Divisor ----" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
  
   ;CALCULATES GCD of 5 and 20
    mov int1, 5         
    mov int2, 20
    call gcd
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    mov edx, OFFSET result4                      ; Prints "Calculated by recursion is: ".
    call WriteString
    INVOKE GCD2, int1, int2
    call WriteInt                                ; The GCD is output.
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString

   ;CALCULATES GCD of 24 and 18
    mov int1, 24       
    mov int2, 18
    call gcd
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    mov edx, OFFSET result4                      ; Prints "Calculated by recursion is: ".
    call WriteString
    INVOKE GCD2, int1, int2
    call WriteInt                                ; The GCD is output.
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString


    ;CALCULATES GCD of 11 and 7
    mov int1, 11      
    mov int2, 7
    call gcd
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    mov edx, OFFSET result4                      ; Prints "Calculated by recursion is: ".
    call WriteString
    INVOKE GCD2, int1, int2
    call WriteInt                                ; The GCD is output.
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString

    
    ;CALCULATES GCD of 432 and 226
    mov int1, 432       
    mov int2, 226
    call gcd
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    mov edx, OFFSET result4                      ; Prints "Calculated by recursion is: ".
    call WriteString
    INVOKE GCD2, int1, int2
    call WriteInt                                ; The GCD is output.
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    
    ;CALCULATES GCD of 26 and 13
    mov int1, 26       
    mov int2, 13
    call gcd
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString
    mov edx, OFFSET result4                      ; Prints "Calculated by recursion is: ".
    call WriteString
    INVOKE GCD2, int1, int2
    call WriteInt                                ; The GCD is output.
    mov edx, OFFSET carriageReturn               ; New line is made
    call WriteString

    call WaitMsg
    call Clrscr

invoke ExitProcess, 0
main endp

GCD PROC 
    push int1
    push int2
    mov ebx, int1                                ; EBX is assigned int1.
    cmp int1, 0                                  
    jge alreadyAbsolute1                         ; If int1 is positive, then it does not need its absolute value.
    neg int1                                     ; Uses int1's absolute value.
alreadyAbsolute1:
    cmp int2, 0                                  
    jge alreadyAbsolute2                         ; If int2 is positive, then it does not need its absoulute value.
    neg int2                                     ; Uses int2's absolute value.    
alreadyAbsolute2:    
    mov edx, OFFSET result                       ; Prints "Greatest common divisor of (".
    call WriteString
    mov eax, int1                                ; Prints the first integer.
    call WriteInt
    mov edx, OFFSET result2                      ; Print ", ".
    call WriteString
    mov eax, int2                                ; Prints the second integer.
    call WriteInt
    mov edx, OFFSET result3                      ; Prints ") calculated by loop is: ".
    call WriteString

loop1:
    mov edx, 0
    mov eax, int1
    mov ebx, int2
    div ebx
    mov eax, edx                                 ; Edx is n: n = x % y
    
    mov esi, int2
    mov int1, esi                                ; x = y
    mov int2, edx                                ; y = n

    cmp int2, 0                                  ; }while (int2 > 0)
    jg loop1                                     ; If the content of the loop is met, continues loop.
    mov eax, int1                                ; The GCD is output.
    call WriteInt
    pop int1
    pop int2
    ret
GCD ENDP                   

GCD2 PROC, integer1:DWORD, integer2:DWORD
    mov edx, 0                                    ; Zeros out edx.
    mov esi, integer1
    mov temp, esi                                 ; Holds the first integer.
    mov ebx, integer2                             ; Holds the second integer

    cmp temp, 0                                   ; Checks to make sure that temp is a non-negative number.
    jge alreadyAbsolute1                          ; If the first integer is positive, then it does not need its absolute value.
    neg temp                                      ; The first integer is now negated to its absolute value.
alreadyAbsolute1:                                 
    cmp ebx, 0                                    ; Checks to make sure that the second integer is a non-negative number.
    jge alreadyAbsolute2                          ; If the second integer is positive, then it does not need its absolute value.
    neg ebx                                       ; Since the second integer is negative, then it is negated to its absolute value.   
alreadyAbsolute2:
    test ebx, ebx                                 ; Tests to see whether the second integer is zero or not. 
    jz label1                                     ; If zero, then the procedure ends.
    mov eax, temp                                 ; Moves the first integer to eax, for division.
    div ebx                                       ; Divides the first integer by the second integer.
    INVOKE GCD2, ebx, edx                         ; Recursively calls GCD2 until the second integer is zero. 
label1:
    mov eax, temp                                 ; Since temp holds the remainder, it is moved to eax for output after returning the procedure.
    ret 
GCD2 ENDP
end main