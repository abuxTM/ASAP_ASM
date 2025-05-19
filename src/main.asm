%include "include/const.h"

; Functions
; --------------------------
; RDI | REG | 1st ARG
; RSI | REG | 2nd ARG
; RDX | REG | 3rd ARG
; RCX | REG | 4th ARG
; R8  | REG | 5th ARG
; R9  | REG | 6th ARG
; RAX | REG | Return value of functions
;
; Pointers
; --------------------------
; RBP | REG | Base pointer
; RSP | REG | Stack pointer
;
; Yes
; --------------------------
; XOR     | INS | Sets a Register to 0
; RIP     | REG | Points to the next INS
; RFLAGS  | REG | CPU status (overflow, zero, etc)

section .data
  msg db "Hello World!", 0xA
  msg_len equ $ - msg
  filename db "output.txt", 0

section .text
  global _start

_start:
  ; ----------
  mov rsi, msg
  mov rdx, msg_len
  call print

  ; ----------
  mov rdi, filename
  call create_file

  ; ----------
  call end_program

print:
  mov rax, SYS_write
  mov rdi, 1

  syscall
  ret

create_file:
  mov rax, SYS_open
  mov rsi, O_RDONLY | O_CREAT | O_TRUNC
  mov rdx, 0644

  syscall
  ret

end_program:
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
