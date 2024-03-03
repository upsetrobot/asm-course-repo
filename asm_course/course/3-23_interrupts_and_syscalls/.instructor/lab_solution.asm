
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-23 Interrupts And Syscalls - Lab Solution
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
;;     ______   ______  __       __ 
;;    |\     \ /\     \|\ \     /\ \
;;   |\ ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓\   /  ▓▓
;;   | ▓▓__| ▓▓ ▓▓___\▓▓ ▓▓▓\ /  ▓▓▓
;;   | ▓▓    ▓▓\▓▓    \| ▓▓▓▓\  ▓▓▓▓
;;   | ▓▓▓▓▓▓▓▓_\▓▓▓▓▓▓\ ▓▓\▓▓ ▓▓ ▓▓
;;   | ▓▓  | ▓▓  \__| ▓▓ ▓▓ \▓▓▓| ▓▓
;;   | ▓▓  | ▓▓\▓▓   \▓▓ ▓▓  \▓ | ▓▓
;;    \▓▓   \▓▓ \▓▓▓▓▓▓ \▓▓      \▓▓
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

    welcome_aliens  db "Welcome, Aliens", 10, 0
    wa_len          equ $ - welcome_aliens
    hooray          db "HOORAY", 10, 0
    hooray_len      equ $ - hooray
    input           db "Input: "
    input_len       equ $ - input


section .bss

    buffer:     resb    255


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



; 1. Print Constant String "Welcome Aliens".
;
; char* studentFunction1();
;
; @brief    Function prints the message "Welcome, Aliens\n" to standard output 
;           terminal and returns a pointer to the message.
;
; @return   char*   Returns a pointer to the "Welcome Aliens\n" string.
;
; TODO: Implement this function.
; RULE: Use a syscall to print to the terminal.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------

    %define SYS_WRITE   1
    %define STD_OUT     1

    push    rbp
    mov     rbp, rsp
    
    ; ssize_t write(int fd, const void *buf, size_t count);
    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, welcome_aliens
    mov     rdx, wa_len
    push    rsi
    syscall

    pop     rax
    leave
    ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction1.



; 2. Print Given String.
;
; ssize_t studentFunction2(char* msg);
;
; @brief    Function prints `msg` to the screen and returns the number of 
;           bytes written or an error code given by the syscall.
;
;           Pseudocode: `print(msg, end='')`.
;
; @return   ssize_t     Returns the output of the syscall `write`.
;
; TODO: Implement this function.
;
studentFunction2:
    ; --- Add your solution below this line -----------------------------------
    push    rbp
    mov     rbp, rsp
    
    %define SYS_WRITE   1
    %define STD_OUT     1

    push    rdi             ; Save pointer to beginning of string.
    not     rcx             ; Set `rcx` to max.
    cld                     ; Ensure direction is positive.
    xor     rax, rax        ; Search for NULL (`al` == 0).
    repne scasb             ; strlen.
    not     rcx             ; Reverse number of times decremented to positive.
    dec     rcx             ; Account for not counting NULL.
    pop     rdi             ; Restore pointer.

    ; ssize_t write(int fd, const void *buf, size_t count);
    mov     rax, SYS_WRITE  ; Syscall number.
    mov     rsi, rdi        ; What to print.
    mov     rdi, STD_OUT    ; Where to print to.
    mov     rdx, rcx        ; Number of chars to print.
    syscall

    leave
    ret
    ; --- Do not edit below this line -----------------------------------------
; End studentFunction2.



; 3. Concatenate Strings.
;
; char* studentFunction3(char* msg1, size_t msg1_len, char* msg2, size_t msg2_len);
;
; @brief    Function copies `msg1` to a buffer followed by the string " & " 
;           and then `msg2` followed by a newline and null terminator and then 
;           prints and returns the buffer. Given strings are null-terminated.
;           Entire output string is assumed to fit in a 256-byte buffer (or 
;           the implementor can make the buffer safe by using this value as 
;           a max buffer to print).
;
;           Example: If `msg1` points to "Cheese" and `msg2` points to 
;                    "Crackers", then "Cheese & Crackers\n" is printed and its 
;                    pointer is returned.
;
;           Pseudocode: `print(msg1 + " & " + msg2 + "\n", end='')`.
;
; @param    msg1        Pointer to first string to print.
; @param    msg1_len    Length of `msg1` string.
; @param    msg2        Pointer to second string to print.
; @param    msg1_len    Length of `msg2` string.
; @return   char*       Returns a pointer to the print buffer.
;
; TODO: Implement this function.
;
studentFunction3:
    ; --- Add your solution below this line -----------------------------------
    push    rbp
    mov     rbp, rsp
    
    %define SYS_WRITE   1
    %define STD_OUT     1

    mov     r8, rdi
    mov     r9, rsi
    mov     r10, rdx
    mov     r11, rcx

    mov     rdi, buffer
    mov     rsi, r8
    mov     rcx, r9 
    cld
    rep movsb

    mov     dword [rdi], " & "
    add     rdi, 3

    mov     rsi, r10
    mov     rcx, r11
    rep movsb

    mov     byte [rdi], 10              ; Add newline.
    mov     byte [rdi + 1], 0           ; Null-terminate string.

    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, buffer
    mov     rdx, r9
    add     rdx, 4
    add     rdx, r11
    syscall

    mov     rax, buffer

    leave
    ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction3.



; 4. Print Input from User.
;
; unsigned long long studentFunction4();
;
; @brief    Function prints "Input: " and then gets input from user and then
;           prints it to the screen. If the first character in the user input
;           is a `@`, the function also prints the message "HOORAY\n" after
;           printing the input. When the input is printed, it is followed by a 
;           newline. Function returns `0`.
;
;           Python: `print(a := input("Input: ")); print("HOORAY") if a[0]=='@' else None`. 
;           Pseudocode:
;               `a = input("Input: ")
;               print(a + '\n', end='')
;               if a[0] == '@':
;                   print("HOORAY\n", end='')`.
;
; @return   unsigned long long  Returns `0`.
;
; TODO: Implement this function.
; TIP:  The shell flushes the input buffer with a newline and adds it to the input.
;       So, you do not have to worry about the newline.
;
; *********************** !!! TESTING INSTRUCTIONS !!! ************************
;       For Testing with `make`, enter `abc` for first input.
;       Enter `` for second input (Just press `Enter`).
;
studentFunction4:
    ; --- Add your solution below this line -----------------------------------
    push    rbp
    mov     rbp, rsp
    
    %define SYS_READ    0
    %define SYS_WRITE   1
    %define STD_IN      0
    %define STD_OUT     1

    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, input
    mov     rdx, input_len
    syscall

    ; ssize_t read(int fd, void *buf, size_t count);
    mov     rax, SYS_READ
    mov     rdi, STD_IN 
    mov     rsi, buffer
    mov     rdx, 255
    syscall

    mov byte [buffer + rax], 0

    mov     rdx, rax
    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, buffer
    syscall

    mov     rdi, buffer
    cmp     byte [rdi], 10
    jne     .noAmpersand

    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, hooray
    mov     rdx, hooray_len
    syscall

    mov rax, hooray
    jmp .end

    .noAmpersand:
        mov rax, buffer

    .end:

    leave
    ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction4.



; ********************************* NOT USED **********************************
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
