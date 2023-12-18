;2031 DIMITRIOS CHARISTES    
   
#start=led_display.exe#       
TITLE HEX2BIN_LED

DATA SEGMENT
    
    count db 0
    hex_num db 10,13, "Input the hex number (exit by typing "."): $"
    bin_result db 10,13, "In binary: $"
    
    DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
         
            call get_two_hex_digits
            call output_value_to_display
            
        EXIT:
            MOV AH, 4Ch
            INT 21h   
            
        get_two_hex_digits proc 
            
            mov count,0
            call get_one_hex_digit 
            mov count,1
            call get_one_hex_digit
            ret                   
            
        get_two_hex_digits endp
            
        get_one_hex_digit proc
            hex_to_bin:
                cmp count,1
                je input
                lea dx, hex_num
                mov ah,09
                int 21h
                
                mov bx, 0
                
            input:
            
                mov ah,08h
                int 21h
                
                cmp al,"."
                je EXIT
                
                
            skip:
            
                cmp al,"A"
                jl decimal
            
                cmp al, "F"
                jg input
            
                mov dl,al
                mov ah,02h
                int 21h
            
                add al,09h
                jmp process
            
            decimal: 
                cmp al,39h
                jg input
                
                cmp al,30h
                jl input
                
                mov dl,al
                mov ah,02h
                int 21h
                
                jmp process
                
            process:
            
                and al,0Fh
                mov cl, 04
                shl al,cl
                
            loop1:
                
                shl al,1
                rcl bx,1
                
                loop loop1
                
            END:
                ret
                
            get_one_hex_digit endp  
        
        output_value_to_display proc 
            mov ax,0
            push ax
            lea dx, bin_result
            mov ah,09
            int 21h
            
            mov cx,08
            
            
        loop2:
            
            pop ax
            shl bl,01
            jc one
            
            mov dl,30h 
            shl al,1 
            out 199,ax
            jmp display
        
        one:
        
            mov dl,31h  
            rcl al,1 
            out 199,ax
            
        display:
            push ax
            mov ah,02
            int 21h
            loop loop2
            pop ax
            ret
       output_value_to_display endp
        
       jmp EXIT
        
CODE ENDS
END START
            
            
        
        
            
                
