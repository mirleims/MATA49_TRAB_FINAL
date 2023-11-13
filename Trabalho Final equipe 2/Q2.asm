 
;ana carolina, iris jasmin, rodrigo felix, victor manoel
section .data
    ps db "eh primo",0
    psn db "nao eh primo",0
    sformat db "%s", 10, 0
    numberFormat db "%d", 10, 0
    value db 10 ,0

section .text
    global main
    extern printf, scanf, comp
  main:

    push rbp
    mov rbp, rsp
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
