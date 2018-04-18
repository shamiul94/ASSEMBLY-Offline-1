.MODEL SMALL

.STACK 1000h

.DATA
    s   db 'a','b','c','d','e',
                db 'f','g','h','i','j','k',
                db 'l','m','n','o','p','q',
                db 'r','s','t',,'u','v','w',
                db 'x','y','z','$'


a dw ?
.CODE
main: 

    mov ax, @data
    mov ds, ax 
    
    mov ah , 1 
    int 21h 
    
    mov cl , al 
    mov ch , 0 
               
               

    sub cx ,97

    mov ah , 9
   
    lea dx , s     
    add dx , cx
    
    int 21h 

    mov ax, 4Ch
    int 21h 
   main endp
END main
