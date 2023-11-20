; Francisco Silva Santana - 222216228
; Caio Adriel Barbosa dos Santos - 222215084
; João Francisco Ioris Dear - 222215080
; Lucas Sampaio Souza Andrade - 220115578

global main
global myreadline
extern sscanf
extern printf

%macro GET_2_OPERANDS 0
cmp qword [N], 8
jl main_loop
sub qword [N],4
mov rax,NUMS
add rax,[N]
movss xmm1,dword [rax]
movss xmm0,dword [rax-4]
%endmacro

section .data

FLOAT_FORMAT db " %f ",0
OUTPUT db "%f",10,0


section .bss

BUFPOS resq 1
LINEBUF resb 256
OPCHAR resb 1
N resq 1
NUMS resd 64

section .text

main:     
  push rbp
  mov rbp,rsp

  main_loop:
    mov qword [BUFPOS],LINEBUF
    call myreadline
    mov rdi,[BUFPOS]
    mov rsi,FLOAT_FORMAT
    mov rdx,qword NUMS
    add rdx,qword [N]
    call sscanf
    cmp rax,0x0
    je read_op
    add qword [N],4
    jmp main_loop
    read_op:
      mov r12,[BUFPOS]
      dec r12
      find_op:
        inc r12
        cmp byte [r12],'+'
        je plus
        cmp byte [r12],'-'
        je sub
        cmp byte [r12],'*'
        je mul
        cmp byte [r12],'/'
        je div
        cmp byte [r12],'='
        je show
        cmp byte [r12],'_'
        je empty_stack
        jmp find_op

    plus:
      GET_2_OPERANDS
      addss xmm0,xmm1
      jmp writeback
    sub:
      GET_2_OPERANDS
      subss xmm0,xmm1
      jmp writeback
    mul:
      GET_2_OPERANDS
      mulss xmm0,xmm1
      jmp writeback
    div:
      GET_2_OPERANDS
      divss xmm0,xmm1
      jmp writeback
  show:
    mov rdi,OUTPUT
    mov rax,NUMS
    add rax,qword [N]
    movss xmm0,dword [rax-4]
    cvtss2sd xmm0,xmm0
    call printf
    inc r12
    mov qword [BUFPOS],r12
    jmp main_loop

    empty_stack:
      cmp qword [N],0
      je main_loop
      mov rax,NUMS
      add rax,qword [N]
      movss xmm0,dword [rax-4]
      cvtss2sd xmm0,xmm0
      mov rdi,OUTPUT
      call printf
      sub qword [N],4
      cmp qword [N],0
      jne empty_stack
      mov qword [N],0
      jmp main_loop
    writeback:
      inc r12
      mov qword [BUFPOS],r12
      mov rax,NUMS
      add rax,[N]
      movss dword [rax-4],xmm0
      jmp main_loop

  pop rbp
  mov rax, 0
  ret


myreadline:
  push rbp
  mov rbp,rsp
  mov r12,LINEBUF-1
  myreadline_loop:
    inc r12
    mov rax,0
    mov rdi,0
    mov rsi,r12
    mov rdx,1
    syscall
    cmp byte [r12],10
    jne myreadline_loop
  mov byte [r12+1],0
  mov rax,0
  pop rbp
  ret
