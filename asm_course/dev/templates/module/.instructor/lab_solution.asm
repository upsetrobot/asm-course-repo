
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; <Topic> - Lab Solution
;;
;; This file is module specific and contains solutions for the module lab.
;;
;; @file        lab_solution.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        11 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     _    ____  __  __
;;    / \  / ___||  \/  |
;;   / _ \ \___ \| |\/| |
;;  / ___ \ ___) | |  | |
;; /_/   \_|____/|_|  |_|
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



; 1. Multiply Two Numbers.
;
; int studentFunction1(int a, int b);
;
; @brief    Function multiplies two numbers together and returns the product.
;
; @param    a       The multiplier.
; @param    b       The multiplicand.
; @return   int     Returns the product of `a` and `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; -- Add your solution below this line -------------------------------------

    xor rax, rax
    .loop:

        cmp esi, 0
        jl .less
        jg .greater
        je .exit

        .less:
            sub eax, edi
            inc esi
            jmp .loop

        .greater:
            add eax, edi
            dec esi
            jmp .loop

    .exit:        

    ; -- Do not edit below this line -------------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction1.



; 2. Add Two Numbers.
;
; long long studentFunction2(long long a, long long b);
;
; @brief    Function adds two numbers together and returns the sum.
;
; @param    a           The augend.
; @param    b           The addend.
; @return   long long   Returns the sum of `a` and `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction2:

    ; -- Add your solution below this line -------------------------------------

    add rdi, rsi
    mov rax, rdi

    ; -- Do not edit below this line -------------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction2.



; 3. Copy String.
;
; char* studentFunction3(char* src, char* dest);
;
; @brief    Function copies the source string to the destination buffer and 
;           returns a pointer to the buffer. The string is null-terminated.
;
; @param    src     Pointer to string to copy.
; @param    dest    Pointer to destination buffer.
; @return   char*   Returns a pointer to the destination buffer.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You may use jump operations for this lab.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction3:

    ; -- Add your solution below this line -------------------------------------

    mov rax, rsi

    .loop:
        cmp byte [rdi], 0
        je .end

        mov cl, [rdi]
        mov [rsi], cl
        add rdi, 1
        add rsi, 1
        jmp .loop
        
    .end:
        mov byte [rsi], 0

    ; -- Do not edit below this line -------------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

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
