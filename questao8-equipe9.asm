;Componentes do grupo: Indaiara, Maiara, Liang, Pedro Miranda

section .data
message4: db "equilatero",10,0
message5: db "escaleno",10,0
message6: db "isosceles",10,0
section .bss

section .text
global main
extern printf
extern scanf

main: 
     push rbp
     mov rbp,rsp

     %define primeiro_lado(x,y) x-y
     mov rax, primeiro_lado(5,7)
     cmp rax, 0
     je iguais 
     jne diferentes

iguais:
  %define segundo_lado(x,y) x-y
  mov rax, segundo_lado(5,5)
  cmp rax, 0
  je equilatero
  jne isoceles


diferentes:
  %define terceiro_lado(x,y) x-y
  mov rax, terceiro_lado(5,8)
  cmp rax, 0
  je isoceles
  jne escaleno

escaleno:
   mov rdi, message5
   call printf
   jmp end
isoceles:
   mov rdi, message6
   call printf
   jmp end
equilatero:
   mov rdi, message4
   call printf
   jmp end

end:
leave 
ret

;nasm -felf64 main.asm -o main.o
;gcc main.o  -o main -no-pie -lm
;./main
