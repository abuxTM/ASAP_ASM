; ---------------------------------------------------
; Creates and writes to a file
;
; Arguments:
;   %1 - filename
;   %2 - message
;   %3 - length
; 
; Returns:
;   rax - 0 on success
; ---------------------------------------------------
%macro file_create 1
  ; disable permision masking (unsafe)
  mov     rax, SYS_umask
  mov     rdi, 0
  syscall

  ; returns FD (File Descriptor)
  mov     rax, SYS_openat                   ; syscall type
  mov     rdi, AT_FDCWD                     ; CWD (Creates FD)
  mov     rsi, %1                           ; pointer to file name
  mov     rdx, O_WRONLY | O_CREAT | O_TRUNC ; flags
  mov     r10, IO_PERM                      ; rw-r--r--
  syscall

  ; return error if rax is 0
  test    rax, rax
  js      file_error
%endmacro

; ---------------------------------------------------
; write to file using FD
; ---------------------------------------------------
%macro file_write 2
  mov     rdi, rax
  mov     rax, SYS_write
  mov     rsi, %1
  mov     rdx, %2
  syscall
%endmacro

; close the file after use
%macro file_close 0
  mov     rax, SYS_close
  syscall
%endmacro

; ---------------------------------------------------
; Returns:
;   Error exit code
; ---------------------------------------------------
file_error:
  mov     rax, SYS_exit
  mov     rdi, 1
  syscall
