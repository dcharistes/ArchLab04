TITLE labpoint03  
;DIMITRIOS CHARISTES
DATA SEGMENT 
    
    promtmsg db "Give a two-digit hexademical number(0-9 A-F): $"  
    promtresult db 10,13, "The result is: $"
    hex_input1 db 0  
    hex_input2 db 0  
    result db 0  
    ones db 0
    tens db 0
    hundreds db 0
    
       
    DATA ENDS

CODE SEGMENT
    
    START:
        
        MOV AX,DATA
        MOV DS,AX
        
        LEA DX, promtmsg
        MOV AH,09h
        INT 21h
        
    INPUT1: 
        
        MOV AH,08
        INT 21h
        MOV hex_input1, AL    
        
        CMP hex_input1, 48 ;decimal for '0' in ascii  
        JB INPUT1
        CMP hex_input1, 57 ;'9'
        JBE IS_DEC_HEX1
        
        CMP hex_input1, 65 ;'A'
        JB INPUT1
        CMP hex_input1, 70 ;'F'
        JA INPUT1
        JMP IS_HEX1
          
    IS_DEC_HEX1: 
    
        MOV DL, hex_input1
        MOV AH,02h
        INT 21h  
        
        MOV AL, hex_input1
        SUB AL,48 
        MOV hex_input1, AL
        
        JMP INPUT2
    
    
    IS_HEX1: 
    
        MOV DL,hex_input1
        MOV AH,02h
        INT 21h
        
        MOV AL,hex_input1
        SUB AL,55 
        MOV hex_input1, AL
        
    
    
    INPUT2: 
    
        MOV AH,08h
        INT 21h
        MOV hex_input2, AL    
        
        CMP hex_input2, 48 ;'0'
        JB INPUT2
        CMP hex_input2, 57 ;'9'
        JBE IS_DEC_HEX2
        
        CMP hex_input2, 65 ;'A'
        JB INPUT2
        CMP hex_input2, 70 ;'F'
        JA INPUT2
        JMP IS_HEX2 
        
        
    IS_DEC_HEX2:   
    
        MOV DL, hex_input2
        MOV AH,02h
        INT 21h  
        
        MOV AL, hex_input2
        SUB AL,48
        MOV hex_input2, AL
        
        JMP AFTER_HEX2
    
    IS_HEX2:
    
        MOV DL,hex_input2
        MOV AH,02h
        INT 21h
        
        MOV AL,hex_input2
        SUB AL,55
        MOV hex_input2, AL 
        
        
    AFTER_HEX2: 
        
        MOV AH,0
        MOV AL, hex_input1
        MOV BL,16
        MUL BL
        
        ADD AL, hex_input2
        MOV result, AL
    
        MOV AH,0
        MOV AL, result
        MOV BL,100
        DIV BL
        MOV hundreds,AL 
         
        MOV result,AH 
        
        MOV AH,0
        MOV AL, result
        MOV BL, 10  
        DIV BL
        MOV tens,AL
        
        MOV ones, AH
        
        LEA DX, promtresult
        MOV AH,09h
        INT 21h
        
        MOV DL, hundreds
        ADD DL, 48
        MOV AH,02h
        INT 21h
        
        MOV DL, tens 
        ADD DL,48
        MOV AH,02h
        INT 21h
        
        MOV DL, ones
        ADD DL, 48
        MOV AH,02h
        INT 21h
              
        JMP START       
        
        MOV AH, 4Ch
        INT 21h
        
        CODE ENDS
END START