TITLE BINTOHEX

DATA SEGMENT 

    hex_num1 db 0 
    hex_num2 db 0     
    bin_msg db "Give an 8-bit binary number: $"
    hex_msg db 10,13,"The result is: $"
    
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    
    bin_to_hex:
        mov cx,3 
        
        call input_msg
        call bintohex
    
    output: 
        call output_hex    
        
    exit: 
        mov ah,4ch
        int 21h
        
    input_msg proc   
        lea dx,bin_msg
        mov ah,09h
        int 21h
        ret
    input_msg endp 
        
    bintohex proc 
       first4bit_input:
       mov dx,0
       loop1:        
           mov ah,01h
           int 21h
           cmp al,49
           ja exit
           sub al,30h
           shl al, cl
           add dl,al     
       loop loop1 
       mov ah,01h
       int 21h 
       sub al,30h  
       add dl,al
       
       mov hex_num1,dl   
       
       second4bit_input:  
       mov dx,0 
       mov cx,3 
       loop2:
           mov ah,01h
           int 21h
           sub al,30h
           shl al, cl
           add dl,al 
       loop loop2 
        
       mov ah,01h
       int 21h 
       sub al,30h  
       add dl,al
    
       mov hex_num2,dl
       
    bintohex endp
        
    output_hex proc  
        lea dx, hex_msg
        mov ah,09
        int 21h
        
        cmp hex_num1, 9
        ja print1
        add hex_num1,30h
        jmp continue_hex1
        
        print1:
        add hex_num1, 55
        
        continue_hex1:
        mov dl,hex_num1
        mov ah,02
        int 21h 
        
        cmp hex_num2, 9
        ja print2
        add hex_num2,30h
        jmp continue_hex2
        
        print2:
        add hex_num2, 55
        
        continue_hex2:
        mov dl,hex_num2
        mov ah,02
        int 21h
        
        jmp exit
    
CODE ENDS
END START    