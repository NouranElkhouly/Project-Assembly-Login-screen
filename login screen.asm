
include emu8086.inc
.MODEL SMALL
.DATA   
        SIZE EQU 10
        HEAD DB '_login screen_','$'
        MSG1 DB 13, 10, 'enter username:$'
        MSG2 DB 13, 10, 'enter password:$'
        MSG3 DB 13, 10, 'ERROR username not Found!!!!!$'
        MSG4 DB 13, 10, 'wrong Password!!!!$'
        MSG5 DB 13, 10, 'correct! welocome , Hiiiii$'
        MSG6 DB 13, 10, 'too Long password!!!$'
        TEMP_user DW 1 DUP(?),0
        TEMP_Pass DB 1 DUP(?)
        userSize = $-TEMP_user
        PassSize = $-Temp_Pass
        user  DW        'nour', 'yara', 'amr', 'lala', 'ali', 'nada', 'lela', 'lolo', 'eman', 'adel' 
        Password DB   2,      6,      3,      4,       7,     10,     11,     13,     12,      14
    
.CODE
MAIN        PROC
            MOV AX,@DATA  
            MOV DS,AX
            MOV AX,0000H
            

Title:      LEA DX,HEAD
            MOV AH,09H
            INT 21H

user_PROMPT:  LEA DX,MSG1
            MOV AH,09H
            INT 21H
            
            
user_INPUT:   MOV BX,0
              MOV DX,0
              LEA DI,TEMP_user
              MOV DX,userSize
              CALL get_string
            

Checkuser:    MOV BL,0
              MOV SI,0

AGAIN:      MOV AX,user[SI] 
            MOV DX,TEMP_user
            CMP DX,AX
            JE  PASS_PROMPT
            INC BL
            ADD SI,4
            CMP BL,SIZE
            JB  AGAIN
            
ERRORMSG:   LEA DX,MSG3
            MOV AH,09H
            INT 21H
            JMP user_PROMPT
             
            
PASS_PROMPT:LEA DX,MSG2
            MOV AH,09H
            INT 21H
            
Pass_INPUT: CALL   scan_num
            CMP    CL,0FH
            JAE    TooLong
            MOV    BH,00H
            MOV    DL,Password[BX]
            CMP    CL,DL
            JE     CORRECT 

            
INCORRECT:  LEA DX,MSG4
            MOV AH,09H
            INT 21H
            JMP user_PROMPT
            
CORRECT:    LEA DX,MSG5
            MOV AH,09H
            INT 21H
            JMP Terminate

TooLong:    LEA DX,MSG6
            MOV AH,09H
            INT 21H
            JMP PASS_PROMPT
            

DEFINE_SCAN_NUM
DEFINE_GET_STRING
Terminate:        
END MAIN        