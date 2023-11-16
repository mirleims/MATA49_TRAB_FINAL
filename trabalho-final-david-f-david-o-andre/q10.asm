; David Ferrari
; David Oliveira
; André Costa

section .data
  max dq 0
  max_2 dq 0
  prompt_n db "Insira o valor n: ", 10, 0
  fmt_input dq "%d", 0
  prompt_insert_values db "Insira os valores na ordem: ", 10, 0
  vector times 100 dq 0
  n dq 0
  temp dq 0

section .text
  global main
  extern printf, scanf

main:
  push rbp,
  mov rbp, rsp

  mov rdi, prompt_n
  call printf
 
  mov rdi, fmt_input
  mov rsi, n
  call scanf

  mov rdi, prompt_insert_values
  call printf
 
  mov rdx, 0
input_loop:
  mov [temp], rdx
  mov rax, [n]
  cmp rdx, rax
  je end_input_loop
  mov rdi, fmt_input
  lea rsi, [vector + rdx*8]
  call scanf
  mov rdx, [temp]
  inc rdx
  jmp input_loop

end_input_loop:
  mov rax, [vector]
  mov rbx, rax ; primeiro max
  mov rcx, [vector + 8] ; 
  mov rdx, rcx ; segundo max

  mov rsi, 1
get_max:
  cmp rsi, [n]
  je end_get_max
  mov rax, [vector+8*rsi]
  cmp rax, rbx
  jg update_max
back_from_update_max:
  inc rsi
  jmp get_max

update_max:
  mov rdx, rbx
  mov rbx, rax
  jmp back_from_update_max

end_get_max:
  add rbx, rdx
  mov rdi, fmt_input
  mov rsi, rbx
  call printf

  leave
  ret
