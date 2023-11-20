; MAURICIO MATCHAL
; TALITA ESTER
; JULIO CESAR

section .data
    formato_entrada: dq "%lf", 0
    mensagem:        db "Digite o valor em Fahrenheit:", 10, 0
    constante_1: dq 0.555
    constante_2: dq 32.0
    resultado:     dq "O resultado é: %lf", 10, 0

section .bss
    graus_F resq 1
    graus_C resq 1

section .text
    global main
    extern scanf
    extern printf

conversor:
    movsd xmm0, [graus_F]   
    subsd xmm0, [constante_2] 
    mulsd xmm0, [constante_1] 
    movsd [graus_C], xmm0    
    ret

main:
    push rbp
    mov rbp, rsp

    mov rdi, mensagem
    call printf

    mov rdi, formato_entrada
    mov rsi, graus_F
    call scanf

    call conversor

    mov rdi, resultado
    movsd xmm1, [graus_C]
    call printf

    leave
    ret

; clear && nasm -f elf64 questao1.asm && gcc questao1.o -o questao1 -no-pie && ./questao1
