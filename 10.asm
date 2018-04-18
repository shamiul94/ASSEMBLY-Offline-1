.MODEL SMALL 

.DATA 

.CODE 

MAIN PROC
     
   MOV AX , 2 
   MOV BX , 3 
   
   MOV CX , 0 
   ADD CX , AX 
   ADD CX , BX    
   
   
   MOV AH , 4CH 
   INT 21H 
   

MAIN ENDP 
END MAIN  