
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-15 Loops - Application Lab
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
;;     _|_|      _|_|_|  _|      _|  
;;   _|    _|  _|        _|_|  _|_|  
;;   _|_|_|_|    _|_|    _|  _|  _|  
;;   _|    _|        _|  _|      _|  
;;   _|    _|  _|_|_|    _|      _| 
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



; 1. Power.
;
; unsigned int studentFunction1(unsigned int a, unsigned int b);
;
; @brief    Function executes exponentiation. Finds the `b`th power of `a`. 
;           In other words produces the result of `a` to the power of `b`. 
;           Only calculates positive exponentiation.
;
;           Pseudocode: `a**b` or `a*a` b times or `pow(a, b)` or `a^b` if `^` 
;           is the exponentiation operator.
;
; @param    a       The base.
; @param    b       The exponent.
; @return   int     Returns the power of `a` raised to the `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction1.



; 2. XOR String.
; 
; char* studentFunction2(char* string, size_t string_len, char key);
;
; @brief    Function `xor`s each character in the string with the given key 
;           byte.
;
; @param    string      Pointer to string to encrypt.
; @param    string_len  Length of string to encrypt.
; @param    key         Byte value to encrypt each character in string with.
; @return   char*       Returns pointer to encrypted string.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; HINT: You can use a for string or a `loop` to do the same action for a set 
;       number of characters.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction2.



; 3. Caesar Cipher 1.
;
; char* studentFunction3(char* string);
;
; @brief    Function encrypts the string using a "add-1" caesar-like cipher.
;           The string in null-terminated. This function does not rotate. In
;           other words `z` becomes `{`.
;
;           Example: `abcd` becomes `bcde`.
;
; @param    string  Pointer to string to add 1 to each character.
; @return   char*   Returns a pointer to the encrypted string.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; HINT: Use a while loop to continue traversing the string until you get to 
;       null byte sentinel character.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------

    

    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction3.



; 4. Number of Bits Set.
; 
; unsigned long long studentFunction4(unsigned long long a);
;
; @brief    Function returns the number of bits set in the given 64-bit number.
;
;           Example: `0x20` or `0b100000` has one bit set and the function 
;                    returns `1`.
;
; @param    a                   Number to calculate number of set bits for.
; @return   unsigned long long  Number of bits set in given number.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; HINT: You can use for loop to shift 64 times and `and` masking to check if a 
;       bit is set. Multiple other approaches available as well.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------

 

    ; --- Do not edit below this line -----------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.

; End studentFunction4.



; ********************************* NOT USED **********************************
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
