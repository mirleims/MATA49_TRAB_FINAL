section .note.GNU-stack

section .data
  msg db "Digite um número:", 0
  espaco db " ", 0
  intformat db "%ld", 0
  newline db 10 ; caractere de nova linha

section .bss
  numero resb 32

section .text
  global main
  extern printf, scanf

main:
  push rbp
  mov rbp, rsp

  mov rdi, msg
  call printf

  mov rdi, intformat
  mov rsi, numero
  call scanf

  mov rdi, [numero]

  ; Argumento (numero) em rdi
  ; Retorna o resultado em rax

  mov r8, 0
  mov r9, 1
  mov r10, rdi

  ; Caso base
  cmp r10, 0
  je .done
  cmp r10, 1
  je .done
  mov r12, 2

  ; Calcular Fibonacci iterativamente

.next:
  add r8, r9
  mov rdx, r9
  mov r9, r8

  ; Adiciona instruções de depuração
  mov rdi, intformat
  mov rsi, r12
  mov rax, 0
  call printf

  mov rdi, intformat
  mov rsi, r10
  mov rax, 0
  call printf

  push rdx
  call .imprime
  pop rdx

  add r12, 1
  cmp r12, r10
  jne .next  

.done:
  leave
  ret

.imprime:
  mov rdi, intformat
  mov rsi, rdx
  mov rax, 0
  call printf
  ; Adiciona um espaço após cada número impresso
  mov rdi, espaco
  call printf
  ret

