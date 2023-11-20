section .note.GNU-stack

section .data
  msg db "digite um número:", 0
  intformat db "%d", 0

section .bss
  numero resb 32 ;

section .text
  global main
  extern printf
  extern scanf

  main:   
    push rbp
    mov rbp, rsp

    mov rdi, msg
    call printf

    mov rdi, intformat
    mov rsi, numero
    call scanf

    mov rdi, [numero]

    ; Argumento (numero) em rdi
    ; Retorna o resultado em rax


    mov r8, 0
    mov r9, 1
    mov r10, rdi

    ; Caso base
    cmp r10, 0
    je .done
    cmp r10, 1
    je .done

    ; Calcular Fibonacci iterativamente

    .next:      
      add r8, r9
      mov r11, r9
      mov r9, r8
      mov r8, r11


      mov rdi, intformat
      mov rsi, r11
      mov rax, 0
      call printf


      cmp r10, r9
      je .done

      jmp .next

  .done:
    leave
    ret

; nasm Q6.asm -f elf64 && gcc Q6.o -o Q6 -no-pie && ./Q6