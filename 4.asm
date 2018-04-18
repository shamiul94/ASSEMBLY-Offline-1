.MODEL SMALL 
.STACK 100H 

.DATA 

MSG1 DB 'Enter 1st Number:$' 
MSG2 DB 'Enter 2nd Number:$'
MSG3 DB  'You have entered:$' 
MSG4 DB 'After swapping:$'


.CODE 

MAIN PROC  

MOV AX, @DATA 
MOV DS, AX 

MOV AH , 9 
LEA DX , MSG1 
INT 21H 


MOV AH , 1     
INT 21H 
MOV CH , AL       

MOV AH , 2 
MOV DL , 0AH 
INT 21H 

MOV DL , 0DH 
INT 21H 


MOV AH , 9 
LEA DX , MSG2 
INT 21H 


MOV AH , 1  
INT 21H 
MOV CL , AL 
MOV AH , 2 
MOV DL , 0AH 
INT 21H 

MOV DL , 0DH 
INT 21H 


MOV AH , 9 
LEA DX , MSG3 
INT 21H 


MOV AH , 2 
MOV DL , CH 
INT 21H 

MOV DL , ' ' 
INT 21H 

MOV DL , CL 
INT 21H 



;XCHG CH , CL 


ADD CH , CL 

NEG CL  
ADD CL , CH 

SUB CH , CL 


MOV AH , 2 
MOV DL , 0AH 
INT 21H 

MOV DL , 0DH 
INT 21H    


MOV AH , 9 
LEA DX , MSG4 
INT 21H   



MOV AH , 2 
MOV DL , CH 
INT 21H 

MOV DL , ' ' 
INT 21H 

MOV DL , CL 
INT 21H 


MOV AH , 2 
MOV DL , 0AH 
INT 21H 

MOV DL , 0DH 
INT 21H 

MOV AH , 4CH  
INT 21H



MAIN ENDP 

END MAIN 