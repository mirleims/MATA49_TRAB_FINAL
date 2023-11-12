; TRABALHO FINAL - QUESTÃO 3
; ARTUR RODRIGUES MOTA - 221216931
; BRUNA ANUNCIACAO DE SANTANA - 221216927
; TAUANE HELOISE FIGUEIREDO OLIVEIRA - 221215985
; VICTORIA BEATRIZ SILVA DE AZEVEDO REIS - 221216928

; CÓDIGO

section .data
  raioValor dq 0.0 ; Armazena valor digitado pelo usuario p/ raio
  diametroValor dq 0.0 ; Armazena valor digitado pelo usuario p/ diam
  pi dq 3.14 ; Armazena valor de pi
  quatro dq 4.0 ; Armazena valor quatro p/ divisão
  ; Prompts para pedir ao usuário
  msgPedido db "Escolha uma opção: 1 (raio) ou 2 (diâmetro): ", 0
  raio db "Digite o raio: ",0
  diametro db "Digite o diametro: ",0
  ; Formatações para entrada e saída
  formatEntrada db "%d", 0
  format dq "%lf"
  areaFormat db "A área do círculo é: %lf", 0

section .bss
  escolha resb 1 ; Usado para escolha do usuário

section .text
  global main
  extern printf ; Responsavel por printar saida
  extern scanf ; Responsavel por pegar entrada

main:
  ; Necessario para o printf
  push rbp
  mov rbp, rsp

  ;Printando 1a msg
  mov rdi, msgPedido
  call printf

  ; Ler a escolha do usuário
  mov rdi, formatEntrada
  mov rsi, escolha
  call scanf

  ; Comparar a escolha, para usar jump p/ raio ou diametro
  mov rsi, [escolha]
  cmp rsi, 1
  je escolhaRaio
  cmp rsi, 2
  je escolhaDiametro

  escolhaRaio:
      mov rdi, raio ; Printa msg pedindo raio
      call printf
      mov rdi, format
      mov rsi, raioValor
      call scanf ; Pega valor do raio

      movq xmm0, [rsi] ; Coloca o valor do rsi (valor do raio) em xmm0
      mulsd xmm0, [rsi] ; multiplica raio vezes raio (r^2)
      mulsd xmm0, [pi] ; multiplica pi por (r^2)
      ; A = pi * (raio^2)
      
      mov rdi, areaFormat
      mov rax, 1
      call printf

      leave
      ret

  escolhaDiametro:
      mov rdi, diametro ; Printa msg pedindo diametro
      call printf
      mov rdi, format
      mov rsi, diametroValor
      call scanf ; Pega valor do diametro

      movq xmm0, [rsi] ; Coloca o valor do rsi (valor do diametro) em xmm0
      mulsd xmm0, [rsi] ; multiplica diam. vezes diam. (D^2)
      divsd xmm0, [quatro] ; divide D^2 por 4
      mulsd xmm0, [pi] ; multiplica pi por (D^2/4)
      ; A = pi * (Diametro^2/4)
      
      mov rdi, areaFormat
      mov rax, 1
      call printf
      
      leave
      ret
      
;nasm main.asm -f elf64 && gcc main.o -o main -no-pie && ./main