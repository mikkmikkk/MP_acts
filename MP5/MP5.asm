section .bss
    buffer resb 1
   
   section .data
    newline db 10

section .text
    global _start

_start:
    ; Read a character from stdin
    mov eax, 3           
    mov ebx, 0           
    mov ecx, buffer      
    mov edx, 1           
    int 0x80             

    
    cmp byte [buffer], 'A'
    jl if_lowercase
    cmp byte [buffer], 'Z'
    jg if_lowercase

    add byte [buffer], 32
    
    
    jmp display



if_lowercase:
    cmp byte [buffer], 'a'
    jl display
    cmp byte [buffer], 'z'
    jg display

    sub byte [buffer], 32
    
    jmp display


display:
    ; Display the entered character
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
    mov eax, 1           
    xor ebx, ebx         
    int 0x80          


;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf MP5.asm
;ld -m  elf_i386 MP5.o -o MP5
;./MP5
