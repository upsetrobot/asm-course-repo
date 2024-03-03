
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-10 Boolean Operations - Application Lab
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
;;     mm    mmmm  m    m
;;     ##   #"   " ##  ##
;;    #  #  "#mmm  # ## #
;;    #mm#      "# # "" #
;;   #    # "mmm#" #    #
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



; 1. Byte Masking.
;
; long long studentFunction1(long long a);
;
; @brief    Function returns a number with the three lowest bytes masked. For 
;           example, if `a` is `0xaabbccdd11223344`, then `0xaabbccdd11000000` 
;           would be returned.
;
; @param    a           The number to mask.
; @return   long long   Returns `a` with the last three bytes cleared.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; 2. Bitwise OR.
;
; long long studentFunction2(long long a, long long b);
;
; @brief    Function calculates bitwise or.
;
; @param    a           The augend.
; @param    b           The addend.
; @return   long long   Returns the bitwise-or sum of `a` and `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction2.



; 3. Byte Stripping.
;
; int studentFunction3(long long a);
;
; @brief    Function returns the lower 3 bytes.
;
; @param    a           Number.
; @return   long long   Returns lower three bytes of `a` as int.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction3.



; 4. Reverse Sign.
;
; long long studentFunction4(long long a);
;
; @brief    Function returns reverse sign of `a`.
;
; @param    a           Number to revese sign of.
; @return   long long   `a` with reverse sign of `a`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction4.



; 5. Return 0.
;
; long long studentFunction5(unsigned long long a, long long b, long long c);
;
; @brief    Function returns 0.
;
; @param    a           Arbitrary number.
; @param    b           Arbitrary number.
; @param    c           Arbitrary number.
; @return   long long   Returns 0.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction5:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction5.



; 6. Setting Bits.
; 
; long long studentFunction6(long long a);
;
; @brief    Function returns `a` with the lower 14 bits set.
;
; @param    a           Number to set lower bits on.
; @return   long long   `a` with lower 14 bits set to `1`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Do not use jumps or loops.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction6:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction6.



; ********************************* NOT USED **********************************
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
