.MODEL SMALL 
.STACK 100H 

.DATA 

.CODE 

MAIN PROC 
MOV AX , @DATA
MOV DS , AX           



XOR BL , BL 
MOV CL , 4 

MOV AH , 1 
INT 21H 


WHILE_: 


CMP AL , 30H 
JL END_WHILE 


CMP AL , 39H 
JG LETTER 


AND AL , 0FH 
JMP SHIFT 

LETTER: 

SUB AL , 37H   


SHIFT: 
SHL BL , CL 
OR BL , AL 

INT 21H 
JMP WHILE_   

END_WHILE:    

MOV AH , 2
MOV DL , 0DH    
INT 21H  

MOV AH , 2
MOV DL , 0AH    
INT 21H 




MOV CX , 8 
TOP:
ROL BL , 1 

JNC NEXT0 
JC NEXT1 


NEXT0: MOV DL, 48 
MOV AH , 2 
INT 21H  
LOOP TOP 

NEXT1:  MOV DL, 49 
MOV AH , 2 
INT 21H  
LOOP TOP


 


MAIN ENDP 
END MAIN 
