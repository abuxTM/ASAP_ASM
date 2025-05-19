%include "include/const.asm"

; Functions
; --------------------------
; RDI     | REG | 1st ARG
; RSI     | REG | 2nd ARG
; RDX     | REG | 3rd ARG
; RCX     | REG | 4th ARG
; R8      | REG | 5th ARG
; R9      | REG | 6th ARG
; RAX     | REG | Return value of functions
;
; Pointers
; --------------------------
; RBP     | REG | Base pointer
; RSP     | REG | Stack pointer
;
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
  ; creates new output.txt file
  ; ----------
  mov   rdi, filename
  call  create_file

  ; Hello World!
  ; ----------
  mov   rsi, msg
  mov   rdx, msg_len
  call  print

  ; Exit
  ; ----------
  call  end_program

; ---------------------------------------------------
; Outputs text in terminal
;
; Arguments:
;   rsi - pointer to a text
;   rdx - pointer to text length
; ---------------------------------------------------
print:
  mov     rax, SYS_write
  mov     rdi, 1
  syscall
  ret

; ---------------------------------------------------
; Creates and writes to a file
;
; Arguments:
;   rdi - pointer to filename
; 
; Returns:
;   rax - 0 on success
; ---------------------------------------------------
create_file:
  ; disable permision masking (unsafe)
  mov     rax, SYS_umask
  mov     rdi, 0
  syscall

  ; returns FD (File Descriptor)
  mov     rax, SYS_openat                   ; syscall type
  mov     rdi, AT_FDCWD                     ; CWD
  mov     rsi, filename                     ; pointer to file name
  mov     rdx, O_WRONLY | O_CREAT | O_TRUNC ; flags
  mov     r10, IO_PERM                      ; rw-r--r--
  syscall

  ; return error if rax is 0
  test    rax, rax
  js      file_error

  ; write to file using fd
  mov     rdi, rax        ; fd to rdi
  mov     rax, SYS_write  ; write to file syscall type
  mov   rsi, msg
  mov   rdx, msg_len
  syscall

  ; close the file after use
  mov     rax, SYS_close
  syscall

  ret

; ---------------------------------------------------
; Returns:
;   Error exit code
; ---------------------------------------------------
file_error:
  mov     rax, SYS_exit
  mov     rdi, 1
  syscall

; ---------------------------------------------------
; Returns:
;   Exit code
; ---------------------------------------------------
end_program:
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
