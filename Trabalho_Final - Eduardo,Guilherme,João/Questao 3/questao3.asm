; TRABALHO FINAL - QUESTÃO 03
; EDUARDO VITOR - 221215231
; GUILHERME BONFIM - 221115981
; JOÃO GONÇALVES PAES NUNES - 222215138


; informação
section .data
Titulo: db "Vamos calcular a área do Círculo",10,0
Opcao: db "Gostaria de Calcular a área do Circulo pelo raio ou diametro? ",0,10
raio: db "Qual o valor do raio: ",0
diametro: db "Qual o valor do diametro: ",0
scan: db "%s"
Resposta: db "O valor da Área do Círculo é %.2f ",10,0
scan1: dq "%lf"
pi: dq 3.14159265359
valor: dq 0.0
base: dq 2.0
escolha: db ""

section .text
  global main
  extern scanf, printf
main:

  push rbp
  mov rbp, rsp

  mov rdi, Titulo
  call printf

.falha:
  mov rdi,Opcao
  call printf

  mov rdi,scan
  mov rsi,escolha
  call scanf

  mov ecx,[escolha]
  
  cmp ecx, "raio"
  je .raios
  cmp ecx, "diametro"
  je .diametros
  jne .falha

  .raios:
    mov rdi,raio
    call printf

    mov rdi,scan1
    mov rsi,valor
    call scanf

    movq xmm0,[valor]
    movq xmm1,[valor]
    mulsd xmm0,xmm1
    movq xmm1,[pi]
    mulsd xmm0,xmm1

    mov rdi,Resposta
    call printf
    jmp .saida
    
  .diametros:
      mov rdi,diametro
      call printf

      mov rdi,scan1
      mov rsi,valor
      call scanf
      
      movq xmm0,[valor]
      movq xmm1,[base]
      divsd xmm0,xmm1
      movq xmm1,xmm0
      mulsd xmm0,xmm1
      movq xmm1,[pi]
      mulsd xmm0,xmm1

      mov rdi,Resposta
      call printf
    
.saida:
leave 
ret


;nasm -felf64 questao3.asm && gcc questao3.o && ./a.out