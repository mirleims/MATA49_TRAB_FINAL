; Alunos: Daniel Gomes, Matheus Souto, Caio Mendes e Fabio Tosta

section .data
    mensagemUm db "Digite a temperatura em graus Fahrenheit:  ", 0
    mensagemResultado dq "A temperatura em graus Celsius é: %.3f", 0
    
    fmt dq "%lf"
    constanteSubtracao dq 32.0
    divisao dq 1.8
    
section .bss
    temperatura resq 1
    resultado resq 1

section .text

    global main
    extern scanf 
    extern printf 

main:   

    push rbp
    mov rbp, rsp 

    mov rdi, mensagemUm
    call printf 

    mov rdi, fmt
    lea rsi, [temperatura]
    call scanf

    movq xmm0, [temperatura]
    movq xmm1, [constanteSubtracao]
    movq xmm4, [divisao]

    subsd xmm0, xmm1
    divsd xmm0, xmm4

    movq [resultado], xmm0
    
    mov rdi, mensagemResultado
    mov rsi, [resultado]
    call printf
    
    leave 
    ret


