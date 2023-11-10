; TRABALHO FINAL - QUESTÃO 12
; EDUARDO VITOR - 221215231
; GUILHERME BONFIM - 221115981
; JOÃO GONÇALVES PAES NUNES - 222215138


; informação
section .data
Titulo: db "Vamos Calcular o Salário com Hora Extra ",10,0
horaTrabalhada: db "Quantas horas trabalhou este mês? ",0
horaSalario: db "Qual o seu salário por hora? ",0
scan: dq "%lf",0
Resultado: dq "O Salário total é %.2f reais",10,0
extra: dq 1.5
p1Salario: dq 160.0
timeWork: dq 0.0
timeWage: dq 0.0
Salario: dq 0.0

section .text
global main
extern scanf
extern printf

main:
;Onde ocorre a comunicação entre usuario e o terminal
    push rbp
    mov rbp, rsp

    mov rdi, Titulo
    call printf

    mov rdi, horaTrabalhada
    call printf 

    mov rdi, scan
    mov rsi, timeWork
    call scanf
    
    mov rdi, horaSalario
    call printf 

    mov rdi, scan
    mov rsi, timeWage
    call scanf

;Calculo do salario
    movq xmm0, [p1Salario] 
    movq xmm1, [timeWage]
    mulsd xmm0,xmm1
    movq [Salario],xmm0
    movq xmm0,[timeWage]
    movq xmm1,[extra]
    mulsd xmm0,xmm1
    movq[extra],xmm0
    movq xmm0,[timeWork]
    movq xmm1,[p1Salario]
    subsd xmm0, xmm1
    movq xmm1,[extra]
    mulsd xmm0,xmm1
    movq xmm1,[Salario]
    addsd xmm0,xmm1
    
;imprimi O salario total
    mov rdi,Resultado
    call printf
    
;finaliza o programa    
    leave
    ret
;nasm -felf64 questao12.asm && gcc questao12.o && ./a.out