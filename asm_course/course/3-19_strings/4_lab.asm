
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-19 Strings - Application Lab
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
;;    d888b8b   .d888b,  88bd8b,d88b 
;;   d8P' ?88   ?8b,     88P'`?8P'?8b
;;   88b  ,88b    `?8b  d88  d88  88P
;;   `?88P'`88b`?888P' d88' d88'  88b
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



; 1. Strlen.
; 
; unsigned int studentFunction1(char* str);
;
; @brief    Function returns string length of given null-terminated string 
;           pointed to by `str`. Length in bytes does not include the null 
;           terminator.
;
; @param    str             String to check length of.
; @return   unsigned int    Returns the length in bytes of `str`.
;
; TODO: Implement this function.
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



; 2. Strcpy.
; 
; char* studentFunction2(char* src, size_t src_len, char* dest)
;
; @brief    Function copies the source string to the destination buffer and 
;           returns a pointer to the buffer. The string is null-terminated.
;
; @param    src     Pointer to string to copy.
; @param    dest    Pointer to destination buffer.
; @return   char*   Returns a pointer to the destination buffer.
;
; TODO: Implement this function.
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



; 3. Strcmp.
; 
; int studentFunction3(char* str1, size_t str1_len, char* str2, size_t str2_len);
;
; @brief    Function compares the two given null-terminated strings and returns
;           `1` if they are identical and returns `0` if they are not.
;
; @param    str1        Pointer to first string.
; @param    str1_len    Length of `str1`.
; @param    str2        Pointer to second string.
; @param    str2_len    Length of `str2`.
; @return   int         Returns `1` if strings compared are the same; else
;                       returns `0`.
;
; TODO: Implement this function.
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



; ********************************* NOT USED **********************************
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
