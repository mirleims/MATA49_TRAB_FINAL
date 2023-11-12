; TRABALHO FINAL - QUESTÃO 1
; ARTUR RODRIGUES MOTA - 221216931
; BRUNA ANUNCIACAO DE SANTANA - 221216927
; TAUANE HELOISE FIGUEIREDO OLIVEIRA - 221215985
; VICTORIA BEATRIZ SILVA DE AZEVEDO REIS - 221216928

; CÓDIGO

section .data 
  temperatura dq 0.0 ; Armazena o valor da temperatura digitada pelo usuário  
  valorSub dq 32.0 ; Armazena o valor para a subtração na formula
  valorMul dq 5.0 ; Armazena o valor para a multiplicação
  valorDiv dq 9.0 ; Armazena o valor para a divisão
  
  ; Prompt para pedir ao usuario
  mensagemInicial db "Digite a temperatura em Fahrenheit: ", 0
  
  ; Formatações para entrada e saida
  fmtEntrada db "%d", 0
  fmt dq "%lf"
  mensagemCelsius db "A temperatura em Celsius é: %lf", 0

section .text 
  global main
  extern printf ; Responsavel por printar saida
  extern scanf ; Responsavel por pegar entrada

main:
  ; Necessario para o printf
  push rbp
  mov rbp, rsp

  ; Printando a mensagem para o usuario
  mov rdi, mensagemInicial
  call printf

  ; Ler o valor da temperatura digitado
  mov rdi, fmt
  mov rsi, temperatura
  call scanf

  ; Calcula a formula de conversão (fahrenheit - 32) * 5/9
  movq xmm0, [rsi] ; Colocar o valor rsi (temperatura em fahrenheit) em xmm0
  subsd xmm0, [valorSub] ; Subtrai 32 do valor em xmm0 (fahrenheit - 32)
  mulsd xmm0, [valorMul] ; Multiplica o valor em xmm0 por 5
  divsd xmm0, [valorDiv] ; Divide o valor por 9

  ; Printa a mensagem final com o valor convertido para Celsius
  mov rdi, mensagemCelsius
  mov rax, 1
  call printf 

  leave 
  ret

;nasm main.asm -f elf64 && gcc main.o -o main -no-pie && ./main