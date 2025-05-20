%include "macros/file.asm"

; ---------------------------------------------------
; Outputs text in terminal
;
; Arguments:
;   %1 - text buffer
;   %2 - buffer length
; ---------------------------------------------------
%macro print 2
  mov rax, SYS_write
  mov rdi, 1
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro

; FIX: This aint no working

%macro loop_start 1
  mov rcx, %1
  push rcx
%endmacro

%macro loop_end 0
  pop rcx
  dec rcx
  jnz loop_start 3
%endmacro

; ---------------------------------------------------
; Returns:
;   Exit code
; ---------------------------------------------------
%macro end_program 0
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
%endmacro
