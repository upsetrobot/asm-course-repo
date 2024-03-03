
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-05 Basic Operations - Application Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        13 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
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



; 1. Basic Subtraction.
;
; int studentFunction1(int a, int b);
;
; @brief    Function returns the difference between two numbers.
;
; @param    a       The number to subtract (subtrahend).
; @param    b       The number to subtract from (minuend).
; @return   int     Returns the difference of `b` and `a` (i.e., `b - a`).
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction1.



; 2. Subtract from a Sum.
;
; int studentFunction2(int a, int b, int c, int d);
;
; @brief    Function adds three numbers together and subtracts the fourth 
;           number from the sum and returns the difference.
;
; @param    a       The augend
; @param    b       The addend
; @param    c       The second addend.
; @param    d       The subtrahend
; @return   int     Returns the difference between `d` and the sum of `a`, `b`, 
;                   and `c` (i.e., `(a + b + c) - d`).
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction2.



; ********************************* NOT USED **********************************
studentFunction3: ret
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.