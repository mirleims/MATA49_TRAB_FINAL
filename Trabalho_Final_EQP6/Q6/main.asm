bits 64

section .note.GNU-stack

section .data
    msg db "Digite um número N: ", 0
    fmt db "%d", 0
    newline db 10

section .bss
    numero resq 1


section .text
    global main
    extern printf, scanf, func, fbnc
    

main:
    push rbp
    mov rbp, rsp
    
    ; Imprime a mensagem "Digite um número N: "
    mov rdi, msg
    call printf

    ; Recebe a entrada do usuário
    mov rdi, fmt
    mov rsi, numero
    mov rax, 0
    call scanf

    ; Chama a função C fbnc
    mov rdi, [numero]
    call fbnc

    ; Finaliza o programa
    mov rax, 60
    xor rdi, rdi
    syscall

; nasm -f elf64 main.asm -o main.o && gcc main.o func.c -o main -no-pie && ./main
