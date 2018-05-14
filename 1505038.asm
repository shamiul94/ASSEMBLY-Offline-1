.MODEL SMALL

.STACK 100h

.DATA

;;;; NUMBERS AR 32 BIT SO, DX:AX WILL REPRESENT A , CX:BX WILL REPRESENT B 

TEMP1 DW ? 
TEMP2 DW ? 
NUMBER_A DW 2 DUP (0)
NUMBER_B DW 2 DUP (0)
OP DB 0
SIGN_A DB 0
SIGN_B DB 0
POINT_A DW 0
POINT_B DW 0
FLAG DB 0

OPP DB 0Ah,0Dh,'Operation: $'

FIRST DB 0Ah,0Dh,'Enter first number: $'
SECOND DB 0Ah,0Dh,'Enter second number: $'
SUM DB  0Ah,'The summation is: $'
DIFF DB 0Ah,'The difference is: $'
MULL DB 0Ah,'The multiplication is: $'

TEXT DB 'Welcome to Calculator v 1.0.',0Ah,0Dh,'$'
TEXT2 DB 'Press a to add, s to subtract, m to multiply and e to exit.',0Ah,0Dh,'$'
Not_Available DB 0Ah,0Dh,'Operation not available$'

.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,TEXT
    MOV AH,9
    INT 21h
	
	LEA DX,TEXT2
    MOV AH,9
    INT 21h
	
    ;;;;;;;;;;;;;;;
REPEAT_MAIN:
    
    MOV SIGN_A,0
    MOV SIGN_B,0
    MOV POINT_A,0
    MOV POINT_B,0
    
    LEA DX,OPP
    MOV AH,9
    INT 21h
    
    MOV AH,1
    INT 21h
    
    CMP AL,'e'
    JZ TERMINATE
    
    MOV OP,AL
    
    LEA DX,FIRST
    MOV AH,9
    INT 21h
    
    MOV FLAG,0
    CALL INPUT_A 
        
    LEA DX,SECOND
    MOV AH,9
    INT 21h
    
    MOV FLAG,0
    CALL INPUT_B 
    
    CALL LARGING
    
    MOV FLAG,1
    CMP POINT_A,0
    JNZ OP_NAME
    MOV FLAG,0

	
	
OP_NAME:    
    MOV AH,OP
    CMP AH,'a'
    JZ ADDITION
    CMP AH,'s'
    JZ SUBTRACTION
    CMP AH,'m'
    JZ MULTIPLICATION
    
    JMP Not_Available_OUTPUT
    
	
	
	
ADDITION:
    
    LEA DX,SUM
    MOV AH,9
    INT 21h
    
    MOV AH,SIGN_A
    OR AH,AH
    JZ CHECKSUM_B
    
    MOV DX,NUMBER_A[0]
    MOV AX,NUMBER_A[2]
    
    CALL NEG_FULL
    
    MOV NUMBER_A[0],DX
    MOV NUMBER_A[2],AX
    
	
	
CHECKSUM_B:
    
    MOV AH,SIGN_B
    OR AH,AH
    JZ DO_SUM
    
    MOV DX,NUMBER_B[0]
    MOV AX,NUMBER_B[2]
    
    CALL NEG_FULL
    
    MOV NUMBER_B[0],DX
    MOV NUMBER_B[2],AX

DO_SUM:
    
    MOV DX,NUMBER_A[0]
    MOV AX,NUMBER_A[2]
    
    MOV CX,NUMBER_B[0]
    MOV BX,NUMBER_B[2]
    
    CALL ADD_FULL
                
    MOV SIGN_A,0
    
    TEST DX,8000h
    JZ PRINT_SUM
    MOV SIGN_A,1
    
    CALL NEG_FULL
    
PRINT_SUM:
    
    CALL OUTDEC
    JMP REPEAT_MAIN

SUBTRACTION:
    
    LEA DX,DIFF
    MOV AH,9
    INT 21h
    
    MOV CH,SIGN_A
    OR CH,CH
    JZ CHECKSUB_B
    
    MOV DX,NUMBER_A[0]
    MOV AX,NUMBER_A[2]
    
    CALL NEG_FULL
    
    MOV NUMBER_A[0],DX
    MOV NUMBER_A[2],AX
    
CHECKSUB_B:

    
    MOV AH,SIGN_B
    OR AH,AH
    JNZ DO_SUM
    
    MOV DX,NUMBER_B[0]
    MOV AX,NUMBER_B[2]
    
    CALL NEG_FULL
    
    MOV NUMBER_B[0],DX
    MOV NUMBER_B[2],AX
    
    JMP DO_SUM 
       
MULTIPLICATION:
    
    MOV AX,2
    MUL POINT_A
    
    MOV POINT_A,AX
    
    LEA DX,MULL
    MOV AH,9
    INT 21h
    
    MOV AH,SIGN_A
    MOV AL,SIGN_B
    
    MOV SIGN_A,0
    
    CMP AH,AL
    JZ DO_MULL
    
    MOV SIGN_A,1
    
DO_MULL:
    
    MOV DX,NUMBER_A[0]
    MOV AX,NUMBER_A[2]
    
    MOV CX,NUMBER_B[0]
    MOV BX,NUMBER_B[2]
    
    CALL MULTIPLY_FULL
    
    CALL OUTDEC
   
NO_OUTPUT:
    
    JMP REPEAT_MAIN 
    
Not_Available_OUTPUT:
    
    LEA DX,Not_Available
    MOV AH,9
    INT 21h
    
    JMP REPEAT_MAIN     
    
TERMINATE:

    MOV AH,04Ch
    INT 21h

MAIN ENDP




;;;;



INPUT_A PROC
    
    MOV NUMBER_A[0],0
    MOV NUMBER_A[2],0
    XOR DI,DI

TAKE_A:    
    
    MOV AH,1
    INT 21h
    
    CMP AL,'-'
    JE NEG_A
    
    CMP AL,'.'
    JE POINT_FOUND_A
    
    CMP AL,0Dh
    JE END_A
    
    AND AL,0Fh
    
    XCHG NUMBER_A[0],DX
    XCHG NUMBER_A[2],AX
    
    XOR CX,CX
    MOV BX,10
    
    CALL MULTIPLY_FULL
    
    MOV BX,NUMBER_A[2]
    XOR BH,BH
    
    CALL ADD_FULL
    
    MOV NUMBER_A[0],DX
    MOV NUMBER_A[2],AX
    
    CMP FLAG,0
    JE TAKE_A
    
    INC POINT_A
    
    JMP TAKE_A

END_A:
    
    RET

NEG_A:
    
    MOV SIGN_A,AH
    JMP TAKE_A
    
POINT_FOUND_A:
    
    MOV FLAG,1
    JMP TAKE_A 
    
INPUT_A ENDP






INPUT_B PROC
    
    MOV NUMBER_B[0],0
    MOV NUMBER_B[2],0
    XOR DI,DI

TAKE_B:    
    
    MOV AH,1
    INT 21h
    
    CMP AL,'-'
    JE NEG_B
    
    CMP AL,'.'
    JE POINT_FOUND_B
    
    CMP AL,0Dh
    JE END_B
    
    AND AL,0Fh
    XCHG NUMBER_B[0],DX
    XCHG NUMBER_B[2],AX
    
    XOR CX,CX
    MOV BX,10
	
	
	
    CALL MULTIPLY_FULL
    
    MOV BX,NUMBER_B[2]
    XOR BH,BH
    
    CALL ADD_FULL
    
    MOV NUMBER_B[0],DX
    MOV NUMBER_B[2],AX
    
    CMP FLAG,0
    JE TAKE_B
    
    INC POINT_B
    
    JMP TAKE_B

END_B:
    
    RET

NEG_B:
    
    MOV SIGN_B,AH
    JMP TAKE_B

POINT_FOUND_B:

    MOV FLAG,1
    JMP TAKE_B 
    
INPUT_B ENDP  





NEG_FULL PROC
    
    NEG AX
    JC NEG_HIGH
    ADD DX,1
    
NEG_HIGH:
    
    NEG DX
    SUB DX,1
    
    RET
    
NEG_FULL ENDP




ADD_FULL PROC
    
    ADD AX,BX;
    JNC NOCARRY
    ADD DX,1

NOCARRY:
    
    ADD DX,CX
    
    RET
    
ADD_FULL ENDP



;;;;;;;;;;;;;;;;;;;;;;


MULTIPLY_FULL PROC
    
    PUSH CX
    PUSH BX
    PUSH TEMP1
    PUSH TEMP2    
    
    MOV TEMP1,0
    MOV TEMP2,0
    
WHILE_MUL:
   
    OR CX,CX
    JNZ WORK_MUL
    OR BX,BX
    JNZ WORK_MUL
	
    JMP END_MUL
    
WORK_MUL:
    
    TEST BX,1
    JZ SHIFT_MUL
    
    XCHG TEMP1,DX ; THIS TEMP_ARR WILL STORE RESULT IN THESE INTERMIDIATE STEPS. 
						;AT LAST WE WILL SWAP AX , DX WITH TEMPARR
    XCHG TEMP2,AX
    
    XCHG TEMP1,CX
    XCHG TEMP2,BX
	
	;xchg dx , cx 
	;xchg ax , bx
    
    CALL ADD_FULL
    
    XCHG TEMP1,DX
    XCHG TEMP2,AX
    
    XCHG DX,CX
    XCHG AX,BX    ; set to initial value all registers. 
    
SHIFT_MUL:

    SHL AX,1
    RCL DX,1
    
    SHR CX,1
    RCR BX,1
    
    JMP WHILE_MUL    
    
END_MUL:
    
    XCHG DX,TEMP1
    XCHG AX,TEMP2
    
    POP TEMP2
    POP TEMP1
    POP BX
    POP CX
    
    RET
    
MULTIPLY_FULL ENDP

;OUTPUT DECIMAL NUMBER DX:AX

OUTDEC PROC
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSHF
    
    MOV CL,SIGN_A
    OR CL,CL
    JZ S_OUT
    
    PUSH DX
    PUSH AX
    
    MOV AH,2
    MOV DL,'-'
    INT 21h  
    
    POP AX
    POP DX
    
S_OUT:
    
    MOV CX,10
    XOR DI,DI
    
WHILE_OUT:    

    OR DX,DX
    JNZ WORK_OUT
    OR AX,AX
    JNZ WORK_OUT
    JMP END_OUT

WORK_OUT:

    PUSH AX
    MOV AX,DX
    XOR DX,DX
    DIV CX
    MOV BX,AX
    POP AX
    DIV CX
    XCHG BX,DX
    PUSH BX
    INC DI
    
    DEC POINT_A
    JNZ JUST_WORK
    MOV BX,'.'
    PUSH BX
    INC DI
    
JUST_WORK:
    
    JMP WHILE_OUT
    
END_OUT:

    MOV CX,DI
    MOV AH,2

PRINT_DEC:

    POP DX
    
    CMP DX,'.'
    JZ DONTADD
    
    ADD DX,'0'

DONTADD:
    
    INT 21h
    LOOP PRINT_DEC
    
    POPF
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
    
OUTDEC ENDP

LARGING PROC
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    
    MOV AX,POINT_A
    MOV BX,POINT_B
    
    CMP AX,BX
    JZ END_LARGING
    JG B_LARGING
    JMP A_LARGING
    
A_LARGING:
    
    MOV DI,POINT_B
	
    SUB DI,POINT_A
	
    MOV AX,POINT_B
	
    MOV POINT_A,AX
    
    XOR CX,CX
    MOV BX,10
    
    MOV DX,NUMBER_A[0]
    MOV AX,NUMBER_A[2]

REPEAT_A_LARGING:
    
    CALL MULTIPLY_FULL
    DEC DI
    JNZ REPEAT_A_LARGING
    
    MOV NUMBER_A[0],DX
    MOV NUMBER_A[2],AX
    
    JMP END_LARGING 

B_LARGING:
    
    MOV DI,POINT_A
    SUB DI,POINT_B
    MOV AX,POINT_A
    MOV POINT_B,AX
    
    XOR CX,CX
    MOV BX,10
    
    MOV DX,NUMBER_B[0]
    MOV AX,NUMBER_B[2]

REPEAT_B_LARGING:
    
    CALL MULTIPLY_FULL
    DEC DI
    JNZ REPEAT_B_LARGING 
    
    MOV NUMBER_B[0],DX
    MOV NUMBER_B[2],AX
    
END_LARGING:
 
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    
LARGING ENDP

END MAIN