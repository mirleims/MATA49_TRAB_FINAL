; Para compilar
; nasm -f elf64 main.asm && gcc main.o -o main
            global        main
            extern        scanf, printf, fflush, stdout

            section       .data
message:    db            "Insira os pontos A, B e C no formato x y a seguir:", 10, 0
A:          db            "A: ", 0
B:          db            "B: ", 0
C:          db            "C: ", 0
read_fmt:   db            "%lf %lf", 0
msg_AB:     db            "AB: %f", 10, 0
msg_AC:     db            "AC: %f", 10, 0
msg_BC:     db            "BC: %f", 10, 0
final_msg:  db            "O triângulo é ", 0
impos:      db            "impossível", 10, 0
escal:      db            "escanelo", 10, 0
isosc:      db            "isósceles", 10, 0
equil:      db            "equilátero", 10, 0

            section       .bss
xa:         resq          1
ya:         resq          1
xb:         resq          1
yb:         resq          1
xc:         resq          1
yc:         resq          1
ab:         resq          1
ac:         resq          1
bc:         resq          1

            section       .text
main:       push          rbp
            mov           rbp, rsp

            mov           rdi, message
            xor           rax, rax
            call          printf

            mov           rdi, A
            mov           rsi, xa
            mov           rdx, ya
            call          prompt

            mov           rdi, B
            mov           rsi, xb
            mov           rdx, yb
            call          prompt

            mov           rdi, C
            mov           rsi, xc
            mov           rdx, yc
            call          prompt

            movsd         xmm0, [xa]
            movsd         xmm1, [ya]
            movsd         xmm2, [xb]
            movsd         xmm3, [yb]
            call          calc_dist
            movsd         [ab], xmm0

            movsd         xmm0, [xa]
            movsd         xmm1, [ya]
            movsd         xmm2, [xc]
            movsd         xmm3, [yc]
            call          calc_dist
            movsd         [ac], xmm0

            movsd         xmm0, [xb]
            movsd         xmm1, [yb]
            movsd         xmm2, [xc]
            movsd         xmm3, [yc]
            call          calc_dist
            movsd         [bc], xmm0

            mov           rdi, msg_AB
            movsd         xmm0, [ab]
            mov           rax, 1
            call          printf

            mov           rdi, msg_AC
            movsd         xmm0, [ac]
            mov           rax, 1
            call          printf

            mov           rdi, msg_BC
            movsd         xmm0, [bc]
            mov           rax, 1
            call          printf

            mov           rdi, final_msg
            xor           rax, rax
            call          printf

            movsd         xmm0, [ab]
            movsd         xmm1, [ac]
            call          swapminmax
            sub           rsp, 0x10
            movsd         [rsp], xmm0
            movsd         xmm0, [bc]
            call          swapminmax
            movsd         xmm2, [rsp]
            movsd         [rsp], xmm1
            movsd         xmm1, xmm2
            call          swapminmax
            movsd         xmm2, [rsp]
            add           rsp, 0x10

            movsd         xmm3, xmm0
            addsd         xmm0, xmm1
            xorpd         xmm0, xmm2
            movq          rax, xmm0
            cmp           rax, 0
            jnz           .not_impossible
            mov           rdi, impos
            jmp           .end
.not_impossible:
            xor           rbx, rbx
            movsd         xmm0, xmm3
            xorpd         xmm0, xmm1
            movq          rax, xmm0
            cmp           rax, 0
            jnz           .next_1
            call          inc_rbx
.next_1:    xorpd         xmm1, xmm2
            movq          rax, xmm1
            cmp           rax, 0
            jnz           .next_2
            call          inc_rbx
.next_2:    xor           rcx, rcx
            cmp           rbx, rcx
            je            .escal
            inc           rcx
            cmp           rbx, rcx
            je            .isosc
            mov           rdi, equil
            jmp           .end
.escal:     mov           rdi, escal
            jmp    	      .end
.isosc:     mov           rdi, isosc
.end:       mov           rax, 1
            call          printf
            
            mov           rsp, rbp
            pop           rbp

            mov           rax, 60
            xor           rdi, rdi
            syscall

prompt:     sub           rsp, 0x8
            push          rsi
            push          rdx
            xor           rax, rax
            call          printf
            mov           rdi, [stdout]
            call          fflush

            mov           rdi, read_fmt
            pop           rdx
            pop           rsi
            xor           rax, rax
            call          scanf
            add           rsp, 0x8
            ret

calc_dist:  subsd         xmm0, xmm2
            subsd         xmm1, xmm3
            mulsd         xmm0, xmm0
            mulsd         xmm1, xmm1
            addsd         xmm0, xmm1
            sqrtsd        xmm0, xmm0
            ret

swapminmax: movsd         xmm2, xmm0
            minsd         xmm0, xmm1
            maxsd         xmm1, xmm2
            ret

inc_rbx:    inc           rbx
            ret
