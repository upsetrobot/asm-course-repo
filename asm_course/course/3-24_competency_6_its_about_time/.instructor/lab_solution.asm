
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-24 Competency 6 Its About Time - Lab Solution
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


%define     SYS_READ    0
%define     SYS_WRITE   1
%define     SYS_TIME    201

%define     STDIN       0
%define     STDOUT      1

%define     BUFSZ       255



section .bss

    buf:    resb    BUFSZ

    ; --- Use for global uninitialized variables if you want below this line --

    hours_buf:      resb 3
    hours_buf_len:  resq 1
    mins_buf:       resb 3
    mins_buf_len:   resq 1

    ; End .bss section.



section .data

    time        db  "TIME: "
    time_len    equ $ - time

    colon       db  ":"
    colon_len   equ $ - colon

    newline     db  10
    newline_len equ $ - newline

    hours       db  "Enter hours: "
    hours_len   equ $ - hours

    mins        db  "Enter minutes: "
    mins_len    equ $ - mins

    error       db  "Error: Invalid Input", 10
    error_len   equ $ - error

    ; --- Use for global initialized variables if you want below this line ----

    

    ; End .data section.



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



; You have to implement studentFunction1, but you can make as many additional
; local functions as desired.
; --- Add your solution below this line ---------------------------------------


; 1. Competency 6 Its About Time.
;
; unsigned int studentFunction1();
;
; @brief    This function gets the time using the `time` syscall (which returns
;           the time in seconds in UTC time since January 1, 1970). Then the 
;           time is converted to time in EST zone hours and minutes. The time 
;           is printed in hh:mm format. Then the user is prompted for hours 
;           to add in form of one or two digits. Then the user is prompted for 
;           minutes to add in the form of one or two digits. The hours are 
;           added to the current hours, and the minutes are added to the 
;           current minutes. Then the new time is printed. Finally, the 
;           function returns the current time value of hours and minutes in 
;           the number of seconds. 
;
;           The number of EST hours is calculated using the following 
;           equation:
;               `h = (s // 60 // 60 % 24) - 5
;               if h > 0: h = h % 12
;               else: h = (h + 24) % 12`.
;
;           The number of minutes is calculated using the following equation:
;               `m = s // 60 % 60`.
;
;           After the time is set, the minutes are added using this equation:
;               `new_m` = (m + user_m) % 60`.
;
;           And the new hours are added using this equation:
;               `new_h = (h + user_h + (m + user_m) // 60) % 12`.
;
;           The return value is calculated using the following equation:
;               `return new_h*3600 + new_m*60`.
;
;           Full Python code example can be found in the `1_competency.md` 
;           file.
;
; @return   unsigned int    Returns the new time in EST in the number of
;                           seconds from the number of hours and minutes. 
;
; TODO: Implement this function.
; RULE: Do NOT use external libraries.
;
; *********************** !!! TESTING INSTRUCTIONS !!! ************************
;       For Testing with `make`, enter `0` for first input and `0` for second.
;       Enter `1` for first input and `1` for second.
;       Enter `25` for first input and `61` for second.
;       Enter `33` for first input and `33` for second.
;       This has to be done before the system time minute changes, so if you 
;       fail, try testing again!
;
studentFunction1:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

    mov rax, SYS_TIME
    syscall

    mov r12, rax                ; `r12 = s`.
    mov rdi, rax
    call getHours

    mov r13, rax                ; `r13 = h`.
    mov rdi, r12
    call getMins

    mov r14, rax                ; `r14 = m`.
    mov rdi, r13
    mov rsi, r14
    call printTime

    mov r12, -1

    .whileHours:
        test r12, r12
        jns .endWhileHours

        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, hours
        mov rdx, hours_len
        syscall

        call inputNum

        mov r12, rax            ; `r12 = h_to_add`.
        jmp .whileHours

    .endWhileHours:

    mov r15, -1

    .whileMins:
        test r15, r15
        jns .endWhileMins

        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, mins
        mov rdx, mins_len
        syscall

        call inputNum

        mov r15, rax            ; `r15 = m_to_add`.
        jmp .whileMins

    .endWhileMins:

    ; Calculate new time.
    mov rax, r14
    add rax, r15            ; `m + m_to_add`. 
    xor rdx, rdx
    mov rcx, 60
    div ecx                 ; `rdx = new_m`; rax = hours to add to `h_to_add`.

    mov r14, rdx            ; `r14 = new_m`.
    add rax, r12
    add rax, r13
    xor rdx, rdx
    mov rcx, 12
    div ecx                 ; `rdx = new_h`.

    mov r12, rdx            ; `r12 = new_h`; `r14 = new_m`.
    mov rdi, rdx
    mov rsi, r14
    call printTime

    mov rax, r12
    mov ecx, 3600
    mul ecx                 ; `new_h * 3600`.

    mov r12, rax
    mov rax, r14
    mov ecx, 60
    mul ecx                 ; new_m * 60.
    add rax, r12
    
    leave
    ret

; End studentFunction1.



; unsigned int getHours(unsigned long long seconds);
;
getHours:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    mov ecx, 60
    xor rdx, rdx
    div ecx

    xor rdx, rdx
    div ecx

    xor rdx, rdx
    mov ecx, 24
    div ecx                 ; `rdx = s // 60 // 60 % 24`.

    sub rdx, 5
    test rdx, rdx
    jns .zeroOrMore

    add rdx, 24

    .zeroOrMore:
        mov rax, rdx
        xor rdx, rdx
        mov ecx, 12
        div ecx
        mov rax, rdx

    leave
    ret



; unsigned int getMins(unsigned long long seconds);
;
getMins:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    xor rdx, rdx
    mov ecx, 60
    div ecx             ; `rax = s // 60`.

    xor rdx, rdx
    div ecx             ; `rdx = s // 60 % 60`.

    mov rax, rdx
    leave
    ret



; void printTime(unsigned long long hours, unsigned long long mins);
;
printTime:
    push rbp
    mov rbp, rsp

    ; hours to digits.
    .fillHoursBuf:
        cmp rdi, 10
        jae .hrsTwoDigits

        .hrsOneDigit:
            add dil, '0'
            mov [hours_buf], dil
            mov qword [hours_buf_len], 1
            jmp .fillMinsBuf

        .hrsTwoDigits:
            mov rax, rdi
            xor rdx, rdx
            mov ecx, 10
            div ecx

            mov byte [hours_buf], '1'
            add dl, '0'
            mov [hours_buf + 1], dl
            mov qword [hours_buf_len], 2

    .fillMinsBuf:
        mov rax, rsi
        xor rdx, rdx
        mov ecx, 10
        div ecx

        add rax, '0'
        mov [mins_buf], al
        add rdx, '0'
        mov [mins_buf + 1], dl
        mov qword [mins_buf_len], 2

    ; ssize_t write(int fd, const void *buf, size_t count);
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, time
    mov rdx, time_len
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, hours_buf
    mov rdx, [hours_buf_len]
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, colon
    mov rdx, colon_len
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, mins_buf
    mov rdx, [mins_buf_len]
    syscall
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, newline_len
    syscall

    leave
    ret


    
; unsigned int inputNum();
;
inputNum:
    push rbp
    mov rbp, rsp

    ; ssize_t read(int fd, void *buf, size_t count);
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, buf
    mov rdx, BUFSZ
    syscall

    test rax, rax
    jz .err

    cmp byte [buf], 10
    je .err

    cmp byte [buf], '0'
    jb .errInvalid

    cmp byte [buf], '9'
    ja .errInvalid

    cmp byte [buf + 1], 0
    je .oneDigit

    cmp byte [buf + 1], 10
    je .oneDigit

    .twoDigits:
        cmp byte [buf + 1], '0'
        jb .errInvalid

        cmp byte [buf + 1], '9'
        ja .errInvalid

        xor rax, rax
        mov al, [buf]
        sub al, '0'
        mov ecx, 10
        mul cl

        xor rcx, rcx
        mov cl, [buf + 1]
        sub cl, '0'
        add rax, rcx
        jmp .end

    .oneDigit:
        xor rax, rax
        mov al, [buf]
        sub al, '0'
        jmp .end

    .errInvalid:
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, error
        mov rdx, error_len
        syscall

    .err:
        or rax, -1
    
    .end:
        leave
        ret



; --- Do not edit below this line ---------------------------------------------
; ********************************* NOT USED **********************************
studentFunction2: ret
studentFunction3: ret
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
