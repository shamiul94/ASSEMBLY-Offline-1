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
      
      
      MOV AH , 1 
    INT 21H 
    
    MOV CL , AL  
    
    
      ADD BH , BL 
      SUB BH , 48
      ADD BH , CH  
      SUB BH , 48
      ADD BH , CL 
      SUB BH , 48
      
               
               
              MOV AH , 2 
              MOV DL , 0DH 
              INT 21H 
              
              
    MOV AH , 2 
    MOV DL  , 0AH 
    INT 21H 
    
    MOV AH , 2
    MOV DL , BH  
    INT 21H 

MAIN ENDP 
END MAIN  