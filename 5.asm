.MODEL SMALL 

.DATA 

.CODE 

MAIN PROC
     
   MOV CL , 56
   
   MOV AH , 2 
   MOV DL , CL 
   INT 21H  
    

MAIN ENDP 
END MAIN  