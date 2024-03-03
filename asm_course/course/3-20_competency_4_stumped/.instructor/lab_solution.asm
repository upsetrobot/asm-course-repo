
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-20 Competency 4 Stumped - Lab Solution
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
;;   ===============================
;;   ====  ======      ===  =====  =
;;   ===    ====  ====  ==   ===   =
;;   ==  ==  ===  ====  ==  =   =  =
;;   =  ====  ===  =======  == ==  =
;;   =  ====  =====  =====  =====  =
;;   =        =======  ===  =====  =
;;   =  ====  ==  ====  ==  =====  =
;;   =  ====  ==  ====  ==  =====  =
;;   =  ====  ===      ===  =====  =
;;   ===============================
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



; 1. Competency 4 Stumped - Decrypt String. 
;
; char* studentFunction1(char* encrypted_str);
;
; @brief    Function decrypts given null-terminated string. Each character is 
;           `XOR`ed with `33` and then rotated by `33`. The resulting 
;           decrypted string is then reversed for the final step of 
;           deciphering. Then a pointer to the decrypted string is returned.
;
;           You can use the `print` function if you want to print a null-
;           terminated string to the console. A newline will automatically 
;           be added. To use the `print` function, simply load `rdi` with 
;           a pointer to the string you want to print and `call print`. This 
;           function will not mess with any other registers.
;
; @param    encrypted_str   Pointer to string to be decrypted. 
; @return   char*           Pointer to decrypted string.
;
; TODO: Implement this function.
; RULE: Do NOT use macros, assignments or directives.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------

    ; Check for null pointer.
    xor     rax, rax
    test    rdi, rdi
    jz      .end

    call    print
    push    rdi                     ; Save pointer.

    .while:
        mov     al, byte [rdi]      ; If `*rdi == 0`, done.
        test    al, al
        jz      .endWhile

        xor     al, 33
        sub     al, 33
        mov     byte [rdi], al
        inc     rdi
        jmp     .while

    .endWhile:

    ; `rdi` is pointing to end of string now.
    ; Reverse string.
    dec     rdi                     ; Move to last character.
    pop     rsi                     ; Beginning of string.
    push    rsi                     ; Save pointer to string.

    .while2:
        cmp     rdi, rsi            ; If `rdi <= rsi`, then done.
        jle     .endWhile2

        mov     al, byte [rdi]
        xchg    al, byte [rsi]      ; Swap bytes.
        mov     byte [rdi], al
        dec     rdi
        inc     rsi
        jmp .while2

    .endWhile2:

    pop     rax                     ; Return decrypted string.
    mov     rdi, rax
    call    print

    .end:

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; void print(char* str);
;
; @brief    Function prints given string and prints a newline.
;
; @param    str     String to be printed.
;
; To use this function, simply move a pointer to the string you want to print 
; to STDOUT into `rdi`. This function will not clobber any registers.
;
print:
                push    rbp
                mov     rbp, rsp
                push    rdi
                push    rsi
                push    rdx
                push    rcx
                push    r8
                push    r9
                push    r10
                push    r11
                push    rax

    .strlen:    push    rdi
                or      rcx, -1
                xor     eax, eax
                cld
                repne scasb
                not     rcx
                dec     rcx
                pop     rdi

    .print:     mov     rax, 1
                mov     rsi, rdi
                mov     rdi, 1
                mov     rdx, rcx
                syscall

    .newline:   mov     rax, 1
                mov     rdi, 1
                mov     rsi, nl
                mov     rdx, nl_len
                syscall 

    .end:       pop     rax
                pop     r11
                pop     r10
                pop     r9
                pop     r8
                pop     rcx
                pop     rdx
                pop     rsi
                pop     rdi
                leave
                ret

; End print.



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


section .data:

    nl          db      10
    nl_len      equ     $ - nl



; End of file.
