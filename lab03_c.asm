TITLE LAB_03
DATA SEGMENT
    num1 DB ? 
    num2 DB ? 
    result DW ?
    num1msg DB 10,13, "Enter the first number (0-9): ","$"
    num2msg DB 10,13, "Enter the second number (0-9): ","$"
    resultmsg DB 10,13, "The result is:    ","$"
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX

    ; Input for the first number
    LEA DX, num1msg
    MOV AH, 09
    INT 21h 

    MOV AH, 01
    INT 21h
    SUB AL, '0'    
    MOV num1, AL 

    ; Input for the second number
    LEA DX, num2msg
    MOV AH, 09
    INT 21h 

    MOV AH, 01
    INT 21h
    SUB AL, '0'
    MOV num2, AL   

    ; Multiply num1 and num2
    MOV AL, num1
    MUL num2
    MOV result, AX

    ; Display the result
    MOV AX, result
    MOV CX, 0     ; Initialize the counter
    MOV BX, 10    ; Set divisor for decimal conversion
    MOV SI, 19     ; Start from the end of resultmsg

PRINT_DIGIT:
    MOV DX, 0     ; Clear any previous remainder
    DIV BX         ; Divide AX by 10
    ADD DL, '0'    ; Convert the remainder to ASCII
    DEC SI         ; Move the pointer in resultmsg
    MOV [resultmsg+SI], DL ; Store the digit

    ;INC CX         ; Increment the counter
    CMP AX, 0
    JNZ PRINT_DIGIT

    ; Print the result message
    LEA DX, resultmsg
    MOV AH, 09
    INT 21h  

    ; Exit program
    MOV AH, 4Ch
    INT 21h

CODE ENDS
END START       