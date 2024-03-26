section .data
    newline db 10   

section .bss
    buffer resb 1

section .text
    global _start

_start:
    ; Read a character from stdin
    mov eax, 3          
    mov ebx, 0           
    mov ecx, buffer     
    mov edx, 1         
    int 0x80        

    
    cmp byte [buffer], '@'
    jg possible_uppercase

    cmp byte [buffer], 'A'
    jl end_program

    cmp byte [buffer], 'z'
    jg end_program


   
    
possible_uppercase:

    cmp byte [buffer], 'Z'
    jg possible_lowercase


    add byte [buffer], 32 

    cmp byte [buffer], '`'
    jg end_program

    


possible_lowercase:

    cmp byte [buffer], 'a'
    jl end_program
    cmp byte [buffer], 'z'
    jg end_program

    sub byte [buffer], 32   


end_program:

    mov eax, 4          
    mov ebx, 1          
    mov ecx, buffer      
    mov edx, 1         
    int 0x80

    mov eax, 4          
    mov ebx, 1        
    mov ecx, newline  
    mov edx, 1  
    int 0x80




    ; Exit the program
    mov eax, 1           ; sys_exit system call number
    xor ebx, ebx         ; exit code 0
    int 0x80             ; invoke system call              


;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf MP5.asm
;ld -m  elf_i386 MP5.o -o MP5
;./MP5