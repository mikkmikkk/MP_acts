
section .data
    input_user db  'Enter your password: ', 0
    weak_msg db    'Weak password.', 0
    strong_msg db  'Strong password.', 0
    invalid_msg db 'Invalid input. Password must be at least 1 character long.', 0
    newline db 10

section .bss
    input resb 20  

section .text
    global _start

_start:
   mov eax, 4     
    mov ebx, 1      
    mov ecx, input_user  
    mov edx, 20      
    int 0x80        
    mov eax, 3       
    mov ebx, 0       
    mov ecx, input
    mov edx, 20      
    int 0x80         

   mov esi, password  
   mov edi, esi
   xor ecx, ecx      

check_length_loop:
    cmp byte [edi], 0 
    je end_check_length
    inc ecx          
    inc edi           
    jmp check_length_loop

end_check_length:
    cmp ecx, 1        
    jg check_strength 
    mov eax, 4        
    mov ebx, 1        
    mov ecx, invalid_msg  
    mov edx, 36       
    int 0x80          
    
   
    jmp exit_program


check_strength:
    cmp ecx, 8       
    jl weak_password  
    mov eax, 4       
    mov ebx, 1        
    mov ecx, strong_msg 
    mov edx, 16      
    int 0x80          
    
    
    jmp exit_program


weak_password:
    mov eax, 4        
    mov ebx, 1        
    mov ecx, weak_msg 
    mov edx, 14       
    int 0x80          

exit_program:
    mov eax, 1        
    xor ebx, ebx      
    int 0x80   


;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf Online_Review.asm
;ld -m  elf_i386 Online_Review.o -o Online_Review
;./Online_Review
