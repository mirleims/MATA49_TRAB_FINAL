; PARA RODAR
;nasm -f elf64 a.asm
;gcc a.o -o a -no-pie
;./a


section .note.GNU-stack

section .data
  msg db 'Insira 0 para receber o raio ou 1 para receber o diâmetro:', 10, 0
  tam_msg equ $ - msg
  msg2 db 'Insira o raio:', 10, 0
  tam_msg2 equ $ - msg2
  msg3 db 'Insira o diâmetro:', 10, 0
  tam_msg3 equ $ - msg3
  msg4 dq "A área do círculo é: %lf", 0
  msg5 db "Ou é zero, ou é um cabeça", 10, 0
  
  fmti db "%d", 0
  fmtf dq "%lf", 0

  pi dq 3.1415, 0
  dois dq 2.0, 0


section .bss
  esco resb 1
  raio resq 16
  resu resq 16

section .text
  global main
  extern printf
  extern scanf

main:
  push rbp
  mov rbp, rsp 

  mov rdi, msg
  call printf

  mov rdi, fmti
  mov rsi, esco
  call scanf

  cmp byte [esco], 0
  je recebe_raio
  cmp byte [esco], 1
  je recebe_diametro
  
  mov rdi, msg5
  call printf
  
  leave
  ret

recebe_raio:
  mov rdi, msg2
  call printf

  mov rdi, fmtf
  mov rsi, raio
  call scanf
  
  jmp fim

recebe_diametro:
  mov rdi, msg3
  call printf

  mov rdi, fmtf
  mov rsi, raio
  call scanf

  movq xmm0, [raio]
  movq xmm1, [dois]
  divsd xmm0, xmm1
  movq [raio], xmm0

  
  jmp fim

fim:
  movq xmm0, [raio]
  movq xmm1, [pi]
  mulsd xmm0, xmm0
  mulsd xmm0, xmm1
  
  mov rdi, msg4
  call printf
  
  leave
  ret







