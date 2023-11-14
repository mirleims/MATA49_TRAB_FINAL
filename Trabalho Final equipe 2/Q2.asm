;ana carolina, iris janine, rodrigo felix, victor manoel
section .data
    ps db "eh primo",0
    psn db "nao eh primo",0
    sformat db "%s", 10, 0
    numberFormat db "%d", 0
    value db 7

section .text
    global main
    extern printf, scanf, comp
  main:



    push rbp
    mov rbp, rsp
    mov rdi, numberFormat
    mov rsi, value
    call scanf

    ;mov rax, 0
    ;mov rdi, numberFormat
    ;mov rsi, [value]
    ;call printf

    mov r8, 2
    cmp r8, [value]
    je primo

    mov r9, 1
    cmp r9, [value]
    je notprimo

    mov rbx, 1
    mov r12, [value]
    dec byte [value]

  loop:

    add rbx, 1

    mov rdi, r12
    mov rsi,rbx
    call comp

    cmp rax,1
    je notprimo

    cmp rbx, [value]
    jl loop
    ;if (i < value) -> loop


cmp rax,0
  jmp primo
notprimo:
mov rdi, sformat
mov rsi, psn
call printf

jmp end
primo:
  mov rdi, sformat
  mov rsi, ps
  call printf
  jmp end


end:
  leave
  ret
