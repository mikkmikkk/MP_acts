
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

   ;not finish yet

exit_program:
    mov eax, 1        ; sys_exit syscall number
    xor ebx, ebx      ; return status 0
    int 0x80          ; invoke syscall      


;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf Online_Review.asm
;ld -m  elf_i386 Online_Review.o -o Online_Review
;./Online_Review