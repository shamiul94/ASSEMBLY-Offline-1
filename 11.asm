.MODEL SMALL 

.DATA 

.CODE 

MAIN PROC
     
    MOV AH , 1 
    INT 21H 
    
    MOV BH , AL 
    
     MOV AH , 1 
    INT 21H 
    
    MOV BL , AL 
    
     MOV AH , 1 
    INT 21H 
    
    MOV CH , AL 
    
    
    SUB BH , BL 
    ADD BH , CH      
    
    MOV AH , 2 
    MOV DL  , 0AH 
    INT 21H 
    
    MOV AH , 2
    MOV DL , BH  
    INT 21H 

MAIN ENDP 
END MAIN  