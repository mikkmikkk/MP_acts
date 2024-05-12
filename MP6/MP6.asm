section .bss
    buffer resb 100

section .data
    input db 'Input Plaintext: ', 0

section .text
    global _start

_start:
    mov eax, 4          
    mov ebx, 1          
    mov ecx, input      
    mov edx, 16         
    int 0x80            

    mov eax, 3          
    mov ebx, 0          
    mov ecx, buffer     
    mov edx, 100        
    int 0x80           

    mov ecx, 100        
    xor esi, esi

encrypt_loop:
    mov al, [buffer + esi]

    cmp al, 'A'
    jl check_lower_case
    cmp al, 'Z'
    jg check_lower_case

    sub al, 'A'
    add al, 3
    and al, 0x1F
    add al, 'A'
    jmp encrypted

check_lower_case:
    cmp al, 'a'
    jl check_non_alphabetic
    cmp al, 'z'
    jg check_non_alphabetic

    sub al, 'a'
    add al, 3
    and al, 0x1F
    add al, 'a'
    jmp encrypted

check_non_alphabetic:
    jmp encrypted

encrypted:
    mov [buffer + esi], al
    inc esi
    loop encrypt_loop

    mov eax, 4          
    mov ebx, 1          
    mov ecx, buffer     
    mov edx, 100       
    int 0x80            
    
    mov eax, 1          
    xor ebx, ebx        
    int 0x80            


;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf MP6.asm
;ld -m  elf_i386 MP6.o -o MP6
;./MP6