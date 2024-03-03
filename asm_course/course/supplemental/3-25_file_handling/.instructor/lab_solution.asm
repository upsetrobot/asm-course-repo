
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-25 File Handling - Lab Solution
;;
;; This file is module specific and contains solutions for the module lab.
;;
;; @file        lab_solution.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        02 Mar 2024
;; @copyright   Copyright (c) 2024
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;;    █████\  ███████ /███   /███
;;   ██\  ██\ ██::::/ /████ /████
;;   ███████\ ███████ /██ ████/██
;;   ██\  ██\ \::::██ /██ /██ /██
;;   ██\  ██\ ███████ /██     /██
;;   \\\  \\\ \:::::/ ///     ///
;;    \\\  \\\ \\|// ///     /// 
;; 
;; The basics of the Linux x64 calling convention:
;;
;;     - Arguments are passed in `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, in 
;;       that order and any additional arguments are passed on the stack.
;;     - The return value is stored in rax.
;;
;; You can reference the System V ABI manual for more details.
;; The Intel Manual, Volume 2 has detailed information about how each
;; instruction behaves.
;;
;; Good luck! Have fun!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


section .data

    filename    db  "testing_data.bin", 0



section .bss

    buffer: resb 1024



section .text

global studentFunction1
global studentFunction2
global studentFunction3
global studentFunction4
global studentFunction5
global studentFunction6
global studentFunction7
global studentFunction8
global studentFunction9
global studentFunction10



; 1. Open and Print a File.
;
; int studentFunction1(char* filename);
;
; @brief    Function opens a file and prints the file contents to the screen.
;           Returns -1 if file could not be opened. 
;
;           You can assume the file is less than 1024 bytes long. In reality, 
;           you would either buffer read it till you printed everything or 
;           you would use `stat` or `lseek` to get the file size and then 
;           allocate a buffer for the file or use some other method. 
;
; @param    char*   Name of file to open.
; @return   int     Returns `0` if successful; else returns `-1`.
;
; TODO: Implement this function.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------
    enter 0, 0

    ; ssize_t read(int fd, void *buf, size_t count);
    %define SYS_READ    0
    ; ssize_t write(int fd, const void *buf, size_t count);
    %define SYS_WRITE   1
    ; int open(const char *pathname, int flags);
    ; Use O_CREAT|O_WRONLY|O_TRUNC to create a new file.
    %define SYS_OPEN    2
    ; int close(int fd);
    %define SYS_CLOSE   3

    %define O_ACCMODE   0o00000003
    %define O_RDONLY    0o00000000
    %define O_WRONLY    0o00000001
    %define O_RDWR      0o00000002
    %define O_CREAT     0o00000100
    %define O_EXCL	    0o00000200
    %define O_NOCTTY    0o00000400
    %define O_TRUNC	    0o00001000
    %define O_APPEND    0o00002000
    %define O_NONBLOCK  0o00004000
    %define O_SYNC	    0o04010000
    %define O_LARGEFILE 0o00100000
    %define O_DIRECTORY 0o00200000
    %define O_NOFOLLOW  0o00400000
    %define O_CLOEXEC   0o02000000
    %define O_DIRECT    0o00040000
    %define O_NOATIME   0o01000000
    %define O_PATH      0o10000000
    %define O_DSYNC	    0o00010000
    %define O_TMPFILE   0o20200000

    %define STD_IN      0
    %define STD_OUT     1

    %define BUF_SZ      1024

    ; int open(const char *pathname, int flags, mode_t mode);
    mov     rax, SYS_OPEN
    mov     rsi, O_RDONLY
    xor     rdx, rdx
    syscall

    test    rax, rax
    js      .end

    push    rax
    mov     rdi, rax
    mov     rax, SYS_READ
    mov     rsi, buffer
    mov     rdx, BUF_SZ
    syscall

    pop     rdi
    push    rax
    mov     rax, SYS_CLOSE
    syscall

    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, buffer
    pop     rdx
    syscall

    xor rax, rax

    .end:
        leave
        ret
    ; --- Do not edit below this line -----------------------------------------
; End studentFunction1.



; 2. Open a Binary File and add Array of Numbers.
;
; long long studentFunction2()
;
; @brief    Function opens a file named `testing_data.bin` from the current 
;           working directory and reads the file into a buffer. The contents
;           are interpreted as a long long array of 10 or less numbers. The 
;           numbers are added together and the sum is returned. If there is a 
;           file error, the function returns `0`.
;
; @return   long long   Returns the sum of the array of `long long`s from the 
;                       `testing_data.bin` file.
;
; TODO: Implement this function.
;
studentFunction2:
    ; --- Add your solution below this line -----------------------------------
    enter 0, 0

    ; ssize_t read(int fd, void *buf, size_t count);
    %define SYS_READ    0
    ; ssize_t write(int fd, const void *buf, size_t count);
    %define SYS_WRITE   1
    ; int open(const char *pathname, int flags);
    ; Use O_CREAT|O_WRONLY|O_TRUNC to create a new file.
    %define SYS_OPEN    2
    ; int close(int fd);
    %define SYS_CLOSE   3

    %define O_ACCMODE   0o00000003
    %define O_RDONLY    0o00000000
    %define O_WRONLY    0o00000001
    %define O_RDWR      0o00000002
    %define O_CREAT     0o00000100
    %define O_EXCL	    0o00000200
    %define O_NOCTTY    0o00000400
    %define O_TRUNC	    0o00001000
    %define O_APPEND    0o00002000
    %define O_NONBLOCK  0o00004000
    %define O_SYNC	    0o04010000
    %define O_LARGEFILE 0o00100000
    %define O_DIRECTORY 0o00200000
    %define O_NOFOLLOW  0o00400000
    %define O_CLOEXEC   0o02000000
    %define O_DIRECT    0o00040000
    %define O_NOATIME   0o01000000
    %define O_PATH      0o10000000
    %define O_DSYNC	    0o00010000
    %define O_TMPFILE   0o20200000

    %define STD_IN      0
    %define STD_OUT     1

    %define BUF_SZ      1024

    mov     rax, SYS_OPEN
    mov     rdi, filename
    mov     rsi, O_RDONLY
    xor     rdx, rdx
    syscall

    test    rax, rax
    js      .end

    mov     rdi, rax
    mov     rax, SYS_READ
    mov     rsi, buffer
    mov     rdx, BUF_SZ
    syscall

    mov     rcx, 8
    cqo
    div     ecx

    mov     rcx, rax
    xor     rax, rax
    test    rcx, rcx
    jz      .end

    mov     rdi, buffer

    .loop:
        add     rdx, [rdi]
        add     rdi, 8
        loop    .loop

    .end:
        leave
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction2.



; 3. Save a File.
;
; int studentFunction3(char* str, char* filename);
;
; @brief    Function copies and appends the string `str` to a file given by  
;           `filename`. If the file does not exist, it will be created. The
;           function returns `-1` if there is an error; otherwise returns `0`.
;
; @param    str         String to append to file.
; @param    filename    Name of file to append string to.
; @return   int         `0` if success; else `-1`.
;
; TODO: Implement this function.
;
studentFunction3:
    ; --- Add your solution below this line -----------------------------------
    enter 0, 0

    ; ssize_t read(int fd, void *buf, size_t count);
    %define SYS_READ    0
    ; ssize_t write(int fd, const void *buf, size_t count);
    %define SYS_WRITE   1
    ; int open(const char *pathname, int flags);
    ; Use O_CREAT|O_WRONLY|O_TRUNC to create a new file.
    %define SYS_OPEN    2
    ; int close(int fd);
    %define SYS_CLOSE   3

    %define O_ACCMODE   0o00000003
    %define O_RDONLY    0o00000000
    %define O_WRONLY    0o00000001
    %define O_RDWR      0o00000002
    %define O_CREAT     0o00000100
    %define O_EXCL	    0o00000200
    %define O_NOCTTY    0o00000400
    %define O_TRUNC	    0o00001000
    %define O_APPEND    0o00002000
    %define O_NONBLOCK  0o00004000
    %define O_SYNC	    0o04010000
    %define O_LARGEFILE 0o00100000
    %define O_DIRECTORY 0o00200000
    %define O_NOFOLLOW  0o00400000
    %define O_CLOEXEC   0o02000000
    %define O_DIRECT    0o00040000
    %define O_NOATIME   0o01000000
    %define O_PATH      0o10000000
    %define O_DSYNC	    0o00010000
    %define O_TMPFILE   0o20200000

    %define STD_IN      0
    %define STD_OUT     1

    %define BUF_SZ      1024

    mov     rax, SYS_OPEN
    push    rdi
    mov     rdi, rsi
    mov     rsi, O_CREAT
    or      rsi, O_APPEND
    or      rsi, O_WRONLY
    xor     rdx, rdx
    syscall

    pop     rdi
    test    rax, rax
    js      .end

    push    rdi
    push    rax
    xor     eax, eax
    or      rcx, -1
    cld
    repne scasb
    not     rcx
    dec     rcx

    mov     rax, SYS_WRITE
    pop     rdi
    pop     rsi
    mov     rdx, rcx
    syscall

    test    rax, rax
    js      .end

    xor     rax, rax

    .end:
        leave
        ret
    ; --- Do not edit below this line -----------------------------------------
; End studentFunction3.



; ********************************* NOT USED **********************************
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
