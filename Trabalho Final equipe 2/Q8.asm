;ana carolina, iris jasmin, rodrigo felix, victor manoel
bits 64

; contagem de igualdade entre lados
checkSides:
    comisd    xmm0, xmm4
    jne    .finish
    add    rcx, 1

    .finish:
        ret

printType:
    cmp    rcx, 3
    je     .eq

    cmp    rcx, 1
    je     .iso

    mov       rsi, msgEscaleno
    mov       rdx, lngEsc
    jmp       .finish

    .eq:
        mov       rsi, msgEquilatero
        mov       rdx, lngEqu
        jmp       .finish

    .iso:
        mov       rsi, msgIsosceles
        mov       rdx, lngIso

    .finish:
        syscall
        ret

global  main

section .text
    extern  printf
    extern  scanf
    
    main:     
        ; ajuste de pilha
        push      rbp
        mov       rbp, rsp

        ; entradas
        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgEscrita
        mov       rdx, lngMsg
        syscall
    
        mov       rdi, formatLongFloat
        mov       rsi, l1
        call      scanf
    
        movq      xmm1, [l1]

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgEscrita
        mov       rdx, lngMsg
        syscall

        mov       rdi, formatLongFloat
        mov       rsi, l2
        call      scanf

        movq      xmm2, [l2]

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgEscrita
        mov       rdx, lngMsg
        syscall

        mov       rdi, formatLongFloat
        mov       rsi, l3
        call      scanf

        movq      xmm3, [l3]

        mov       rcx, 0
        
        movq      xmm0, [l1]
        movq      xmm4, [l2]
        call      checkSides

        movq      xmm0, [l1]
        movq      xmm4, [l3]
        call      checkSides

        movq      xmm0, [l2]
        movq      xmm4, [l3]
        call      checkSides

        call      printType

        leave
        mov       rax, 0
        mov       rdx, 0
        mov       rdi, 0
        mov       rsi, 0
        ret

section   .data
    l1:                 dq    0.0
    l2:                 dq    0.0
    l3:                 dq    0.0
    formatLongFloat:    db    "%lf", 0
    formatInt:    db    "%d", 10
    msgEscrita:         db    "Insira um lado do triângulo:", 10
    lngMsg:             EQU $-msgEscrita
    msgIsosceles:       db    "Isósceles", 10
    lngIso:             EQU $-msgIsosceles
    msgEscaleno:        db    "Escaleno", 10
    lngEsc:             EQU $-msgEscaleno
    msgEquilatero:      db    "Equilátero", 10
    lngEqu:             EQU $-msgEquilatero

;nasm -felf64 main.asm && gcc main.o && ./a.out
