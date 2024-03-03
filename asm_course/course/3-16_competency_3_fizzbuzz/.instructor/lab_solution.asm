
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-16 Competency 3 Fizzbuzz - Lab Solution
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
;;    ▄▄▄    ▄▄▄   ▄▄▄▄▄                                         
;;   ▀   █  █   ▀  █ █ █                                         
;;   ▄▀▀▀█   ▀▀▀▄  █ █ █                                         
;;   ▀▄▄▀█  ▀▄▄▄▀  █ █ █ 
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



; 1. FizzBuzz.
;
; unsigned int* studentFunction1(int* int_arr, unsigned int arr_len);
;
; @brief    Function iterates `int_arr`, an array of integers, and tests each
;           one. If the integer is divisible by `3`, the function prints 
;           "FIZZ" (by calling the provided print function and passing a code 
;           to it), if number is divisible by `5`, the function prints 
;           "BUZZ", and if the integer is divisible by `3` and divisible by 
;           `5`, the function prints "FIZZBUZZ"). The function returns the 
;           number of "FIZZ"s or "BUZZ"s printed (e.g, "FIZZBUZZ" counts as 2 
;           (one for "FIZZ" and one for "BUZZ")).
;
;           To use the `printSignal` function, load `rdi` with `0`, `1`, `2`, 
;           or `3` and `call printSignal`. It will not mess with any other 
;           registers.
;               `0` - Function does nothing.
;               `1` - Function prints "FIZZ".
;               `2` - Function prints "BUZZ".
;               `3` - Function prints "\n" (newline).
;
; @param    int_arr         Pointer to integer array.
; @param    arr_len         Number of elements in `int_arr`.
; @return   unsigned int    Returns the number of times "FIZZ" or "BUZZ" were 
;                           printed.
;
; TODO: Implement this function.
; RULE: Do NOT use macros, assignments or directives.
; RULE: Do not use memory.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------

    xor     rcx, rcx                        ; `i`.
    xor     r10, r10                        ; Print counter.

    .for:
        cmp     rcx, rsi                    ; If `i == arr_len`, end for loop.
        je      .endFor

        xor     r9, r9                      ; Printed flag.
        
        .checkDiv3:
            mov     eax, dword [rdi + rcx*4]    ; Get number `e`.
            cdq
            mov     r8, 3
            idiv    r8d
            test    edx, edx                ; If `e % 3 == 0`.
            jnz     .checkDiv5

            inc     r9                      ; Increment flag.
            mov     rdx, rdi                ; Save `rdi`.
            mov     rdi, 1                  ; Print "FIZZ".
            call    printSignal
            mov     rdi, rdx                ; Restore `rdi`.

        .checkDiv5:
            mov     eax, dword [rdi + rcx*4]    ; Get number `e`.
            cdq
            mov     r8, 5
            idiv    r8d
            test    edx, edx                ; If `e % 5 == 0`.
            jnz     .checkPrinted

            inc     r9                      ; Increment flag.
            mov     rdx, rdi                ; Save `rdi`.
            mov     rdi, 2                  ; Print "BUZZ".
            call    printSignal
            mov     rdi, rdx                ; Restore `rdi`.

        .checkPrinted:
            test    r9, r9
            jz      .next

            add     r10, r9                 ; Add to counter by number printed.
            mov     rdx, rdi                ; Save `rdi`.
            mov     rdi, 3
            call    printSignal
            mov     rdi, rdx                ; Restore `rdi`.

        .next:
            inc     rcx
            jmp     .for

    .endFor:
        mov     rax, r10

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; void printSignal(int option);
;
; @brief    Function prints "FIZZ" if `option` is `1`, "BUZZ" if `option` is 
;           `2`, "\n" (newline) if `option` is `3`, or does nothing otherwise.
;
; @param    option  Code that determines what the function prints to `STDOUT`.
;
; To use this function, simply move `1`, `2`, or `3` into `edi` and 
; `call printSignal`.
;
printSignal:
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

                mov     rax, 1          
                cmp     rdi, 1
                je      .fizz

                cmp     rdi, 2
                je      .buzz

                cmp     rdi, 3
                je      .newline

                xor     rax, rax
                jmp     .end

    .fizz:      mov     rdi, 1
                mov     rsi, fizz
                mov     rdx, fizz_len
                syscall

                jmp     .end

    .buzz:      mov     rdi, 1
                mov     rsi, buzz
                mov     rdx, buzz_len
                syscall

                jmp     .end

    .newline:   mov     rdi, 1
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

; End printSignal.



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

    fizz        db      "FIZZ"
    fizz_len    equ     $ - fizz

    buzz        db      "BUZZ"
    buzz_len    equ     $ - buzz

    nl          db      10
    nl_len      equ     $ - nl



; End of file.
