
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-17 Stack - Application Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        14 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    ▄█████▄  ▄▄█████▄  ████▄██▄                                
;;    ▀ ▄▄▄██  ██▄▄▄▄ ▀  ██ ██ ██                                
;;   ▄██▀▀▀██   ▀▀▀▀██▄  ██ ██ ██                                
;;   ██▄▄▄███  █▄▄▄▄▄██  ██ ██ ██                                
;;    ▀▀▀▀ ▀▀   ▀▀▀▀▀▀   ▀▀ ▀▀ ▀▀ 
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



; 1. Return Argument.
; 
; long long studentFunction1(long long a);
;
; @brief    Function returns `a` without using a `mov` operation.
;
; @param    a           The value to return.
; @return   long long   Returns `a`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction1:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction1.



; 2. Return EFlags Register.
; 
; long long studentFunction2(long long a, long long b);
;
; @brief    Function returns `flags` value after adding `a` and `b`. 
;
;           This may be slightly tricky with different processors, so use the 
;           `pushf` instruction and `or` it with `0x2` to ensure the second 
;           bit is set. Debuggers and traps may set the `IF` and/or the `TF`, 
;           so `and` the value with `0xfcff` if you want to negate those 
;           values.
;
;           Pseudocode: `a + b; return flags`.
;
; @param    a           The augend.
; @param    b           The addend.
; @return   long long   Returns `rflags` after performing `a + b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction2:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    
    
    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction2.



; 3. Call a Function.
; 
; long long studentFunction3(long long a, size_t num);
;
; @brief    Function calls `weirdFunction` on `a`, `num` times. To do this,
;           load `rdi` with `a` (which will already be loaded into `rdi` when 
;           you start) and use `call weirdFunction`. `weirdFunction` will 
;           produce a value that you will use as input into `weirdFunction` 
;           again `num` times. Note that `weirdFunction` clobbers registers, 
;           so you will have to save and restore them if needed.
;
;           Pseudocode: `for i in range(num): a = weirdFunction(a)
;                       return a`.
;
; @param    a       Value to call `weirdFunction` on.
; @param    num     Number of times to call `weirdFunction(a)`.
; @return   long long   Return value after calling `weirdFunction(a)` `num` 
;                       times. Returns `a` if `num` is `0`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction3:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------
    
    

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction3.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; long long weirdFunction(long long a);
;
weirdFunction:
    mov rax, rdi
    xor rcx, rcx
    xor rdi, rdi
    xor rsi, rsi
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    mov rdx, 0x5adca7badca7
    xor rax, rdx
    ret

; End weirdFunction.



; ********************************* NOT USED **********************************
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
