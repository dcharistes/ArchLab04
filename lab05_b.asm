TITLE HEX2BIN

DATA SEGMENT
    
    count db ?
    num1 db 0
    num2 db 0
    hex_num db 10,13, "Input the hex number: $"
    bin_result db 10,13, "In binary: $"
    
    DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
        
        HEX2BIN:
            call hextobin
            
            call disp_bin
            
        EXIT:
            MOV AH, 4Ch
            INT 21h
            
        hextobin proc
            hex_to_bin:
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
                mov cx,04
                
            loop1:
                
                shl al,1
                rcl bx,1
                
                loop loop1
                
            END:
                ret
                
            hextobin endp  
        
        disp_bin proc
            
            lea dx, bin_result
            mov ah,09
            int 21h
            
            mov cx,08
            mov ah,02
            
        loop2:
        
            shl bl,01
            jc one
            
            mov dl,30h  
            jmp display
        
        one:
        
            mov dl,31h
            
        display:
        
            int 21h
            loop loop2
            
            ret
       disp_bin endp
        
       jmp EXIT
        
CODE ENDS
END START
            
            
        
        
            
                