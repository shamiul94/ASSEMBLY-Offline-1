.MODEL SMALL  
.STACK 100H 

.DATA     

MSG1 DB 'ENTER SMALL CASE LETTER: $' 
msg2 db 'UPPER CASE LETTER IS: $' 

.CODE 


MAIN PROC    



MOV AX , @DATA              ; ??? KENO ??? 
MOV DS , AX 


MOV AH , 9
LEA DX , MSG1 
INT 21H   



MOV AH , 1 
INT 21H  


MOV BL , AL 


MOV AH , 2       
MOV DL , 0AH 
INT 21H 


MOV DL , 0DH 
INT 21H


SUB BL , 'a' 
ADD BL , 'A'  


MOV AH , 9
LEA DX , MSG1 
INT 21H   



MOV AH , 2 
MOV DL , BL 
INT 21H    



MOV AH , 2       
MOV DL , 0AH 
INT 21H 



MOV DL , 0DH 
INT 21H 



MOV AH , 4CH ;; *********   
INT 21H  



MAIN ENDP 

END MAIN 
