.MODEL SMALL

.DATA

MSG1 DB 'ENTER FIRST NUMBER: $'
MSG2 DB 0DH,0AH,'ENTER SECOND NUMBER: $'
MSG3 DB 0DH,0AH,'ENTER THIRD NUMBER: $'
MSG4 DB 0DH,0AH,'SUM IS: $'

.CODE 

MAIN PROC
            
     MOV AX,@DATA
     MOV DS,AX
     
     LEA DX,MSG1
     MOV AH,9
     INT 21H
     
     MOV AH,1
     INT 21H
     MOV BL,AL
     
     LEA DX,MSG2
     MOV AH,9
     INT 21H
     
     MOV AH,1
     INT 21H
     MOV BH,AL
     
     LEA DX,MSG3
     MOV AH,9
     INT 21H
     
     MOV AH,1
     INT 21H
     MOV CL,AL 
     
     
     ADD BL,BH
     ADD CL,BL
     SUB CL,48
     SUB CL,48
     
     LEA DX,MSG4
     MOV AH,9
     INT 21H
     
     MOV AH,2
     MOV DL,CL
     INT 21H 
   
  
    
    MAIN ENDP

END MAIN