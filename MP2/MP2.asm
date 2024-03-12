section .data
  
    line5 db '  /*\', 10
    line6 db ' / | \', 10
    


section .text
    global _start

_start:
   

    ; Print line 5
    mov eax, 4
    mov ebx, 1
    mov ecx, line5
    mov edx, 14 ; 
    int 0x80
    

     
   
    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

;sudo apt-get update
;sudo apt-get -y install nasm
;nasm -f elf MP2.asm
;ld -m  elf_i386 MP2.o -o MP2
;./MP2