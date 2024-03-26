section .data
    newline db 10

section .bss
    buffer resb 1

section .text
    global _start

_start:
    ;input
    mov eax, 3          
    mov ebx, 0           
    mov ecx, buffer     
    mov edx, 1          
    int 0x80             

    ;convert into uppercase
    mov al, [buffer]     
    add al, 32           
    mov [buffer], al     

    ;print the uppercase character
    mov eax, 4           
    mov ebx, 1           
    mov ecx, buffer      
    mov edx, 1          
    int 0x80             

    ;Read
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
;nasm -f elf MP4.asm
;ld -m  elf_i386 MP4.o -o MP4
;./MP4
