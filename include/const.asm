%define SYS_read    0
%define SYS_write   1
%define SYS_open    2
%define SYS_close   3
%define SYS_exit    60
%define SYS_umask   90
%define SYS_openat  257
; ---------------------
; IO
; ---------------------
%define O_RDONLY    0       ; Set file as read-only
%define O_RDWR      2       ; 
%define O_APPEND    8       ; Append instead of override
%define O_EXCL      128     ;
%define AT_FDCWD    -100    ; Create at current-working-directory
; ---------------------
; Octal
; ---------------------
%define O_WRONLY    01o     ; Set file as write-only
%define O_CREAT     0100o   ; Create the file if doesnt exist
%define IO_PERM     0644o   ; rw-r--r--
%define O_TRUNC     01000o  ; Truncate the file
