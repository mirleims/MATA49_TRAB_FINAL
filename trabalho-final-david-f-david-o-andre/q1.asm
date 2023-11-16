; David Ferrari
; David Oliveira
; André Costa

section .data
  l1 dq 0
  l2 dq 0
  l3 dq 0
  prompt_triangle_sides db "Insira o valor de l1, l2, e l3 em sequência: ", 10, 0
  isosceles_msg db "Triângulo isósceles", 10, 0
  equilateral_msg db "Triângulo equilátero", 10, 0
  scalene_msg db "Triângulo escaleno", 10, 0
  fmt_input db "%d %d %d", 0

section .text
  global main
  extern printf, scanf

main:
  push rbp,
  mov rbp, rsp

  mov rdi, prompt_triangle_sides
  call printf
 
  mov rdi, fmt_input
  mov rsi, l1
  mov rdx, l2
  mov rcx, l3
  call scanf

  xor rax, rax
  xor rbx, rbx
  xor rcx, rcx
  mov rax, [l1]
  mov rbx, [l2]
  mov rcx, [l3]

  cmp rax, rbx
  je eq
  jne is_1
eq:
  cmp rax, rcx
  jne is_2
  mov rdi, equilateral_msg
  call printf
  jmp end

is_1:
  cmp rax, rcx
  je is_2
  cmp rbx, rcx
  je is_2
  jne sc
is_2:
  mov rdi, isosceles_msg
  call printf
  jmp end

sc:
  mov rdi, scalene_msg
  call printf
end:
  leave
  ret
