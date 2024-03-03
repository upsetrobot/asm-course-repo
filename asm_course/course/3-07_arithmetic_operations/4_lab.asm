
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-07 Arithmetic Operations - Application Lab
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
;;    ____ __________ ___                                        
;;   / __ `/ ___/ __ `__ \                                       
;;  / /_/ (__  ) / / / / /                                       
;;  \__,_/____/_/ /_/ /_/ 
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



; 1. Basic Multiplication.
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
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; 2. Multiply Number by 8000.
;
; unsigned long long studentFunction2(unsigned long long a);
;
; @brief    Function returns product of `a` and `8000` (`a*8000`). 
;
; @param    a                   The multiplier.
; @return   unsigned long long  Returns the product of `a` and `8000`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction2.



; 3. Division of Differences. 
;
; long long studentFunction3(
;   long long a, 
;   long long b, 
;   long long c, 
;   long long d
; );
;
; @brief    Function returns result of following calculation 
;           `(c - d) * b / (a - 1)`. Does not handle division by zero error.
;
; @param    a            One more than divisor.
; @param    b            Multiplier.
; @param    c            Minuend of dividend.
; @param    d            Subtrahend of dividend.
; @return   long long    Result of calculation.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction3.



; 4. Division by Pointer. 
;
; int studentFunction4(int* a, int* b);
;
; @brief    Function returns integer quotient of the integer pointed to by `a` 
;           divided by the integer pointed to by `b`. Does not handle division 
;           by zero errors.
;
; @param    a      Pointer to dividend.
; @param    b      Pointer to divisor.
; @return   int    `*a // *b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------
    
    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction4.



; 5. Addition of ASCII Digits.
; 
; int studentFunction5(char a, char b);
;
; @brief    Function converts the given ASCII digits to numbers, adds them 
;           together and returns the sum.
;
; @param    a      char digit which may be "0", "1", "2", "3", "4", "5", "6", 
;                  "7", "8", "9".
; @param    b      Pointer to divisor.
; @return   int    Returns the sum of `a` and `b` (i.e., `(a-r) + (b-r)`, 
;                  where `r` is the conversion factor (value of "0")).
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction5:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction5.



; 6. Byte Moving and Swapping.
;
; int studentFunction6(int a, int b);
;
; @brief    Function returns a number with the upper 2 bytes of `b` and the 
;           lower bytes of `a` but reversed. E.g., 
;           `studentFunction6(0xaabbccdd, 0x11223344)` should return 
;           `0x1122ddcc`.
;
; @param    a      Number with two lower bytes to use.
; @param    b      Number with two upper bytes to use.
; @return   int    Number comprised of two upper bytes of `b` and the reverse 
;                  of two lower bytes of `a`. 
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction6:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction6.



; 7. Return Address.
;
; int* studentFunction7(int* a);
;
; @brief    Returns the address of the fifth integer in the array pointed to 
;           by `a`.
;
; @param    a      Integer array.
; @return   int*   Pointer to fifth element in given integer array.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction7:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction7.



; 8. Sum Product.
; 
; long long studentFunction8(long long a, long long b);
;
; @brief    Returns the sum of `a`, `22`, and the product of `8` and `b`. 
;           This would be the result `a + 8*b + 22`.
;
; @param    a      addend.
; @param    b      Facter to multiply by `8`.
; @return   int    Result of the following calculation `a + 8*b + 22`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`, `int3`, `inc`, 
;       `dec`, `mul`, `imul`, `div`, `idiv`, `lea`, or `xchg`.
; RULE: Do not use jumps or loops at this time.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
; HINT: You can do this in one operation.
;
studentFunction8:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction8.



; ********************************* NOT USED **********************************
studentFunction9: ret
studentFunction10: ret



; End of file.
