
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-09 Bit Operations - Application Lab
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
;;    _` |  __| __ `__ \                                         
;;   (   |\__ \ |   |   |                                        
;;  \__,_|____/_|  _|  _|
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



; 1. Endianness Conversion. 
;
; unsigned int studentFunction1(unsigned int a);
;
; @brief    Function returns the result of interpreting `a` as a number 
;           stored in big-endian byte order. For example, if `a` were 
;           `0x11223344`, the function would return the reverse `0x44332211`.
;
; @param    a               The number to interpret.
; @return   unsigned int    Returns the interpretations of `a` as a big-endian 
;                           number.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, `xchg`, `shl`, `shr`, 
;       `sal`, `sar`, `rol`, `ror`, `rcl`, or `rcr`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------
    
    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; 2. Product of Number and Power of Two.
;
; long long studentFunction2(long long a);
;
; @brief    Function multiplies `a` by `16`.
;
; @param    a           The multiplier.
; @return   long long   Returns the product of `a` and `16`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, `xchg`, `shl`, `shr`, 
;       `sal`, `sar`, `rol`, `ror`, `rcl`, or `rcr`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction2.



; 3. Division by Power of 2.
; 
; long long studentFunction3(long long a);
;
; @brief    Function divides `a` by 32 (integer division with rounding 
;           towards negative infinity).
;
; @param    a           The dividend.
; @return   long long   Returns the integer quotient of `a` and 32.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, `xchg`, `shl`, `shr`, 
;       `sal`, `sar`, `rol`, `ror`, `rcl`, or `rcr`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction3.



; 4. Byte Shifting.
;
; unsigned int studentFunction4(unsigned int a, unsigned int b);
;
; @brief    Function returns a number with the first two bytes of `a` as the 
;           last two bytes and the last two bytes of `b` as the first two 
;           bytes. For example, if `a` is `0xaabbccdd` and `b` is 
;           `0x11223344`, then the function would return `0x3344aabb`.
;
; @param    a               The number to take the first two bytes from.
; @param    b               The number to take the last two bytes from.
; @return   unsigned int    Returns a number comprised of the last two bytes 
;                           from `a` and the first two bytes from `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, `xchg`, `shl`, `shr`, 
;       `sal`, `sar`, `rol`, `ror`, `rcl`, or `rcr`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction4.



; ********************************* NOT USED **********************************
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
