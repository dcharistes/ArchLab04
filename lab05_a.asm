TITLE BIN2HEX
 
DATA SEGMENT  
    
    bin_num db 'Give an 8bit binary number:',' $'
    hex_num db 10,13,'The hex number is: $'
    
DATA ENDS 

CODE SEGMENT  
    START:
        MOV AX,@DATA
        MOV DS, AX  

        
    bin_to_hex:
        
        CALL display_msg 
        CALL input_bin       
        
    output_hex:         
        CALL display_hex_msg
        CALL binarytohex  
        
        JMP bin_to_hex
        
    EXIT:
        MOV AH,4Ch
        INT 21h         
        
        
    display_msg proc 
        LEA DX, bin_num  
        MOV AH,09h
        INT 21h
        ret 
        
    display_msg endp

    input_bin proc
        MOV AX,0
        MOV BX,0
        MOV CX,0
        MOV DX,0  
        
    input_bin2:
        CMP CX,08
        JE output_hex
        
        MOV AH,08h
        INT 21h
        
        CMP AL,"."     
        JE EXIT1
        
        CMP AL,48
        JNE binary_check  
        
        MOV DL,AL
        MOV AH,02h
        INT 21h
        
        INC CX 
    
    binary_continue:
        SUB AL,48
        SHL BX,1
        OR BL,AL
        JMP input_bin2
    
    binary_check:
        CMP AL,49
        JNE input_bin2  
        
        MOV DL,AL
        MOV AH,02h
        INT 21h
        INC CX   
        
        JMP binary_continue
    
    EXIT1:
        call EXIT      
    input_bin endp
    
    display_hex_msg proc
        mov ah,09
        lea dx, hex_num
        int 21h
        ret
        display_hex_msg endp
    
    binarytohex proc 
        MOV DX,0 
        MOV CL,1
        MOV CH,0
                               
        output_hex2:
            cmp ch,02
            je EXIT1
            inc ch
            
            mov dl,bl
            shr dl,04
            
            cmp dl,0Ah
            jl hex_digit
            
            add dl,37h
            mov ah,02
            int 21h
            rol bx,04
            
            jmp output_hex2  
            
        hex_digit:  
            add dl,30h
            mov ah,02
            int 21h
            rol bx,04
            
            jmp output_hex2
               
        binarytohex endp   
          
CODE ENDS   
END START