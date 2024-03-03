
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-26 ASM Programming - Lab Solution
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
;;
;; TODO: Write a program that takes a filename as an argument, and then 
;;       attempts to open the file with the given filename and then prints the 
;;       contents of the file and then exits. If there is an error, 
;;       Program should print "Error".
;;
;;       You can use either method to compile.  Weather you use `gcc` or `ld`, 
;;       ensure you use the correct entry point as applicable.
;;
;;       Program must be compiled as `4_lab` for the executable name.
;;
;;       You can use any libraries if you want.
;;
;;       Your program will only be tested on text, so you don't have to worry 
;;       about binary.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; --- Add your solution below this line --------------------------------------


section .data

    no_input    db  "Error: No argument given.", 10, 0
    error       db  "Error", 10, 0
    mode        db  "r", 0
    printchar   db  "%c", 0


section .text

global main

extern printf
extern fopen
extern getc
extern fclose


main:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    ; Check for argument.
    cmp rdi, 1
    je .noInput

    ; Get filename.
    mov r12, [rsi + 8]            ; `r12 = filename`.

    ; Open file.
    mov rdi, r12
    mov rsi, mode
    call fopen

    ; Check if file opened.
    test rax, rax
    jz .noFile

    ; Print file.
    mov r13, rax
    
    .while:
        mov rdi, r13
        call getc

        cmp al, -1              ; Check for EOF.
        je .endWhile

        mov rdi, printchar
        mov esi, eax
        call printf

        jmp .while

    .endWhile:

    ; Close file.
    mov rdi, r13
    call fclose

    xor rax, rax
    jmp .end
    
    .noFile:
        mov rdi, error
        call printf
        jmp .err

    .noInput:
        mov rdi, no_input
        call printf

    .err:
        or rax, -1
    
    .end:
        pop r13
        pop r12
        leave
        ret

; --- Do not edit below this line ---------------------------------------------



; End of file.
