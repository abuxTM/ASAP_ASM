%include "include/const.asm"
%include "include/helpers.asm"
%include "include/macros.asm"

; --------------------------
; Functions
; --------------------------
; RDI     | REG | 1st ARG
; RSI     | REG | 2nd ARG
; RDX     | REG | 3rd ARG
; RCX     | REG | 4th ARG
; R8      | REG | 5th ARG
; R9      | REG | 6th ARG
; RAX     | REG | Return value of functions
; --------------------------
; Pointers
; --------------------------
; RBP     | REG | Base pointer
; RSP     | REG | Stack pointer
; --------------------------
; Yes
; --------------------------
; XOR     | INS | Sets a Register to 0
; TEST    | INS | Checks if x is 0 or not
; JS      | INS | Jump if sign flag (SF) is set
; RIP     | REG | Points to the next INS
; RFLAGS  | REG | CPU status (overflow, zero, etc)

; global mutable data
section .data
  msg db "Hello World!", 0xA
  msg_len equ $ - msg
  filename db "output.txt", 0

; make _start runnable
section .text
  global _start

_start:
  ; ----------
  file_create filename
  file_write  msg, msg_len
  file_close

  ; ----------
  loop_start  3
  print       msg, msg_len
  loop_end

  ; ----------
  call  end_program
