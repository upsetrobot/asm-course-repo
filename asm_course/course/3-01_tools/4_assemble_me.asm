
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT THIS FILE.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-01 Tools - Application Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. This module is just about compiling assembly, so no edits are 
;; needed.
;;
;; @file         4_assemble_me.asm
;; @author       upsetrobot
;; @brief        Prints a message with a secret number.
;; @version      1.0.1
;; @date         11 Feb 2024
;; @copyright    Copyright (c) 2024
;;
;; TODO:        You need to assemble this assembly code to create an executable 
;;              program. If you want to edit the code to see what happens, 
;;              make sure you keep this copy of the original code for the 
;;              assignment.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global _start

_start:

    mov rax, message
    add rax, [number]
    mov rcx, 5
    
    .loop:
        inc byte [rax + rcx]
        xor byte [rax + rcx], 0xce
        .c:
            cmp byte [rax + rcx], 48
            jl .u
            cmp byte [rax + rcx], 0x39
            jg .d
        loop .loop

    jmp .e

    .u:
        add byte [rax + rcx], 0xf
        jmp .c

    .d:
        sub byte [rax + rcx], 0x4
        jmp .c

    .e:
        mov rdi, 1
        mov rsi, message
        mov rdx, len
        mov rax, 1
        syscall

        mov       rax, 60
        xor       rdi, rdi
        syscall

section .data

	message:    db "Hello, Welcome Assembler! Your Number is: ", 0x25, 0x3a, 
                db 0x52, 0x03, 0x6a, 10, 0
    len:        equ $-message
    number:     db len-8


; End of file.