
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-13 Control Flow - Application Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.nasm
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
;;         _/_/      _/_/_/  _/      _/   
;;      _/    _/  _/        _/_/  _/_/    
;;     _/_/_/_/    _/_/    _/  _/  _/     
;;    _/    _/        _/  _/      _/      
;;   _/    _/  _/_/_/    _/      _/ 
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



; 1. Conditional Subtraction.
;
; long long studentFunction1(long long a, long long b);
;
; @brief    Function sums `a` and `b` and subtracts `1` from sum if `a` is 
;           positive.
;
;           Pseudocode: `return a + b - 1 if a >= 0 else a + b`.
;
; @param    a           Agend to add to `b` and value to test if positive. If 
;                       positive, subtract 1 from sum.
; @param    b           Addend to add to `a`.
; @return   long long   Returns `a + b` if `a` is negative; else returns 
;                       `a + b - 1` if `a` is positive.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; 2. Return 1 or 0.
; 
; long long studentFunction2(long long a, long long b);
;
; @brief    Function returns `1` if `a` is less than `b`. Otherwise returns `0`.
;
;           Pseudocode: `return 1 if a < b else 0`.
;
; @param    a           Argument to test if less than `b`.
; @param    b           Argument to test if greater than or equal to `a`.
; @return   long long   Returns `1` if `a` is less than `b`. 
;                       Otherwise returns `0`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction2.



; 3. Absolute Value.
;
; unsigned int studentFunction3(int a);
;
; @brief    Function returns the absolute value of `a`.
;
; @param    a               Number to return absolute value of.
; @return   unsigned int    Absolute value of `a`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------



    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction3.



; 4. If-Then-Else.
;
; long long studentFunction4(long long a, long long b);
;
; @brief    Function returns product of `a` and `b` if the sum of `a` and `b` 
;           is greater than 100, `a` shifted right by 4 bits if the difference 
;           between `a` and `b` is less than `0`, otherwise returns `0`.
; 
;           Pseudocode:
;               `if a + b > 100, return a * b
;               else if a - b < 0, return a >> 4
;               else return 0`
;
; @param    a           Argument to sum with `b` and multiplicand to multiply 
;                       with `b` if sum is greater than `100` or return value 
;                       to bit-shift right by `4` if difference betwen 
;                       argument and `b` is negative.
; @param    b           Argument to add to `a` to find if sum is greater than 
;                       `100` or argument to subtract from `a` to find if 
;                       difference is negative.
; @return   long long   Returns `a * b` if `a + b > 100`, else returns `a >> 4` 
;                       if `a - b < 0`, else returns `0`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction4.



; 5. Switch.
; 
; long long studentFunction5(char a, long long b, long long c);
;
; @brief    Function check character `a` for operation to perform on `b` and 
;           `c`. Accepted operators are '+', '-', '*' (multiply), '/' (integer 
;           division), '%' (modulo), or '^' (XOR addition). If an invalid 
;           operator is given, function returns special error code 
;           `0xbaddda7abaddda7a`. Returns error code `0x6469766572726f72` upon 
;           division by zero.
;
;           Pseudocode:
;               `if a == '+' return b + c
;               else if a == '-' return b - c
;               else if a == '*' return b * c
;               else if a == '/' and c == 0 return 0x6469766572726f72
;               else if a == '/' and c != 0 return b // c
;               else if a == '%' and c == 0 return 0x6469766572726f72
;               else if a == '%' and c != 0 return b mod c
;               else if a == '^' return b xor c
;               else return 0xbaddda7abaddda7a`.
;
; @param    a           Operator selector. May be '+', '-', '*', '/', '%', or 
;                       '^'.
; @param    b           First operand.
; @param    c           Second operand.
; @return   long long   Returns the selected operation result of the two 
;                       operands depending the the operator `a`. Returns sum 
;                       `b` and `c` if `a` is '+', the difference between `b` 
;                       and `c` if `a` is '-', the product of `b` and `c` if 
;                       `a` is '*', the integer quotient of `b` and `c` if `a` 
;                       is '/', the modulus of `b` and `c` if `a` is '%', the 
;                       XOR sum of `b` and `c` if `a` is '^', or the error 
;                       code `0xbaddda7abaddda7a` if an invalid code is given 
;                       in `a`. Function also returns the error code 
;                       `0x6469766572726f72` if division by zero occurs.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction5:

    ; --- Add your solution below this line -----------------------------------
    
    

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction5.



; ********************************* NOT USED **********************************
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
