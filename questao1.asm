;Davi Azevedo
;Estácio Gonçalves
;Francisco Carvalho
;Thiago Dias

bits 64
section .data
        fmt:  dq "%lf%", 0
        fmt2: db "O valor em graus Celsius eh %lf", 10
        n1:   dq 32.0, 0
        n2:   dq 1.8, 0
section .bss
        x resq 1

section .text
        global main
        extern printf, scanf

        main:
        push rbp
        mov rbp, rsp
        
        mov rdi, fmt
        mov rsi, x
        call scanf  
        
        movq xmm0, [x]
        movq xmm1, [n1]
        movq xmm2, [n2]
        
        subsd xmm0, xmm1
        divsd xmm0, xmm2

        mov rdi, fmt2
        call printf

        leave
        ret