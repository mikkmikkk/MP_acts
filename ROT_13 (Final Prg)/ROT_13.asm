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

    sub al, 'A'             ; Convert ASCII character to zero-based index
    add al, 13              ; Add 13 to shift by 13 positions
    cmp al, 26              ; Check if the result is greater than 25 (outside the range of alphabetic characters)
    jle skip_subtraction    ; If not, skip the subtraction

    sub al, 26              ; Subtract 26 to bring the result back into the range of alphabetic characters

check_lower_case:
    cmp al, 'a'
    jl check_non_alphabetic
    cmp al, 'z'
    jg check_non_alphabetic

   sub al, 'a'
    add al, 13        ; Add 13 to shift by 13 positions
    cmp al, 26        ; Check if the result is greater than 25 (outside the range of alphabetic characters)
    jle skip_subtraction    ; If not, skip the subtraction
    sub al, 26        ; Subtract 26 to bring the result back into the range of alphabetic characters

skip_subtraction:
    and al, 0x1F     ; Ensure the result stays within the range of alphabetic characters (0 to 25)
    add al, 'a'      ; Convert the zero-based index back to ASCII character
    jmp encrypted    ; Jump to the encrypted label

check_non_alphabetic:
    jmp encrypted

encrypted:
    mov [buffer + esi], al
    inc esi
    loop encrypt_loop  

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
    
    mov eax, 1          
    xor ebx, ebx        
    int 0x80            

;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf ROT_13.asm
;ld -m  elf_i386 ROT_13.o -o ROT_13
;./ROT_13