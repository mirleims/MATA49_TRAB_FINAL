;Caio Adriel Barbosa dos Santos - 222215084
;Francisco Silva Santana - 222216228
;João Francisco Ioris Dear - 222215080
;Lucas Sampaio Souza Andrade - 220115578
;nasm -f elf64 main.asm & gcc main.o -o main -no-pie && ./main

bits 64

section .bss
    l1 resq 1
    l2 resq 1
    l3 resq 1
        
section .data
    prompt0 db 10, "Descubra o tipo do triângulo a partir do tamanho dos lados!", 10, 10, 0
    prompt1 db "Digite o tamanho do lado 1: ", 0
    prompt2 db "Digite o tamanho do lado 2: ", 0
    prompt3 db "Digite o tamanho do lado 3: ", 0

    text_inexistente db 10, "O triângulo não existe!", 10, 0
    text_equilatero db 10, "O triângulo é equilátero!", 10, 0
    text_isosceles db 10, "O triângulo é isósceles!", 10, 0
    text_escaleno db 10, "O triângulo é escaleno!", 10, 0

    fmt db "%lf", 0
    
section .text

global main
extern printf, scanf

    main:
        push rbp
        mov  rbp, rsp

        mov  rdi, prompt0
        call printf
        
        mov  rdi, prompt1
        call printf

        mov rdi, fmt
        lea rsi, [l1]
        call scanf


        mov  rdi, prompt2
        call printf
        
        mov rdi, fmt
        lea rsi, [l2]
        call scanf
        

        mov  rdi, prompt3
        call printf
        
        mov rdi, fmt
        lea rsi, [l3]
        call scanf

        movsd xmm0, [l1]
        movsd xmm1, [l2]
        movsd xmm2, [l3]

        movsd xmm3, xmm0
        addsd xmm3, xmm1
        movsd xmm4, xmm0
        addsd xmm4, xmm2
        movsd xmm5, xmm1
        addsd xmm5, xmm2

        ucomisd xmm0, xmm5
        jae  inexistente
        ucomisd xmm1, xmm4
        jae  inexistente
        ucomisd xmm2, xmm3
        jae inexistente
        

        ucomisd xmm0, xmm1
        je   iso_ou_equi

        ucomisd xmm1, xmm2
        je   isosceles

        ucomisd xmm0, xmm2
        je   isosceles

        mov  rdi, text_escaleno
        call printf
        jmp  end

    inexistente:
        mov rdi, text_inexistente
        call printf
        jmp end
        
    iso_ou_equi:
        ucomisd xmm1, xmm2
        je   equilatero
        
    isosceles:
        mov  rdi, text_isosceles
        call printf
        jmp  end

    equilatero:
        mov  rdi, text_equilatero
        call printf

    end:
        leave
        ret
