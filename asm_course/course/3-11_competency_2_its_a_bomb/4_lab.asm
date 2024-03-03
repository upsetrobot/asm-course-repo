
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-11 Competency 2 Its a Bomb! - Competency Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.nasm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        13 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;;        __       _________  __      __
;;       /\ \     /________/ |\ \    /| |
;;      / /\ \    | |______  | \ \  / | |
;;     /_/__\ \   |/______/| | |\ \/ /| |
;;    /______\ \   ______| | | | \/_/ | |
;;   /_/      \_\ /______|/  |_|      |_|
;; 
;; The basics of the Linux x64 calling convention:
;;
;;     - Arguments are passed in `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, in 
;;       that order and any additional arguments are passed on the stack.
;;     - The return value is stored in `rax`.
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



; 1. Timer Deactivation Code.
; 
; unsigned long long studentFunction1(
;   unsigned long long a, 
;   unsigned long long b,
;   unsigned long long c
; );
;
; @brief    Function calculates and returns the timer deactivation code given 
;           three input combination codes (as `long long`s). The combinations 
;           run through circuits that use arithmetic, bitwise, and boolean 
;           operations where Circuit `A` executes first, then `B`, the `C`.
;
;           Circuit A executes the following:
;               `A = ( (A*B + A*C + B*C) % C ) + 0xdeadbeef - 0x60a7 + 0xca7`.
;       
;           Circuit B executes the following:
;               `B = ( ((A << 8) >>> 22) // 8 ) 
;               + (B >> (C & 0xf))
;               + ( (C >> 3) <<< 42 ) + 0x20d1ac`.
;
;           Circuit C executes the following:
;               `C = !( (B | C) ^ ((A & B) | C) ) ^ 0xca7dec0de57ac05`.
;
;           Then the function returns `A ^ B ^ C`.
;
; @param    a                   Input code into `A` circuit.
; @param    b                   Input code into `B` circuit.
; @param    c                   Input code into `C` circuit.
; @return   unsigned long long  Final code after decombination.
;
; TODO: Implement this function.
; RULE: Do NOT use macros, assignments or directives.
; RULE: Do not use memory.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
; RULE: Do NOT use jumps or loops.
; ASSUME:   Division by zero will not occur.
; ASSUME:   All divisions are integer divisions.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



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