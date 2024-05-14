section .bss
    buffer resb 100          

section .data
    input db 'Input Plaintext: ', 0
    encrypted_msg db 'Encrypted: ', 0

section .text
    global _start

_start:
    mov eax, 4               
    mov ebx, 1               
    mov ecx, input          
    mov edx, 18              
    int 0x80                

    mov eax, 3              
    mov ebx, 0               
    mov ecx, buffer        
    mov edx, 100             
    int 0x80                

    mov esi, buffer          
encrypt_loop:
    mov al, byte [esi]      

    cmp al, 'A'
    jl check_lower_case
    cmp al, 'Z'
    jg check_lower_case

    add al, 13              
    cmp al, 'Z'
    jbe skip_wrap           
    sub al, 26            

check_lower_case:
    cmp al, 'a'
    jl check_non_alphabetic
    cmp al, 'z'
    jg check_non_alphabetic

    
    add al, 13              
    cmp al, 'z'
    jbe skip_wrap           
    sub al, 26               

check_non_alphabetic:
    cmp al, 0
    je end_encryption       
    jmp encrypted            

skip_wrap:

encrypted:
    mov byte [esi], al       
    inc esi                 
    jmp encrypt_loop       

end_encryption:

   mov eax, 4          
    mov ebx, 1          
    mov ecx, encrypted_msg    
    mov edx, 10        
    int 0x80   
    
    mov eax, 4              
    mov ebx, 1               
    mov ecx, buffer         
    mov edx, 100            
    int 0x80                 

    ; Exit the program
    mov eax, 1              
    xor ebx, ebx             
    int 0x80                 
 
;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf ROT_13.asm
;ld -m  elf_i386 ROT_13.o -o ROT_13
;./ROT_13
