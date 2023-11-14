; Alunos: Daniel Gomes, Matheus Souto, Caio Mendes e Fabio Tosta

%macro triangulo 3
    cmp %1, %2
    je .triangulo_check_second
    cmp %2, %3
    je .triangulo_set_isosceles
    cmp %1, %3
    je .triangulo_set_isosceles
    mov rdi, formato_saida
    mov rsi, escaleno
    jmp .triangulo_end

.triangulo_check_second:
    cmp %2, %3
    je .triangulo_set_equilatero
    mov rdi, formato_saida
    mov rsi, isosceles
    jmp .triangulo_end

.triangulo_set_equilatero:
    mov rdi, formato_saida
    mov rsi, equilatero
    jmp .triangulo_end

.triangulo_set_isosceles:
    mov rdi, formato_saida
    mov rsi, isosceles

.triangulo_end:
%endmacro
section .note.GNU-stack

section .data
    formato db "%lf %lf %lf", 0          ; Formato para scanf
    formato_saida db "Triangulo: %s", 0  ; Formato para o printf
    equilatero db "Equilatero", 0
    isosceles db "Isosceles", 0
    escaleno db "Escaleno", 0

section .bss
    l1 resq 1
    l2 resq 1
    l3 resq 1

section .text
global main
extern printf, scanf

main:
  push rbp
  mov rbp, rsp


    mov rdi, formato
    mov rsi, l1
    mov rdx, l2
    mov rcx, l3
    call scanf

    ; Chama o macro triangulo
    mov rdi, [l1]
    mov rsi, [l2]
    mov rdx, [l3]
    call triangulo rdi , rsi , rdx
    call printf

  leave
  ret